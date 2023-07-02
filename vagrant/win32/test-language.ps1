$ErrorActionPreference = "Stop"

# Get the system language
$SystemLocale = (Get-WinSystemLocale).Name
Get-WinSystemLocale # display locale
chcp.com # display code page

$HereScript = $MyInvocation.MyCommand.Path
$HereDir = (get-item $HereScript).Directory

# ========================
# Configure installation

if (!(Test-Path "$env:ProgramData\DiskuvOCaml\conf")) {
  New-Item -ItemType Directory "$env:ProgramData\DiskuvOCaml\conf"
}

# +feature_flag_imprecise_c99_float_ops
#   configure: error: fma does not work, enable emulation with --enable-imprecise-c99-float-ops
# seems to be a problem with VirtualBox on macOS hardware
Set-Content `
  -Path "$env:ProgramData\DiskuvOCaml\conf\ocamlcompiler.sexp" `
  -Value "((feature_flag_imprecise_c99_float_ops))"

# +trust_anchor
$EscapedHereDir = "$HereDir".replace("\", "\\")
Set-Content `
  -Path "$env:ProgramData\DiskuvOCaml\conf\unixutils.sexp" `
  -Value "((trust_anchors (`"$EscapedHereDir\\mock-ca-cert.pem`")))"

# ========================
# START Install instructions from https://diskuv-ocaml.gitlab.io/distributions/dkml/index.html

#   --ci will skip confirmation question at end of setup.exe
$opts = "--ci"

if (Test-Path $HereDir\setup.exe) {
  Write-Output "Running supplied setup.exe ..."
  $SetupExe = "$HereDir\setup.exe"
} else {
  # Get the versions which can't be embedded in this UTF-16 BE file
  # (ex. UTF-16 BE encoding not supported by `bumpversion`)
  if (!(Test-Path -Path $HereDir\arpversion.txt)) {
    throw "Could not locate arpversion.txt in $HereDir"
  }
  $ArpVersion = (Get-Content $HereDir\arpversion.txt -TotalCount 1).Trim()
  if (!(Test-Path -Path $HereDir\tagversion.txt)) {
    throw "Could not locate tagversion.txt in $HereDir"
  }
  $TagVersion = (Get-Content $HereDir\tagversion.txt -TotalCount 1).Trim()

  $url = "https://github.com/diskuv/dkml-installer-ocaml/releases/download/$TagVersion/setup-diskuv-ocaml-windows_x86_64-$ArpVersion.exe"
  Write-Output "Downloading from $url ..."
  Invoke-WebRequest $url -OutFile "$env:TEMP\setup.exe"

  Write-Output "Running downloaded setup.exe ..."
  $SetupExe = "$env:TEMP\setup.exe"
}

& "$SetupExe" $opts
if ($lastexitcode -ne 0) {
  throw ("FATAL: setup.exe failed")
}


Write-Output "Done installation."

# END Install instructions
# ========================

# ========================
# START tests

# Refresh the PATH with newly installed User entries
$env:Path = [Environment]::GetEnvironmentVariable('PATH', 'User') + [System.IO.Path]::PathSeparator + $env:Path
# Mimic $DiskuvOCamlHome
$env:DiskuvOCamlHome = "$env:LOCALAPPDATA\Programs\DiskuvOCaml"

Write-Output "Printing installation ..."
opam var

Write-Output "Testing installation ..."
# Clean, run test for installation and save results
if (Test-Path C:\vagrant\test_installation.t\_build) {
  Remove-Item -Path C:\vagrant\test_installation.t\_build -Force -Recurse
}
dune runtest --root C:\vagrant\test_installation.t --display=short
if ($lastexitcode -ne 0) { throw ("FATAL: dune runtest failed") }
Set-Content -Path "C:\vagrant\test_installation.t\exitcode.$SystemLocale.txt" -Value $LastExitCode -NoNewline -Encoding Ascii

Write-Output "Done tests."

# END tests
# ========================

# ========================
# START stats

#   ex. 1463802570
$EstimatedSizeB = (Get-ChildItem $env:DiskuvOCamlHome -Recurse | Measure-Object -Property Length -Sum -ErrorAction Stop).Sum
#   ex. 1429494.69726563 (1.4 GB)
$EstimatedSizeKb = $EstimatedSizeB / 1KB
#   ex. estimated_byte_size_opt=Some 1463802570
Write-Output ("estimated_byte_size_opt=Some {0}L" -f $EstimatedSizeB)
#   ex. EstimatedSize=1,429,494.70 KB
Write-Output ("EstimatedSize={0:N2} KB" -f $EstimatedSizeKb)
#   ex. 0015cff6
$EstimatedSizeDwordKb = ("{0:x}" -f [int]$EstimatedSizeKb).PadLeft(8, "0")
Set-Content -Path "C:\vagrant\test_installation.t\estimatedsize.$SystemLocale.txt" `
  -Value "estimated_byte_size_opt=Some ${EstimatedSizeB}L`n`"EstimatedSize`"=dword:$EstimatedSizeDwordKb" `
  -NoNewline -Encoding Ascii

# END stats
# ========================

# ========================
# START installer for the second time
#
# We run the installer twice to make sure it can recover from partial
# attempts. It should be quicker (no Visual Studio install, no Git install)
# but still will be slow because setup-userprofile.ps1 is currently slow.

Write-Output "Rerunning setup.exe ..."

& "$SetupExe" $opts
if ($lastexitcode -ne 0) {
  throw ("FATAL: setup.exe rerun failed")
}

Write-Output "Done reinstallation."

# END uninstaller for the second time
# ========================


# ========================
# START uninstaller

if (Test-Path $HereDir\uninstall.exe) {
  Write-Output "Running supplied uninstall.exe ..."
  & "$HereDir\uninstall.exe" $opts

} else {
  # Get the versions which can't be embedded in this UTF-16 BE file
  # (ex. UTF-16 BE encoding not supported by `bumpversion`)
  if (!(Test-Path -Path $HereDir\arpversion.txt)) {
    throw "Could not locate arpversion.txt in $HereDir"
  }
  $ArpVersion = (Get-Content $HereDir\arpversion.txt -TotalCount 1).Trim()
  if (!(Test-Path -Path $HereDir\tagversion.txt)) {
    throw "Could not locate tagversion.txt in $HereDir"
  }
  $TagVersion = (Get-Content $HereDir\tagversion.txt -TotalCount 1).Trim()

  $url = "https://github.com/diskuv/dkml-installer-ocaml/releases/download/$TagVersion/uninstall-diskuv-ocaml-windows_x86_64-$ArpVersion.exe"
  Write-Output "Downloading from $url ..."
  Invoke-WebRequest $url -OutFile "$env:TEMP\uninstall.exe"

  Write-Output "Running uninstall.exe ..."
  & "$env:TEMP\uninstall.exe" $opts
}

Write-Output "Done uninstallation."

# END uninstaller
# ========================
