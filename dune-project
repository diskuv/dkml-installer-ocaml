(lang dune 2.9)

(name dkml-installer-ocaml-common)
(version 2.1.3)

(generate_opam_files true)

(source
 (github diskuv/dkml-installer-ocaml))
(license Apache-2.0)
(authors "Diskuv, Inc. <opensource+dkml@support.diskuv.com>")
(maintainers "opensource+dkml@support.diskuv.com")

(package
 (name dkml-installer-ocaml-common)
 (synopsis "Common code for the network and offline DkML installers for OCaml")
 (depends
  (odoc                                   (and (>= 1.5.3) :with-doc))
  (dkml-package-console                   (>= 0.5.2))
  (dkml-workflows                         (and (>= 1.1.0) :build))))

(package
 (name dkml-installer-ocaml-network)
 (synopsis "DkML network installer generator for OCaml")
 (description
  "Generates a network installer for OCaml, including Visual Studio and Git on Windows, and including a OCaml compiler built during installation time")
 (depends
  (odoc                                   (and (>= 1.5.3) :with-doc))
  (ocaml                                  (>= 4.12.1~))
  (dkml-installer-ocaml-common            (= :version))
  (dkml-component-ocamlcompiler-network   (and (>= 4.14.2~) (< 4.14.3~)))
  (dkml-component-offline-desktop-full    (>= 0.1.0))
  (dkml-component-offline-opamshim        (>= 2.2.0~alpha0~20221104))
  (dkml-install-installer                 (>= 0.5.2))))
