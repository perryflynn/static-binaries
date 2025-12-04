#!/bin/bash

set -u
set -e

echo -n "Before stripping: "
ls -lisaF "$1"

ORGSIZE=$(stat -c '%s' "$1")

strip --strip-all --strip-section-headers --strip-debug --strip-dwo --strip-unneeded \
    --merge-notes --enable-deterministic-archives \
    --discard-all --discard-locals "$1"

NEWSIZE=$(stat -c '%s' "$1")

echo -n "After stripping: "
ls -lisaF "$1"

echo "Saved: $(($ORGSIZE - $NEWSIZE)) bytes = $((100 * $(($ORGSIZE - $NEWSIZE)) / $ORGSIZE))%"

echo -n "File Info: "
file "$1"
