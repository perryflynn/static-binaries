#!/bin/bash

set -e
set -u

key=$(realpath "$1")
keydearm=$(realpath "${key}.gpg")
sig=$(realpath "$2")
file=$(realpath "$3")

gpg --no-default-keyring --yes -o "$keydearm" --dearmor "$key"
gpg -vv --no-default-keyring --keyring "$keydearm" --verify "$sig" "$file"
