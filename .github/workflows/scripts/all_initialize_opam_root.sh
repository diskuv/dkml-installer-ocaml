#!/bin/sh
set -euf
set -x
PATH="$PWD/bootstrap/bin:$PATH"
if [ ! -e "$OPAMROOT/.ci.root-init" ]; then
  rm -rf "$OPAMROOT" # Clear any partial previous attempt
  if [ "$ISWINDOWS" = true ]; then
    opam init --disable-sandboxing --no-setup --kind local --bare "$(cygpath -am empty-opam-repository)"
    opam option --yes --global download-command=wget
  else
    opam init --disable-sandboxing --no-setup --kind local --bare "$PWD/empty-opam-repository"
  fi
  touch "$OPAMROOT/.ci.root-init"
fi
opam var --global || true
