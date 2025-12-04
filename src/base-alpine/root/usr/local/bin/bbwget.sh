#!/bin/bash

set -u
set -e

SOURCE=$1
DEST=$2

if [ ! -f "$DEST" ] || [ ! -f "${DEST}.success" ]; then
    echo "Download '$SOURCE' to '$DEST'"
    wget --continue -O "$DEST" "$SOURCE"
    touch "${DEST}.success"
else
    echo "Skipping '$SOURCE', as it already exists"
fi
