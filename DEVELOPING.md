# Development

## Troubleshooting GitHub CI

To troubleshoot problems with GitHub CI on Windows machines, you can test the
vast majority of the GitHub CI logic by following the instructions in
[package_win32_msys2.sh](.github/workflows/scripts/localdev/package_win32_msys2.sh)

Scripts for other operating systems should be easy to adapt.

## Opam Repositories

Currently only the Diskuv and the Opam repositories are used in the
[package.yml](.github/workflows/package.yml) GitHub CI installer
when [creating the installer Opam switch](.github/workflows/scripts/all_create_installer_opam_switch.sh)
; the fdopen repository is not needed.

Please keep it that way! If there is a patch for native Windows it should go
into the Diskuv repository or better yet in the Opam upstream repository.
