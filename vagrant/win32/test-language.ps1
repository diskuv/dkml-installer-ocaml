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
  Write-Host "Running supplied setup.exe ..."
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
  Write-Host "Downloading from $url ..."
  Invoke-WebRequest $url -OutFile "$env:TEMP\setup.exe"

  Write-Host "Running setup.exe ..."
  & "$env:TEMP\setup.exe" $opts
}

Write-Host "Done installation."

# END Install instructions
# ========================

# Refresh the PATH with newly installed User entries
$env:Path = [Environment]::GetEnvironmentVariable('PATH', 'User') + [System.IO.Path]::PathSeparator + $env:Path
# Mimic $DiskuvOCamlHome
$env:DiskuvOCamlHome = "$env:LOCALAPPDATA\Programs\DiskuvOCaml\0"

Write-Host "Testing installation ..."
# Clean, run test for installation and save results
dune clean --root C:\vagrant\test_installation.t
dune runtest --root C:\vagrant\test_installation.t
Set-Content -Path "C:\vagrant\test_installation.t\exitcode.$SystemLocale.txt" -Value $LastExitCode -NoNewline -Encoding Ascii

Write-Host "Testing playground ..."
# Run through a simple playground
(Test-Path -Path C:\vagrant\playground) -or $(New-Item C:\vagrant\playground -ItemType Directory)
Set-Location C:\vagrant\playground          # aka. cd playground
$env:OPAMYES = "1"                          # aka. OPAMYES=1 opam dkml init ...
opam dkml init --build-type=Release --yes # `Release` option is present simply to test CLI option handling of opam dkml init
opam install graphics --yes       # install something with a low number of dependencies, that sufficienly exercises Opam

Write-Host "Done tests."
