# The OPAMROOT and OPAMSWITCH variables must be set to the switch to copy from, and
# the 'opam' executable must be in the PATH.
#
# Test on Win32 with:
# cmake --log-context -D DRYRUN=1 -D CMAKE_MESSAGE_CONTEXT=dkml-installer-ocaml -D TEMP_DIR=$env:TEMP -D DKML_VERSION_OPAMVER_NEW=2.0.2 -D GIT_EXECUTABLE=git -D OPAM_EXECUTABLE=../../../build/pkg/bump/.ci/sd4/bs/bin/opam.exe -D WITH_COMPILER_SH=../../../build/pkg/bump/with-compiler.sh -D "BASH_EXECUTABLE=cmake;-E;env;CHERE_INVOKING=yes;MSYSTEM=CLANG64;MSYS2_ARG_CONV_EXCL=*;../../../build/pkg/bump/msys64/usr/bin/bash.exe;-l" -D DKML_RELEASE_DUNE_VERSION=3.6.2 -D DKML_BUMP_PACKAGES_PARTICIPANT_MODULE=../../../pkg/bump/DkMLBumpPackagesParticipant.cmake -P bump-packages.cmake
# and Unix with:
# cmake --log-context -D DRYRUN=1 -D CMAKE_MESSAGE_CONTEXT=dkml-installer-ocaml -D TEMP_DIR=$TEMP -D DKML_VERSION_OPAMVER_NEW=2.0.2 -D GIT_EXECUTABLE=git -D OPAM_EXECUTABLE=opam -D WITH_COMPILER_SH=../../../build/pkg/bump/with-compiler.sh -D BASH_EXECUTABLE=bash -D DKML_RELEASE_DUNE_VERSION=3.6.2 -D DKML_BUMP_PACKAGES_PARTICIPANT_MODULE=../../../pkg/bump/DkMLBumpPackagesParticipant.cmake -P bump-packages.cmake

cmake_policy(SET CMP0011 NEW) # Included scripts do automatic cmake_policy PUSH and POP

if(NOT DKML_BUMP_PACKAGES_PARTICIPANT_MODULE)
    message(FATAL_ERROR "Missing -D DKML_BUMP_PACKAGES_PARTICIPANT_MODULE=.../DkMLBumpPackagesParticipant.cmake")
endif()

include(${DKML_BUMP_PACKAGES_PARTICIPANT_MODULE})

DkMLBumpPackagesParticipant_DuneIncUpgrade(
    REL_FILENAMES i-network/bin/dune-common.inc i-network/bin/dune.inc
    DUNE_TARGET @i-network/bin/gen-dkml
)
DkMLReleaseParticipant_DuneBuildOpamFiles() # Must come after dune.inc has been rebuilt and made valid
DkMLBumpPackagesParticipant_GitAddAndCommit()
