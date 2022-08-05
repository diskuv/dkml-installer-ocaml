# Source

1. The `32x32.ico` in this directory was obtained from https://github.com/ocaml/ocaml-logo/tree/master/Colour/Favicon
2. Since the file was PNG image data (the extension was confusing!) we needed to
   convert it to a MS Windows icon resource file (`assets/32x32-win32-icon.ico` directory).

   In DKML we did this with from this directory:

   ```console
   $ with-dkml pacman -S mingw-w64-clang-x86_64-imagemagick
   :: Processing package changes...
   $ with-dkml magick png:32x32.ico assets/32x32-win32-icon.ico
   ```

Verify with:

```console
$ with-dkml file 32x32.ico assets/32x32-win32-icon.ico
32x32.ico:                   PNG image data, 32 x 32, 8-bit/color RGBA, non-interlaced
assets/32x32-win32-icon.ico: MS Windows icon resource - 1 icon, 32x32, 32 bits/pixel
```
