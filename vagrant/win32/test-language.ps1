$ErrorActionPreference = "Stop"

# Get the system language
$SystemLocale = (Get-WinSystemLocale).Name
Get-WinSystemLocale # display locale
chcp.com # display code page

$HereScript = $MyInvocation.MyCommand.Path
$HereDir = (get-item $HereScript).Directory

# ========================
# START Install instructions from https://diskuv.gitlab.io/diskuv-ocaml/index.html

#   --ci will skip confirmation question at end of setup.exe
$opts = "--ci"

if (Test-Path $HereDir\setup.exe) {
  Write-Output "Running supplied setup.exe ..."
  & "$HereDir\setup.exe" $opts

} else {
  # Get the versions which can't be embedded in this UTF-16 BE file
  # (ex. UTF-16 BE encoding not supported by `bumpversion`)
  if (!(Test-Path -Path $HereDir\opamversion.txt)) {
    throw "Could not locate opamversion.txt in $HereDir"
  }
  $OpamVersion = (Get-Content $HereDir\opamversion.txt -TotalCount 1).Trim()
  if (!(Test-Path -Path $HereDir\tagversion.txt)) {
    throw "Could not locate tagversion.txt in $HereDir"
  }
  $TagVersion = (Get-Content $HereDir\tagversion.txt -TotalCount 1).Trim()

  $url = "https://github.com/diskuv/dkml-installer-ocaml/releases/download/$TagVersion/setup-diskuv-ocaml-windows_x86_64-$OpamVersion.exe"
  Write-Output "Downloading from $url ..."
  Invoke-WebRequest $url -OutFile "$env:TEMP\setup.exe"

  Write-Output "Running setup.exe ..."
  & "$env:TEMP\setup.exe" $opts
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
$opamroot = opam var root

Write-Output "Testing installation ..."
# Clean, run test for installation and save results
dune clean --root C:\vagrant\test_installation.t
if ($lastexitcode -ne 0) { throw ("FATAL: dune clean failed") }
dune runtest --root C:\vagrant\test_installation.t --display=short
if ($lastexitcode -ne 0) { throw ("FATAL: dune runtest failed") }
Set-Content -Path "C:\vagrant\test_installation.t\exitcode.$SystemLocale.txt" -Value $LastExitCode -NoNewline -Encoding Ascii

Write-Output "Testing otherplayground ..."
# Run through a simple playground ... different from the auto-installed 'playground' switch ...
# where we can test a new switch being created
(Test-Path -Path C:\vagrant\otherplayground) -or $(New-Item C:\vagrant\otherplayground -ItemType Directory)
Set-Location C:\vagrant\otherplayground     # aka. cd playground
$env:OPAMYES = "1"                          # aka. OPAMYES=1 opam dkml init ...
opam dkml init --build-type=Release --yes # `Release` option is present simply to test CLI option handling of opam dkml init
if ($lastexitcode -ne 0) { throw ("FATAL: opam dkml init failed") }
opam install graphics --yes       # install something with a low number of dependencies, that sufficienly exercises Opam
if ($lastexitcode -ne 0) {
  Write-Output "----- TROUBLESHOOTING: dune-*-*.out ----"
  Get-ChildItem "$opamroot\log" -Filter "dune-*-*.out" | ForEach-Object { Write-Output "[BEGIN $_]" ; Get-Content $_; Write-Output "[END $_]`n" }
  throw ("FATAL: opam install graphics failed")
}
opam install ppx_jane --yes       # regression test: https://discuss.ocaml.org/t/ann-diskuv-ocaml-1-x-x-windows-ocaml-installer-no-longer-in-preview/10309/8?u=jbeckford
if ($lastexitcode -ne 0) { throw ("FATAL: opam install ppx_jane failed") }

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
# START uninstaller

if (Test-Path $HereDir\uninstall.exe) {
  Write-Output "Running supplied uninstall.exe ..."
  & "$HereDir\uninstall.exe" $opts

} else {
  # Get the versions which can't be embedded in this UTF-16 BE file
  # (ex. UTF-16 BE encoding not supported by `bumpversion`)
  if (!(Test-Path -Path $HereDir\opamversion.txt)) {
    throw "Could not locate opamversion.txt in $HereDir"
  }
  $OpamVersion = (Get-Content $HereDir\opamversion.txt -TotalCount 1).Trim()
  if (!(Test-Path -Path $HereDir\tagversion.txt)) {
    throw "Could not locate tagversion.txt in $HereDir"
  }
  $TagVersion = (Get-Content $HereDir\tagversion.txt -TotalCount 1).Trim()

  $url = "https://github.com/diskuv/dkml-installer-ocaml/releases/download/$TagVersion/uninstall-diskuv-ocaml-windows_x86_64-$OpamVersion.exe"
  Write-Output "Downloading from $url ..."
  Invoke-WebRequest $url -OutFile "$env:TEMP\uninstall.exe"

  Write-Output "Running uninstall.exe ..."
  & "$env:TEMP\uninstall.exe" $opts
}

Write-Output "Done uninstallation."

# END uninstaller
# ========================
