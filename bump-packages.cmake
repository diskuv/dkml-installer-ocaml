# The OPAMROOT and OPAMSWITCH variables must be set to the switch to copy from, and
# the 'opam' executable must be in the PATH.
#
# Test with:
# cmake --log-context -D DRYRUN=1 -D CMAKE_MESSAGE_CONTEXT=dkml-installer-ocaml -D GIT_EXECUTABLE=git -D OPAM_EXECUTABLE=opam -D DKML_RELEASE_DUNE_VERSION=3.6.2 -D DKML_BUMP_PACKAGES_PARTICIPANT_MODULE=../../../pkg/bump/DkMLBumpPackagesParticipant.cmake -P bump-packages.cmake

if(NOT DKML_BUMP_PACKAGES_PARTICIPANT_MODULE)
    message(FATAL_ERROR "Missing -D DKML_BUMP_PACKAGES_PARTICIPANT_MODULE=.../DkMLBumpPackagesParticipant.cmake")
endif()

include(${DKML_BUMP_PACKAGES_PARTICIPANT_MODULE})

DkMLReleaseParticipant_DuneBuildOpamFiles()
DkMLBumpPackagesParticipant_DuneIncUpgrade(
    REL_FILENAMES installer/bin/dune-common.inc installer/bin/dune.inc
    DUNE_TARGET @installer/bin/gen-dkml
)
DkMLBumpPackagesParticipant_GitAddAndCommit()
