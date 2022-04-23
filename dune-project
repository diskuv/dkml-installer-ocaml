(lang dune 2.9)

(name dkml-installer-network-ocaml)
(version 0.4.0)

; NOTE 1
; Since *.opam.template does not support build:[] steps
; (at least in Dune 2.9.3) we cannot use --relocatable as in:
;   ["dune" "install" "-p" name "--relocatable" "--create-install-files" name]
; So we cannot do:
;  (generate_opam_files true)
;
; NOTE 2
; We are no longer using Dune plugins, so we should go back to
; generate_opam_files

(package
 (name dkml-installer-network-ocaml))

; (source
;  (github diskuv/dkml-installer-ocaml))
; (license Apache-2.0)
; (authors "Diskuv, Inc. <opensource+diskuv-ocaml@support.diskuv.com>")
; (maintainers "opensource+diskuv-ocaml@support.diskuv.com")
;
; (package
;  (name dkml-installer-network-ocaml)
;  (synopsis "DKML installer generator for OCaml")
;  (description
;   "The DKML Installer for OCaml generates installers for OCaml")
;  (depends
;   (odoc                                   (and (>= 1.5.3) :with-doc))
;   ; Dune 2.9.1 and 3.0.2 will fail to build jst-config.v0.14.1 because for jst-config/discover/discover.ml Dune does:
;   ;   cl -nologo -O2 -Gy- -MD    -I Z:/.opam-root-cached-8/installer-ocaml/lib/ocaml -o C:\Users\beckf\AppData\Local\Temp\build_f18aec_dune\ocaml-configurator4d3858\c-test-31\test.obj -c C:\Users\beckf\AppData\Local\Temp\build_f18aec_dune\ocaml-configurator4d3858\c-test-31\test.c advapi32.lib ws2_32.lib version.lib
;   ; instead of
;   ;   cl -nologo -O2 -Gy- -MD    -I Z:/.opam-root-cached-8/installer-ocaml/lib/ocaml /FoC:\Users\beckf\AppData\Local\Temp\build_f18aec_dune\ocaml-configurator4d3858\c-test-31\test.obj -c C:\Users\beckf\AppData\Local\Temp\build_f18aec_dune\ocaml-configurator4d3858\c-test-31\test.c advapi32.lib ws2_32.lib version.lib
;   ; with the (irrelevant) test.c file:
;   ;    #include <stdio.h>
;   ;    #include <caml/config.h>
;   ;  
;   ;    #ifdef ARCH_BIG_ENDIAN
;   ;    const char *s0 = "BEGIN-0-true-END";
;   ;    #else
;   ;    const char *s0 = "BEGIN-0-false-END";
;   ;    #endif
;   ;  
;   ;    #ifdef ARCH_SIXTYFOUR
;   ;    const char *s1 = "BEGIN-1-true-END";
;   ;    #else
;   ;    const char *s1 = "BEGIN-1-false-END";
;   ;    #endif
;   ;
;   ; The actual problem is dune-configurator ... we only have patches in Diskuv
;   ; repository up until 2.9.3. Need to upstream fix the problem.
;   (dune                                   (= 2.9.3))
;   (dune-configurator                      (= 2.9.3))
;   ; Only patch in Diskuv repository is for v0.14.1. Need to upstream fix the problem.
;   (ppx_expect                             (= v0.14.1))  
;   (dkml-base-compiler                     (= 4.12.1))
;   (conf-dkml-cross-toolchain              (= 4.12.1))
;   (dkml-component-network-ocamlcompiler   (= 4.12.1))
;   (dkml-install-runner                    (>= 0.1.0))
;   (dkml-package-console                   (>= 0.1.0))
;   (diskuvbox                              (>= 0.1.0))))
