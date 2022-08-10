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

See https://github.com/microsoft/winget-pkgs for how to install it in
a Window Sandbox. But ... if you don't want to install it on your local machine
... why would you be comfortable asking other Windows users to install it?
