# DKML Installer for OCaml 0.4.0-prerel12

The DKML Installer for OCaml generates and distributes installers for OCaml.

## Releases

*When ready, this paragraph will be changed to a link to the latest installer.*

> You will be asked to accept a certificate from
> `Open Source Developer, Gerardo Grignoli` for the `gsudo` executable
> that was issued by
> `Certum Code Signing CA SHA2` if your machine does not already have a
> compatible Visual Studio.

## How it works

We use the [dkml-install-api](https://diskuv.github.io/dkml-install-api/index.html)
to generate installers from the following Opam packages:

* [dkml-component-ocamlrun](http://github.com/diskuv/dkml-component-ocamlcompiler)
* [dkml-component-ocamlcompiler](http://github.com/diskuv/dkml-component-ocamlcompiler)

## Building from Source

On Windows, if you have already installed OCaml:

```powershell
with-dkml opam install . --with-test --with-doc --deps-only
with-dkml dune build
```

On Unix:

```bash
opam install .--with-test --with-doc --deps-only
dune build
```

## Contributing

See [the Contributors section of dkml-install-api](https://github.com/diskuv/dkml-install-api/blob/main/contributors/README.md).

Any new dkml-components used by this installer will need an access token
(`repo public_repo`)
to automatically trigger builds, which you'll save as a repository secret
in your component. Create an issue to get access if you have a new
component that you would like to get distributed.

## Status

| What                           | Branch/Tag     | Status                                                                                                                                                                                                                                     |
| ------------------------------ | -------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Installer packages             |                | [![Package OCaml Releases](https://github.com/diskuv/dkml-installer-ocaml/actions/workflows/package.yml/badge.svg)](https://github.com/diskuv/dkml-installer-ocaml/actions/workflows/package.yml)                                          |
| Installer syntax check         |                | [![Syntax check](https://github.com/diskuv/dkml-installer-ocaml/actions/workflows/syntax.yml/badge.svg)](https://github.com/diskuv/dkml-installer-ocaml/actions/workflows/syntax.yml)                                                      |
| gitlab.com/diskuv/diskuv-ocaml | v0.4.0-prerel12 | [![gitlab.com/diskuv/diskuv-ocaml v0.4.0-prerel12 status](https://gitlab.com/diskuv/diskuv-ocaml/badges/v0.4.0-prerel12/pipeline.svg "legacy diskuv-ocaml v0.4.0-prerel12")](https://gitlab.com/diskuv/diskuv-ocaml/-/commits/v0.4.0-prerel12) |
