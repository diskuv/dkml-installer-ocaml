# DKML Installer for OCaml 0.1.0

The DKML Installer for OCaml generates and distributes installers for OCaml.

## Releases

## How it works

We use the [dkml-install-api](https://diskuv.github.io/dkml-install-api/index.html)
to generate installers from the following Opam packages:

* [dkml-component-ocamlrun](http://github.com/diskuv/dkml-component-ocamlrun)
* [dkml-component-compiler](http://github.com/diskuv/dkml-component-compiler)
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
