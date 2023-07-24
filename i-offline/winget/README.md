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
winget validate --manifest installer/winget/manifest
```

Test a change with:

```powershell
winget install --manifest installer/winget/manifest
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
if (Test-Path ..\di-ocaml) {$DIOCAML="..\di-ocaml"} else {$DIOCAML="..\dkml-installer-ocaml"}
.\Tools\SandboxTest.ps1 "$DIOCAML\installer\winget\manifest"
```

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
