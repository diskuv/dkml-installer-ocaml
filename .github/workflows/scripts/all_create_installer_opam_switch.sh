#!/bin/sh
[ -d "$OPAMROOT/installer-$INSTALLERNAME/.opam-switch" ] || PATH="$PWD/bootstrap/bin:$PATH" opam switch create installer-$INSTALLERNAME --repos diskuv,default --empty
