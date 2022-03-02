#!/bin/sh
untarxz() {
  prefix=$1; shift
  ver=$1; shift
  curl -L -o $prefix$ver-x86_64.pkg.tar.xz https://mirror.msys2.org/msys/x86_64/$prefix$ver-x86_64.pkg.tar.xz
  tar xfCJ $prefix$ver-x86_64.pkg.tar.xz /
  rm -f $prefix$ver-x86_64.pkg.tar.xz
}
untarzst() {
  prefix=$1; shift
  ver=$1; shift
  curl -L -o $prefix$ver-x86_64.pkg.tar.zst https://mirror.msys2.org/msys/x86_64/$prefix$ver-x86_64.pkg.tar.zst
  tar xfC $prefix$ver-x86_64.pkg.tar.zst / --use-compress-program='zstd -d'
  rm -f $prefix$ver-x86_64.pkg.tar.zst
}
untarzst_mingw() {
  prefix=$1; shift
  ver=$1; shift
  curl -L -o $prefix$ver-x86_64.pkg.tar.zst https://mirror.msys2.org/mingw/mingw64/mingw-w64-x86_64-$prefix$ver.pkg.tar.zst
  tar xfC $prefix$ver-x86_64.pkg.tar.zst / --use-compress-program='zstd -d'
  rm -f $prefix$ver-x86_64.pkg.tar.zst
}
untarxz tree- "$TREE_VER"
untarzst wget- "$WGET_VER"
untarzst libpcre2_ "$LIBPCRE2_VER"
untarzst make- "$MAKE_VER"
untarzst rsync- "$RSYNC_VER"
untarzst libzstd- "$LIBZSTD_VER"
untarzst libxxhash- "$LIBXXHASH_VER"
untarzst_mingw pkg-config- "$PKGCONFIG_VER"
