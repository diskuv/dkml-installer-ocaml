#!/bin/sh
set -euf

# This script runs package.yml on your local Windows machine; great for
# local testing.
#
# You will need:
#   * Visual Studio 2019 Community or Visual Studio 2019 Enterprise installed
#     in the default location on the C: drive with the following components:
#       * Microsoft.VisualStudio.Component.VC.Tools.x86.x64
#           - VS 2019 C++ x64/x86 build tools (v14.25)
#       * Microsoft.VisualStudio.Component.Windows10SDK.18362
#           - Windows 10 SDK (10.0.18362.0)
#   * to run this script from Git Bash
#   * you will need to rename MSYS2's /usr/bin/link.exe to
#     /usr/bin/link.orig.exe using an Administrator PowerShell session
#   * source the windows_var.source.sh
#     (. '.github/workflows/scripts/localdev/windows_vars.source.sh')
#     and then run 'win32_install_tool.sh'
#     using an Administrator PowerShell session
#
# Then you can run the following in Git Bash:
#
#   . '.github/workflows/scripts/localdev/windows_vars.source.sh'
#   .github/workflows/scripts/localdev/package_win32_msys2.sh
#
# There are some destructive operations:
#   1. Extra binaries are installed in Git Bash _only if you are root_
#   2. MSYS2's /usr/bin/link.exe is removed (but first backed up to
#       /usr/bin/link.orig.exe)
#
# And you may need to edit `windows_vars.source.sh` to be in sync with
# the GitHub CI job you are troubleshooting, and perhaps this
# `package_win32_msys2.sh` script as well if it is not in sync with
# `package.yml`
HERE=$(dirname "$0")
HERE=$(cd "$HERE" && pwd)

# shellcheck disable=SC1091
. "$HERE"/windows_vars.source.sh

# shellcheck disable=SC2154
install -d "$ci_drive"/a/dkml-installer-ocaml
cd "$ci_drive"/a/dkml-installer-ocaml

# --> Deleting the contents of 'D:\a\dkml-installer-ocaml\dkml-installer-ocaml'
rm -rf dkml-installer-ocaml

# --> Initializing the repository
git init dkml-installer-ocaml
cd dkml-installer-ocaml
git remote add origin https://github.com/diskuv/dkml-installer-ocaml

# --> Fetching the repository
git -c protocol.version=2 fetch --no-tags --prune --progress --no-recurse-submodules --depth=1 origin

# --> Checking out the ref
git checkout --progress --force -B main refs/remotes/origin/main

# --> "C:\Program Files (x86)\Microsoft Visual Studio\Installer\vswhere.exe" -all -products "*"
"C:\Program Files (x86)\Microsoft Visual Studio\Installer\vswhere.exe" -all -products "*"
ls -l "$VS_DIR_UNESCAPED\VC\Tools\MSVC"
ls -l "C:\Program Files (x86)\Windows Kits\10\Include"

# --> Run untarxz
# Need something like sudo for MSYS@: "$HERE/../win32_install_tools.sh"

# --> Run rm -vf /usr/bin/link.exe
if [ -e /usr/bin/link.exe ]; then
    mv -v /usr/bin/link.exe /usr/bin/link.orig.exe
fi

# --> Run set -x (Bootstrap Opam from historical release)
# shellcheck disable=SC2154
ABI="$opam_abi" VER="$bootstrap_opam_version" "$HERE/../all_bootstrap_opam_from_historical_release.sh"

# --> Initialize Opam root
ISWINDOWS=true "$HERE/../all_initialize_opam_root.sh"

# --> Setup Opam repositories
"$HERE/../all_setup_opam_repositories.sh"

# --> Create installer Opam switch
"$HERE/../all_create_installer_opam_switch.sh"

# --> Pin dkml-component-ocamlrun/etc. to source instead of Opam repository
PATH="$PWD/bootstrap/bin:$PATH" opam pin add --yes --no-action dkml-component-ocamlrun "git://github.com/diskuv/dkml-component-ocamlcompiler.git#${DKML_COMPONENT_OCAMLRUN:-main}"
PATH="$PWD/bootstrap/bin:$PATH" opam pin add --yes --no-action dkml-component-ocamlcompiler "git://github.com/diskuv/dkml-component-ocamlcompiler.git#${DKML_COMPONENT_OCAMLCOMPILER:-main}"
PATH="$PWD/bootstrap/bin:$PATH" opam pin add --yes --no-action dkml-install "git://github.com/diskuv/dkml-install-api.git#${DKML_INSTALL:-main}"
PATH="$PWD/bootstrap/bin:$PATH" opam pin add --yes --no-action dkml-install-runner "git://github.com/diskuv/dkml-install-api.git#${DKML_INSTALL_RUNNER:-main}"
PATH="$PWD/bootstrap/bin:$PATH" opam pin add --yes --no-action dkml-base-compiler "git://github.com/diskuv/dkml-compiler.git#${DKML_BASE_COMPILER:-main}"
PATH="$PWD/bootstrap/bin:$PATH" opam pin add --yes --no-action conf-dkml-cross-toolchain "git://github.com/diskuv/dkml-compiler.git#${CONF_DKML_CROSS_TOOLCHAIN:-main}"
PATH="$PWD/bootstrap/bin:$PATH" opam pin add --yes --no-action ocaml.4.12.1 "git://github.com/diskuv/dkml-compiler.git#${TEMP_OCAML:-main}"
PATH="$PWD/bootstrap/bin:$PATH" opam pin add --yes --no-action dkml-option-32bit "git://github.com/diskuv/dkml-compiler.git#${DKML_OPTION_32BIT:-main}"

# --> Pin ocamlfind
PATH="$PWD/bootstrap/bin:$PATH"
opam pin add --yes --no-action -k version ocamlfind "$PIN_OCAMLFIND"
opam pin add --yes --no-action -k version ocamlbuild "$PIN_OCAMLBUILD"

# --> Use Visual Studio in DKML Opam packages
PATH="$PWD/bootstrap/bin:$PATH"
opam option setenv= # reset
opam option setenv+='DKML_COMPILE_SPEC = "1"'
opam option setenv+='DKML_COMPILE_TYPE = "VS"'
opam option setenv+="DKML_COMPILE_VS_DIR = \"$VS_DIR\""
opam option setenv+="DKML_COMPILE_VS_VCVARSVER = \"$VS_VCVARSVER\""
opam option setenv+="DKML_COMPILE_VS_WINSDKVER = \"$VS_WINSDKVER\""
opam option setenv+='DKML_COMPILE_VS_MSVSPREFERENCE = "VS16.6"'
opam option setenv+='DKML_COMPILE_VS_CMAKEGENERATOR = "Visual Studio 16 2019"'
opam option setenv+="DKML_HOST_ABI = \"$M_DKMLTARGETABI\""
opam option setenv # print

# --> Build installer for Windows
win32_build_installer_cmd=$(cygpath -aw "$HERE"/../win32_build_installer.cmd)
VSCMD_SKIP_SENDTELEMETRY=1 MSYSTEM=MINGW64 MSYSTEM_CARCH=x86_64 MSYSTEM_CHOST=x86_64-w64-mingw32 MSYSTEM_PREFIX=/mingw64 "$win32_build_installer_cmd"
