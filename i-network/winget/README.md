# winget

The files in the `manifest/` directory are published to Microsoft. See
[Authoring Manifest](https://github.com/microsoft/winget-pkgs/blob/master/AUTHORING_MANIFESTS.md)
for more details.

## Testing

### Prerequisites

You will need *once* as Administrator to run the following:

```powershell
winget settings --enable LocalManifestFiles

Enable-WindowsOptionalFeature -Online -FeatureName 'Containers-DisposableClientVM'
```

to avoid the errors:

> This feature needs to be enabled by administrators. To enable it, run 'winget settings --enable LocalManifestFiles' as administrator
>
> Windows Sandbox does not seem to be available.

### Actual Testing

Validate any changes with:

```powershell
winget validate --manifest i-network/winget/manifest
```

Test a change with:

```powershell
winget install --manifest i-network/winget/manifest
```

### Troubleshooting with Windows Sandbox

> Never use Windows Sandbox as your final test before releasing to end-users.
> Instead run the installer on your own machine.
>
> And if you don't want to install it on your local machine:
> why would you be comfortable asking other Windows users to install it?

The instructions below are from <https://github.com/microsoft/winget-pkgs> and
include some suggestions from <https://github.com/microsoft/winget-pkgs/pull/69112>:

FIRST clone the `winget-pkgs` repository alongside the `dkml-installer-ocaml`
directory with:

```powershell
cd dkml-installer-ocaml
cd ..
git clone https://github.com/microsoft/winget-pkgs.git
```

SECOND, run the manifest in the sandbox:

```powershell
if (Test-Path ..\dkml\build\_deps\dkml-installer-ocaml-src) {$DIOCAML="..\dkml\build\_deps\dkml-installer-ocaml-src"} else {$DIOCAML="..\dkml-installer-ocaml"}
.\Tools\SandboxTest.ps1 "$DIOCAML\i-network\winget\manifest"
```

That will auto-install WinGet and the DkML package in a PowerShell window. You can re-use that PowerShell window
after a successful installation by typing `Update-EnvironmentVariables`, or open a new PowerShell window. Either
way, you can start using the commands like `utop` and `opam`.

If the installer fails with:

![Search for app in the Store](https://user-images.githubusercontent.com/71855677/184410812-08ba2ab8-8c3d-490d-8c38-b6b3a6df41a4.png)

then you will need to do the following inside the Windows Sandbox:

```powershell
# Disable the Smart Screen especially on Windows 11
if (($env:USERNAME -eq "WDAGUtilityAccount") -or ($PWD.Path -eq "C:\Users\WDAGUtilityAccount\Desktop\winget-pkgs")) {
    foreach ($drive in @("HKLM", "HKCU")) {
        $path = "SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer"
        $key = Get-Item -LiteralPath ${drive}:\${path}
        if (($key.GetValue("SmartScreenEnabled", $null) -eq $null) -or
            -not(Get-ItemProperty -Path ${drive}:\${path} -Name SmartScreenEnabled))
        {
            Set-ItemProperty -Path ${drive}:\${path} -Name SmartScreenEnabled -Value Off -Force
            Write-Host "${drive}:\${path} SmartScreenEnabled=Off"
        }
    }
}

# Rerun the installer; if you are prompted for security now you'll be able to click through it
winget install --manifest ..\SandboxTest\manifest
```

## To Organize

Comments should not be in the `.yaml` files.

```yaml
# file: Diskuv.OCaml.yaml
# Created using wingetcreate 1.1.2.0
```

```yaml
# file: Diskuv.OCaml.locale.en-US.yaml

# Created using wingetcreate 1.1.2.0
#   Publisher
#     Keep in sync with installer\src\private_common.ml "organization" which is used by
#     https://github.com/diskuv/dkml-install-api/blob/main/package/console/common/Windows_registry.ml
Publisher: Diskuv, Inc.
```

```yaml
# file: Diskuv.OCaml.installer.yaml
# Created using wingetcreate 1.1.2.0
# Follow:
#   https://docs.microsoft.com/en-us/windows/package-manager/package/manifest?tabs=minschema%2Cversion-example#tips-and-best-practices
#   https://github.com/microsoft/winget-pkgs/tree/master/doc/manifest/schema/1.2.0#best-practices
# Reference: https://github.com/microsoft/winget-pkgs/blob/master/doc/manifest/schema/1.2.0/installer.md

Commands:
  # PATH entry: <DiskuvOCamlHome>/bin
  # BUT ... already a [winget install opam] so do not register those commands!
  # - opam
  # - opam-installer
  # - opam-putenv

  # PATH entry: <DiskuvOCamlHome>/usr/bin
  # BUT 1 ... max 16 entries in Commands:[] so took only the most commonly used
  # BUT 2 ... will be a [winget install dune] so do not register those commands!
  # - dune

  # BUT 3 ... ocamldoc is essentially deprecated by odoc
  # - ocamldoc
  # BUT 4 ... native code tools are created at shim stage by [dkml init] or the shims [dune] or [opam]
  # - ocamlopt
  # - ocamlopt.opt

  # BUT 5 ... with-dkml is deprecated and will be rolled into dkml
  # - with-dkml

# Minimum OS comes from https://github.com/diskuv/dkml-runtime-distribution/blob/ff7e6bcbf3dbdb37e64b20a57e2dea0fa9d27ed5/src/windows/Machine/Machine.psm1#L14:
# > $Windows10SdkVer = "18362"
MinimumOSVersion: 10.0.18362.0

# Dependencies:
# ExternalDependencies:
#   - Microsoft.VisualStudio.2019.BuildTools
#   - Git.Git
# PackageDependencies:
#   # ---- Visual Studio Redistributable ----
#   # > The Microsoft Visual C++ 2015-2022 Redistributable Package (x64) installs runtime components of Visual C++ Libraries required to run 64-bit applications developed with Visual C++ 2015, 2017, 2019 and 2022 on a computer that does not have Visual C++ 2015, 2017, 2019 and 2022 installed.
#   # - PackageIdentifier: Microsoft.VC++2015-2022Redist-x64

#   # ---- Visual Studio Build Tools ----
#   # Minimum comes from https://github.com/diskuv/dkml-runtime-distribution/blob/ff7e6bcbf3dbdb37e64b20a57e2dea0fa9d27ed5/src/windows/Machine/Machine.psm1#L94-L105:
#   # > $VcStudioVcToolsMajorVer = 16
#   # > $VcStudioVcToolsMinorVer = 6
#   - PackageIdentifier: Microsoft.VisualStudio.2019.BuildTools
#     MinimumVersion: 16.6.0

#   # ---- Git ----
#   # Minimum comes from https://github.com/diskuv/dkml-component-ocamlcompiler/blob/66af047444345a012213980269faffdf8ea83fb0/assets/staging-files/win32/setup-userprofile.ps1#L602-605
#   - PackageIdentifier: Git.Git
#     MinimumVersion: 2.34.0

```
