# Development

## Quick Testing on Windows

This assumes you have Diskuv OCaml already installed.

```powershell
# Build
with-dkml dune build

# Set variables that would have been present if running in a DKML Opam switch
# a. export VCToolsRedistDir so Visual C++ Redistributables can be found
# b. locate mt.exe which is used to modify Windows executables
$env:VCToolsRedistDir = with-dkml sh -c 'echo $VCToolsRedistDir'
$windowskit = with-dkml sh -c 'command -v mt | cygpath -aw -f -' | Split-Path

# Create installer for 64-bit Windows
$old = $env:PATH ; $env:PATH += ";$windowskit" ; with-dkml rm -rf _build/t _build/w ; with-dkml install -d _build/t _build/w ; _build/install/default/bin/dkml-install-create-installers.exe `
    --program-version 0.4.0 --abi=windows_x86_64 `
    --work-dir _build/w --target-dir _build/t `
    --runner-admin-exe _build/install/default/bin/dkml-install-admin-runner.exe `
    --runner-user-exe _build/install/default/bin/dkml-install-user-runner.exe `
    --packager-entry-exe _build/install/default/bin/dkml-install-package-entry.exe `
    --packager-setup-bytecode _build/install/default/bin/dkml-install-package-setup.bc.exe `
    --packager-uninstaller-bytecode _build/install/default/bin/dkml-install-package-uninstaller.bc.exe `
    -vv ; $env:PATH = $old
```

The new Windows installers will be in `_build/t` and the work files will be in `_build/w`.
