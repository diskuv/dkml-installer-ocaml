#!/bin/sh
PATH="$PWD/bootstrap/bin:$PATH"
set "-x"
if [ ! -e "$OPAMROOT/.ci.repo-init" ]; then
  opam repository remove default --yes --all --dont-select || true
  opam repository remove diskuv --yes --all --dont-select || true
  opam repository add default https://opam.ocaml.org --yes --dont-select
  opam repository add diskuv "git+https://github.com/diskuv/diskuv-opam-repository.git#${DISKUV_OPAM_REPOSITORY:-$DEFAULT_DISKUV_OPAM_REPOSITORY_TAG}" --yes --dont-select
  touch "$OPAMROOT/.ci.repo-init"
fi
