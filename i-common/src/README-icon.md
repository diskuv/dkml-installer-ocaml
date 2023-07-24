# Icon

## Source

We do not use the OCaml logo, like we did with dkml-installer-opam, because DKML
is clearly Diskuv. We even use the `dkml-base-compiler` rather than the vanilla
OCaml compiler.

The `android-chrome-circle.png` is a high-res Diskuv logo with a white circle.

## Conversion

> Even though the DKML Install API says 32x32, Windows supports 256x256. Confer:
> <https://learn.microsoft.com/en-us/windows/win32/uxguide/vis-icons#size-requirements>
> and
> <https://en.wikipedia.org/wiki/ICO_(file_format)>

We'll use the Slack icon sizes (in the registry at `HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall\slack`
as the `DisplayIcon` value):

```console
$ with-dkml magick identify "C:\Users\somebody\AppData\Local\slack\app.ico"
C:\Users\somebody\AppData\Local\slack\app.ico[0] PNG 256x256 256x256+0+0 8-bit sRGB 18023B 0.000u 0:00.001
C:\Users\somebody\AppData\Local\slack\app.ico[1] ICO 128x128 128x128+0+0 8-bit sRGB 0.016u 0:00.011
C:\Users\somebody\AppData\Local\slack\app.ico[2] ICO 64x64 64x64+0+0 8-bit sRGB 0.016u 0:00.020
C:\Users\somebody\AppData\Local\slack\app.ico[3] ICO 48x48 48x48+0+0 8-bit sRGB 0.016u 0:00.029
C:\Users\somebody\AppData\Local\slack\app.ico[4] ICO 32x32 32x32+0+0 8-bit sRGB 0.016u 0:00.038
C:\Users\somebody\AppData\Local\slack\app.ico[5] ICO 16x16 16x16+0+0 8-bit sRGB 117717B 0.016u 0:00.046
```

We needed to convert the source PNG to a MS Windows icon resource file (`assets/win32-icon.ico`).

In DKML we did this with from this directory in PowerShell:

```sh
with-dkml pacman -S mingw-w64-clang-x86_64-imagemagick
:: Processing package changes...

with-dkml magick android-chrome-circle.png -resize 256x256 assets/app-256.ico
with-dkml magick android-chrome-circle.png -resize 128x128 assets/app-128.ico
with-dkml magick android-chrome-circle.png -resize 64x64 assets/app-64.ico
with-dkml magick android-chrome-circle.png -resize 48x48 assets/app-48.ico
with-dkml magick android-chrome-circle.png -resize 32x32 -sharpen 0x8.0 assets/app-32.ico
with-dkml magick android-chrome-circle.png -resize 16x16 -sharpen 0x4.0 assets/app-16.ico
with-dkml magick assets/app-256.ico assets/app-128.ico assets/app-64.ico assets/app-48.ico assets/app-32.ico assets/app-16.ico assets/win32-icon.ico
with-dkml rm assets/app-256.ico assets/app-128.ico assets/app-64.ico assets/app-48.ico assets/app-32.ico assets/app-16.ico
```

## Verification


```console
$ with-dkml magick identify android-chrome-circle.png assets/win32-icon.ico
android-chrome-circle.png PNG 608x608 608x608+0+0 8-bit sRGB 47223B 0.000u 0:00.000
assets/win32-icon.ico[0] PNG 256x256 256x256+0+0 8-bit sRGB 18755B 0.000u 0:00.002
assets/win32-icon.ico[1] ICO 128x128 128x128+0+0 8-bit sRGB 0.000u 0:00.010
assets/win32-icon.ico[2] ICO 64x64 64x64+0+0 8-bit sRGB 0.000u 0:00.017
assets/win32-icon.ico[3] ICO 48x48 48x48+0+0 8-bit sRGB 0.000u 0:00.023
assets/win32-icon.ico[4] ICO 32x32 32x32+0+0 8-bit sRGB 0.000u 0:00.029
assets/win32-icon.ico[5] ICO 16x16 16x16+0+0 8-bit sRGB 118449B 0.000u 0:00.036
```
