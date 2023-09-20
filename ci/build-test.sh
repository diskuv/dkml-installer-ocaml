#!/bin/sh
set -euf

usage() {
  echo 'build-test.sh --opam-package PACKAGE --program-name-kebab NAME' >&2
  exit 2
}
fail() {
  echo "Error: $*" >&2
  exit 3
}

export OPAM_PACKAGE=
export PROGRAM_NAME_KEBAB=

OPTIND=1
while getopts :h-: option; do
  case $option in
  h) usage ;;
  -) case $OPTARG in
    opam-package) fail "Option \"$OPTARG\" missing argument" ;;
    opam-package=*) OPAM_PACKAGE=${OPTARG#*=} ;;
    program-name-kebab) fail "Option \"$OPTARG\" missing argument" ;;
    program-name-kebab=*) PROGRAM_NAME_KEBAB=${OPTARG#*=} ;;
    help) usage ;;
    help=*) fail "Option \"${OPTARG%%=*}\" has unexpected argument" ;;
    *) fail "Unknown long option \"${OPTARG%%=*}\"" ;;
    esac ;;
  '?') fail "Unknown short option \"$OPTARG\"" ;;
  :) fail "Short option \"$OPTARG\" missing argument" ;;
  *) fail "Bad state in getopts (OPTARG=\"$OPTARG\")" ;;
  esac
done
shift $((OPTIND - 1))

if [ -z "$OPAM_PACKAGE" ]; then
  fail "Missing --opam-package option"
fi
if [ -z "$PROGRAM_NAME_KEBAB" ]; then
  fail "Missing --program-name-kebab option"
fi

# shellcheck disable=SC2154
echo "
=============
build-test.sh
=============
.
---------
Arguments
---------
OPAM_PACKAGE=${OPAM_PACKAGE}
PROGRAM_NAME_KEBAB=${PROGRAM_NAME_KEBAB}
.
------
Matrix
------
dkml_host_abi=$dkml_host_abi
abi_pattern=$abi_pattern
opam_root=$opam_root
exe_ext=${exe_ext:-}
.
"

# Set project directory
if [ -n "${CI_PROJECT_DIR:-}" ]; then
  PROJECT_DIR="$CI_PROJECT_DIR"
elif [ -n "${PC_PROJECT_DIR:-}" ]; then
  PROJECT_DIR="$PC_PROJECT_DIR"
elif [ -n "${GITHUB_WORKSPACE:-}" ]; then
  PROJECT_DIR="$GITHUB_WORKSPACE"
else
  PROJECT_DIR="$PWD"
fi
if [ -x /usr/bin/cygpath ]; then
  PROJECT_DIR=$(/usr/bin/cygpath -au "$PROJECT_DIR")
fi

# PATH. Add opamrun
export PATH="$PROJECT_DIR/.ci/sd4/opamrun:$PATH"

# Initial Diagnostics (optional but useful)
opamrun switch
opamrun list
opamrun var
opamrun config report
opamrun option
opamrun exec -- ocamlc -config

# Update
opamrun update

# Build the installer
case "$dkml_host_abi" in
  linux_*) opamrun install ./dkml-installer-ocaml-common.opam "./${OPAM_PACKAGE}.opam" --with-test --yes --no-depexts ;;
  *) opamrun install ./dkml-installer-ocaml-common.opam "./${OPAM_PACKAGE}.opam" --with-test --yes ;;
esac

# Generate and print a .locked file
opamrun lock "${OPAM_PACKAGE}"
cat "${OPAM_PACKAGE}.opam.locked"

# Examine the installer
_share=$(opamrun var "${OPAM_PACKAGE}:share")
opamrun install diskuvbox --yes
opamrun exec -- diskuvbox tree -d 6 --encoding UTF-8 "$_share"

# Finalize and distribute the Console installer (each type of installer has its unique finalization procedure)
install -d dist
case "$dkml_host_abi" in
  linux_*)
    opamrun exec -- "$_share/t/bundle-${PROGRAM_NAME_KEBAB}-$dkml_host_abi-i.sh" -o dist -e .tar.gz tar --gzip
    opamrun exec -- "$_share/t/bundle-${PROGRAM_NAME_KEBAB}-$dkml_host_abi-u.sh" -o dist -e .tar.gz tar --gzip
    ;;
  darwin*)
    opamrun exec -- "$_share/t/bundle-${PROGRAM_NAME_KEBAB}-$dkml_host_abi-i.sh" -o dist -e .tar.gz -t bsd tar --gzip
    opamrun exec -- "$_share/t/bundle-${PROGRAM_NAME_KEBAB}-$dkml_host_abi-u.sh" -o dist -e .tar.gz -t bsd tar --gzip
    ;;
  windows_*)
    opamrun exec -- find "$_share"/t -maxdepth 1 -name "unsigned-${PROGRAM_NAME_KEBAB}-$dkml_host_abi-i-*.exe" -exec install {} dist/ \;
    opamrun exec -- find "$_share"/t -maxdepth 1 -name "unsigned-${PROGRAM_NAME_KEBAB}-$dkml_host_abi-u-*.exe" -exec install {} dist/ \;
    opamrun exec -- find "$_share"/t -maxdepth 1 -name "${PROGRAM_NAME_KEBAB}-$dkml_host_abi-i-*.sfx" -exec install {} dist/ \;
    opamrun exec -- find "$_share"/t -maxdepth 1 -name "${PROGRAM_NAME_KEBAB}-$dkml_host_abi-u-*.sfx" -exec install {} dist/ \;
    ;;
esac
