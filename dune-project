(lang dune 2.9)

(name dkml-installer-network-ocaml)
(version 1.1.0)

(generate_opam_files true)

(source
 (github diskuv/dkml-installer-ocaml))
(license Apache-2.0)
(authors "Diskuv, Inc. <opensource+diskuv-ocaml@support.diskuv.com>")
(maintainers "opensource+diskuv-ocaml@support.diskuv.com")

(package
 (name dkml-installer-network-ocaml)
 (synopsis "DKML installer generator for OCaml")
 (description
  "The DKML Installer for OCaml generates installers for OCaml")
 (depends
  (odoc                                   (and (>= 1.5.3) :with-doc))
  ; Only patches in Diskuv repository are for v0.14.1, v0.14.2 and v0.15.1.
  ; Need to upstream fix the problem.
  (ppx_expect                             (or (or (= v0.14.1) (= v0.14.2)) (= v0.15.1)))
  (ocaml                                  (>= 4.12.1~))
  (dkml-component-network-ocamlcompiler   (and (>= 4.14.0~) (< 4.14.1~)))
  (dkml-component-offline-desktop-full    (>= 0.1.0))
  (dkml-component-offline-opamshim        (>= 2.2.0~alpha0~20221104))
  (dkml-install-installer                 (>= 0.3.0))
  (dkml-package-console                   (>= 0.3.0))
  ; crunch 3.2.0 has problems with reading CRLF on Windows
  (crunch                                 (>= 3.3.1))
  (alcotest                               (and (>= 1.4.0) :with-test))))
