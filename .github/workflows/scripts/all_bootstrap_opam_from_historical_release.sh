#!/bin/sh
set -euf
set -x
install -d bootstrap
cd bootstrap
ABI=${ABI:-$M_DKMLTARGETABI} # default to the target abi
if [ ! -e ocaml-$ABI-$VER.tar.gz ]; then
  curl -L -o ocaml-$ABI-$VER.tmp.tar.gz https://github.com/diskuv/dkml-installer-ocaml/releases/download/v$VER/ocaml-$ABI-$VER.tar.gz
  mv ocaml-$ABI-$VER.tmp.tar.gz ocaml-$ABI-$VER.tar.gz
  rm -f bin/opam bin/opam.exe
fi
if [ ! -e bin/opam ] && [ ! -e bin/opam.exe ]; then
  tar xfz ocaml-$ABI-$VER.tar.gz --strip-components=2
fi
