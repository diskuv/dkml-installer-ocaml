# DKML Installer for OCaml 0.4.0-prerel2

The DKML Installer for OCaml generates and distributes installers for OCaml.

## Releases

## How it works

We use the [dkml-install-api](https://diskuv.github.io/dkml-install-api/index.html)
to generate installers from the following Opam packages:

* [dkml-component-ocamlrun](http://github.com/diskuv/dkml-component-ocamlcompiler)
* [dkml-component-ocamlcompiler](http://github.com/diskuv/dkml-component-ocamlcompiler)
* [dkml-component-ocamlsystem](http://github.com/diskuv/dkml-component-ocamlsystem)
* [dkml-component-dksdk](http://gitlab.com/diskuv/dkml-component-dksdk)

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

See [the Contributors section of dkml-install-api](http://github.com/diskuv/dkml-install-api/contributors/README.md).

Any new dkml-components used by this installer will need an access token
(`repo public_repo`)
to automatically trigger builds, which you'll save as a repository secret
in your component. Create an issue to get access if you have a new
component that you would like to get distributed.

## Status

| What                           | Branch/Tag | Status                                                                                                                                                                                             |
| ------------------------------ | ---------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| gitlab.com/diskuv/diskuv-ocaml | v0.4.0-prerel2   | [![gitlab.com/diskuv/diskuv-ocaml v0.4.0-prerel2 status](https://gitlab.com/diskuv/diskuv-ocaml/badges/v0.4.0-prerel2/pipeline.svg "legacy diskuv-ocaml v0.4.0-prerel2")](https://gitlab.com/diskuv/diskuv-ocaml/-/commits/v0.4.0-prerel2) |

