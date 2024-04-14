# Test with:
# cmake --log-context -D DRYRUN=1 -D CMAKE_MESSAGE_CONTEXT=dkml-installer-ocaml -D "regex_DKML_VERSION_SEMVER=1[.]2[.]1-[0-9]+" -D "regex_DKML_VERSION_OPAMVER=1[.]2[.]1[~]prerel[0-9]+" -D DKML_VERSION_SEMVER_NEW=1.2.1-3 -D DKML_VERSION_OPAMVER_NEW=1.2.1~prerel3 -D GIT_EXECUTABLE=git -D DKML_RELEASE_OCAML_VERSION=4.14.0 -D DKML_BUMP_VERSION_PARTICIPANT_MODULE=../../../pkg/bump/DkMLBumpVersionParticipant.cmake -P bump-version.cmake

if(NOT DKML_BUMP_VERSION_PARTICIPANT_MODULE)
    message(FATAL_ERROR "Missing -D DKML_BUMP_VERSION_PARTICIPANT_MODULE=.../DkMLBumpVersionParticipant.cmake")
endif()
include(${DKML_BUMP_VERSION_PARTICIPANT_MODULE})

DkMLBumpVersionParticipant_PlainReplace(dkml-installer-ocaml-network.opam.template)

DkMLBumpVersionParticipant_PlainReplace(i-common/src/version.ml)

DkMLBumpVersionParticipant_PlainReplace(i-network/winget/manifest/Diskuv.OCaml.installer.yaml)
DkMLBumpVersionParticipant_PlainReplace(i-network/winget/manifest/Diskuv.OCaml.locale.en-US.yaml)
DkMLBumpVersionParticipant_PlainReplace(i-network/winget/manifest/Diskuv.OCaml.yaml)
DkMLBumpVersionParticipant_ReleaseDateReplace(i-network/winget/manifest/Diskuv.OCaml.installer.yaml)
DkMLBumpVersionParticipant_CopyrightReplace(i-network/winget/manifest/Diskuv.OCaml.locale.en-US.yaml)

DkMLBumpVersionParticipant_DuneProjectReplace(dune-project)
DkMLBumpVersionParticipant_GitAddAndCommit()
