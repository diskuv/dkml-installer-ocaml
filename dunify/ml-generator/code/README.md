# Application Manifest

On Windows 10 and 11 we want setup.exe (the setup-proxy), when downloaded from
the Internet, to open a UTF-8 terminal windows. Without a manifest we can
get garbled output from ANSI escape sequences and any UTF-8 characters.

A manifest sets the use of a UTF-8 code page as per
https://docs.microsoft.com/en-us/windows/apps/design/globalizing/use-utf8-code-page

It also sets the version of the application.

To view an Application Manifest on Windows, or to sign it, make sure
any ".NET Framework <VERSION> SDK" component is installed with the
Visual Studio Installer. That will give you Mage.exe and MageUI.exe.
Confer: https://docs.microsoft.com/en-us/dotnet/framework/tools/mageui-exe-manifest-generation-and-editing-tool-graphical-client

To extract the manifest file:

```powershell
& "C:\Program Files (x86)\Windows Kits\10\bin\10.0.19041.0\x64\mt.exe" `
    '-inputresource:Z:\source\dkml-install-api\_build\install\default\bin\dkml-install-admin-runner.exe;#1' `
    -out:admin2.manifest
```
