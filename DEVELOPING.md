# Development

## Upgrading after a DKML (pre)release

```powershell
$workflowref = git ls-remote -q https://github.com/diskuv/dkml-workflows-prerelease.git refs/heads/v1 | foreach-object { echo $_.split()[0] } ; opam pin dkml-workflows git+https://github.com/diskuv/dkml-workflows-prerelease.git#$workflowref --yes ; opam exec -- generate-setup-dkml-scaffold ; echo "" > installer\bin\dune.inc ; opam exec -- dune clean ; opam exec -- dune build '@gen-dkml' --auto-promote
```

For a release (not a prerelease) you must also:

1. Increase the version in `dune-project`
2. Run `dune build *.opam`

Then `git commit` and `git tag`.

Finally `git push` and `git push origin NEWTAG`.

## Quick Upgrading

```powershell
dune clean
echo "" > installer\bin\dune.inc
dune build '@gen-dkml' --auto-promote
```

## Quick Testing on Windows

This assumes you have Diskuv OCaml already installed, and you already have
opened an Opam switch containing the `dkml-component-ocamlcompiler`
package.

```powershell
# Build
dune build

# Set variables that would have been present if running in a DKML Opam switch
# a. export VCToolsRedistDir so Visual C++ Redistributables can be found
# b. locate mt.exe which is used to modify Windows executables
$env:VCToolsRedistDir = with-dkml sh -c 'echo $VCToolsRedistDir'
$windowskit = with-dkml sh -c 'command -v mt | cygpath -aw -f -' | Split-Path

# Create installer for 64-bit Windows
$old = $env:PATH ; $env:PATH += ";$windowskit" ; & "with-dkml" "rm" "-rf" _build/t _build/w ; & "with-dkml" install "-d" _build/t _build/w ; & "_build/install/default/bin/dkml-install-create-installers.exe" `
    --opam-context "$env:OPAM_SWITCH_PREFIX" `
    --program-version 0.4.0 --abi=windows_x86_64 --component "ocamlcompiler-network" `
    --work-dir _build/w --target-dir _build/t `
    --runner-admin-exe "_build/install/default/bin/dkml-install-admin-runner.exe" `
    --runner-user-exe "_build/install/default/bin/dkml-install-user-runner.exe" `
    --packager-install-exe "_build/install/default/bin/dkml-install-package-install.exe" `
    --packager-uninstall-exe "_build/install/default/bin/dkml-install-package-uninstall.exe" `
    --packager-setup-bytecode "_build/install/default/bin/dkml-install-package-setup.bc.exe" `
    --packager-uninstaller-bytecode "_build/install/default/bin/dkml-install-package-uninstaller.bc.exe" `
    -vv ; $env:PATH = $old
```

The new Windows installers will be in `_build/t` and the work files will be in `_build/w`.

Both the installer and the uninstaller will modify your PATH and other environment variables.
Before running them you should save the environment variables in the "e" folder:

```powershell
& "with-dkml" install "-d" _build/e
Set-Content _build\e\PATH -NoNewline -Value                 ([Environment]::GetEnvironmentVariable("PATH", "User"))
Set-Content _build\e\DiskuvOCamlHome -NoNewline -Value      ([Environment]::GetEnvironmentVariable("DiskuvOCamlHome", "User"))
Set-Content _build\e\DiskuvOCamlVersion -NoNewline -Value   ([Environment]::GetEnvironmentVariable("DiskuvOCamlVersion", "User"))
```

Then extract the installer. We don't need to extract the uninstaller since
the uninstaller will be given to us automatically when we run the installer:

```powershell
& "with-dkml" rm "-rf" _build/i _build/u
& "..\dkml-install-api\package\console\create\assets\lzma2107\bin\7zr.exe" -o_build\i x "_build\t\i-unsigned-diskuv-ocaml-windows_x86_64-0.4.0.exe"
#& "..\dkml-install-api\package\console\create\assets\lzma2107\bin\7zr.exe" -o_build\u x "_build\t\u-unsigned-diskuv-ocaml-windows_x86_64-0.4.0.exe"
```

Run the installer with:

```powershell
& "_build\i\setup.exe" --prefix _build\p -v -v
```

Then run the uninstaller:

```powershell
& "_build\p\uninstall.exe" --prefix _build\p -v -v
```

Finally restore the environment variables with:

```powershell
[Environment]::SetEnvironmentVariable("PATH",               (Get-Content _build\e\PATH), "User")
[Environment]::SetEnvironmentVariable("DiskuvOCamlHome",    (Get-Content _build\e\DiskuvOCamlHome), "User")
[Environment]::SetEnvironmentVariable("DiskuvOCamlVersion", (Get-Content _build\e\DiskuvOCamlVersion), "User")
$env:OPAM_SWITCH_PREFIX =                                   (Get-Content _build\e\OPAM_SWITCH_PREFIX)
```
