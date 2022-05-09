#!/bin/sh

if [ -e /z ]; then
    export ci_drive=Z:
elif [ -e /d ]; then
    export ci_drive=D:
else
    export ci_drive=C:
fi

export bootstrap_opam_version="0.0.0"
export opam_abi=windows_x86 #_64

export DEFAULT_DISKUV_OPAM_REPOSITORY_TAG=v0.4.0
export PIN_OCAMLFIND=1.9.1
export PIN_OCAMLBUILD=0.14.0
export INSTALLERNAME=ocaml
export SHOULD_POPULATE_CACHE=true
export CAN_DOWNLOAD_ONLY=
export DKML_COMPONENT_OCAMLRUN=
export DKML_COMPONENT_OCAMLCOMPILER=
export DKML_INSTALL=
export DKML_INSTALL_RUNNER=
export DKML_BASE_COMPILER=
export TEMP_OCAML=
export TEMP_OCAML_CONFIG=
export DISKUV_OPAM_REPOSITORY=
export CONF_DKML_CROSS_TOOLCHAIN=
export DKML_OPTION_32BIT=
export OPAM_ROOT_CACHE_NUMBER=8
export OPAMROOT="$ci_drive/.opam-root-cached-$OPAM_ROOT_CACHE_NUMBER"
if [ -e "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Enterprise" ]; then
    export VS_DIR='C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Enterprise'
    export VS_DIR_UNESCAPED="C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Enterprise"
else
    export VS_DIR='C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community'
    export VS_DIR_UNESCAPED="C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community"
fi
export VS_HOST_ARCH=x86
export VS_ARCH=x86
export VS_VCVARSVER=14.25
export VS_WINSDKVER=10.0.18362.0
export M_DKMLOPTIONS=
export M_DKMLTARGETABI=windows_x86
export HOMEBREW_NO_INSTALL_CLEANUP=1

export TREE_VER=1.8.0-1
export WGET_VER=1.21.2-1
export MAKE_VER=4.3-3
export LIBPCRE2_VER=8-10.35-1
export RSYNC_VER=3.2.3-2
export LIBZSTD_VER=1.5.1-1
export LIBXXHASH_VER=0.8.1-1
