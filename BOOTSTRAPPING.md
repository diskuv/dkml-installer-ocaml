# Bootstrapping

## Opam

Opam is needed to complete the install steps, but Opam (and the rest
of a basic OCaml system) is supplied by this installer. So there is a
chicken-and-egg problem.

All we need is a working Opam, even an old one.

We solve the chicken-and-egg problem in two different ways:

* Use the system package manager (`apt`, `yum`, `brew`) to get an old Opam
* The [0.0.0 pre-release](#000-pre-release) for manually uploaded Windows
  binaries. It can be extended to other OS-es that do not have a
  package manager distributed Opam

### 0.0.0 pre-release

The first **0.0.0** pre-release was manually uploaded using the Opam from the original Diskuv OCaml GitLab preview.

Specifically the contents came from (which may no longer be available):

* the **32-bit** Opam binary distribution of <https://gitlab.com/api/v4/projects/diskuv%2Fdiskuv-ocaml/packages/generic/opam-reproducible/v0.3.3/opam-windows_x86.zip>
* the **64-bit** Opam binary distribution of <https://gitlab.com/api/v4/projects/diskuv%2Fdiskuv-ocaml/packages/generic/opam-reproducible/v0.3.3/opam-windows_x86_64.zip>

The .zip files were re-packaged into the Console Installer format:

* `opam-windows_x86.zip:bin/opam.exe`    -> `ocaml-windows_x86-0.0.0.tar.gz:ocaml-windows_x86-0.0.0/static-files/bin/opam.exe`
* `opam-windows_x86_64.zip:bin/opam.exe` -> `ocaml-windows_x86_64-0.0.0.tar.gz:ocaml-windows_x86_64-0.0.0/static-files/bin/opam.exe`
