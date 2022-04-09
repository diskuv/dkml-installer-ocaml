This directory exists so that GitHub Actions (or GitLab CI) can checkout
any pinned directories using an authenticated `git` client. Relying on
Opam to do a `git checkout` during an `opam pin` is flaky on GitHub Actions.

Since Dune searches all subdirectories, we have to stop Dune from exploring
this directory.
