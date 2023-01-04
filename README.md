# DKML Installer for Diskuv OCaml

The Diskuv OCaml distribution is an open-source set of software
that supports software development in pure OCaml. The distribution's
strengths are its:
* full compatibility with OCaml standards like Opam, Dune and ocamlfind
* laser focus on "native" development (desktop software, mobile apps and embedded software) through support for the standard native compilers like Visual Studio
  and Xcode
* ease-of-use through simplified installers and simple productivity commands; high school, college and university students should be
  able to use it
* security through reproducibility, versioning and from-source builds

These alternatives may be better depending on your use case:
* Developing in a Javascript first environment? Have a look at [Esy and Reason](https://esy.sh/)
* Developing operating system kernels? Have a look at [Mirage OS](https://mirage.io/)
* Developing Linux server software like web servers? Plain old [OCaml on Debian, etc.](https://ocaml.org/docs/up-and-running) works well
* Writing compilers or proofs? Plain old OCaml works really well
* Wanting quick installations? *Use anything but Diskuv OCaml!* Diskuv OCaml will conduct
  from-source builds unless it can guarantee (and code sign) the binaries are
  reproducible. Today that means a lot of compiling.

The DKML Installer for OCaml generates and distributes installers for 
the Diskuv OCaml distribution. Windows is ready today; macOS will be available soon.

For news about Diskuv OCaml, 
[![Twitter URL](https://img.shields.io/twitter/url/https/twitter.com/diskuv.svg?style=social&label=Follow%20%40diskuv)](https://twitter.com/diskuv) on Twitter.

## Installing

**Windows user?**

Briefly review the following:

> You need to **stay at your computer** and press "Yes" for any Windows security popups;
> after the DKML installer finishes with two programs (`Visual Studio Installer`
> and `Git for Windows`) you can leave your computer for the remaining two (2) hours.

> First time installations may get a notification printed in red. If you see it, reboot your
> computer and then restart your installation so that Visual Studio Installer
> can complete. The notification looks like:
> 
> ```diff
> - FATAL [118acf2a]. The machine needs rebooting.
> - ...
> - >>> The machine needs rebooting. <<<
> -         ...
> -         FATAL [5f927a8b].
> -         A transient failure occurred.
> -         ...
> -         >>> A transient failure occurred. <<<
> ```

> You may be asked to accept a certificate from
> `Open Source Developer, Gerardo Grignoli` for the `gsudo` executable
> that was issued by
> `Certum Code Signing CA SHA2`.

Then run the [latest Windows 64-bit installer](https://github.com/diskuv/dkml-installer-ocaml/releases/download/v1.1.0_r2/setup-diskuv-ocaml-windows_x86_64-1.1.0.exe).

Now that your install is completed, you can read the
[Install is done! What next?](https://diskuv-ocaml.gitlab.io/distributions/dkml/#install-is-done-what-next)
documentation.

---

The full set of releases is at https://github.com/diskuv/dkml-installer-ocaml/releases

The full documentation is at https://diskuv-ocaml.gitlab.io/distributions/dkml/#introduction

## Sponsor

<a href="https://ocaml-sf.org">
<img align="left" alt="OCSF logo" src="https://ocaml-sf.org/assets/ocsf_logo.svg"/>
</a>
Thanks to the <a href="https://ocaml-sf.org">OCaml Software Foundation</a>
for economic support to the development of Diskuv OCaml.
<p/>

## How the installer is built

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

The installer makes heavy use of the dkml-install-api.
See [the Contributors section of dkml-install-api](https://github.com/diskuv/dkml-install-api/blob/main/contributors/README.md).

Any new dkml-components used by this installer will need an access token
(`repo public_repo`)
to automatically trigger builds, which you'll save as a repository secret
in your component. Create an issue to get access if you have a new
component that you would like to get distributed.

In addition, there are

* [code signing documents](contributors/BINARY_SIGNING.md)
* [winget package submission documents](installer/winget/README.md)
 
## Status

| What                   | Branch/Tag | Status                                                                                                                                                                                            |
| ---------------------- | ---------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Installer packages     |            | [![Package OCaml Releases](https://github.com/diskuv/dkml-installer-ocaml/actions/workflows/package.yml/badge.svg)](https://github.com/diskuv/dkml-installer-ocaml/actions/workflows/package.yml) |
| Installer syntax check |            | [![Syntax check](https://github.com/diskuv/dkml-installer-ocaml/actions/workflows/syntax.yml/badge.svg)](https://github.com/diskuv/dkml-installer-ocaml/actions/workflows/syntax.yml)             |
