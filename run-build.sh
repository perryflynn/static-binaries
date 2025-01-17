#!/bin/bash

set -u
set -e

BASEIMAGE=reg.git.brickburg.de/bbcontainers/hub/alpine:3
OWNBASEIMAGE=static-binaries-alpine:latest
cpuparallel=3
ARCH=amd64

cd "$(dirname "$0")"

# build base
cd src/base-alpine
docker --debug buildx build -t "$OWNBASEIMAGE" --progress=plain --build-arg BASEIMAGE=$BASEIMAGE .

# build requested binary
cd ../..
folder=${1:-}

if [ ! -n "$folder" ] || [ ! -d "src/$folder" ]; then
    echo "unknown container folder '$folder'"
    exit 1
fi

cd src/$folder

uidimage=static-binary-$folder:latest
docker buildx build -t "$uidimage" --progress=plain \
    --build-arg ARCH=$ARCH --build-arg BASEIMAGE=$OWNBASEIMAGE --build-arg PARALLEL=$cpuparallel .

# extract result
cd ../..
mkdir -p dist

uidname=static-binary-extract-$folder
docker run -d --rm --name "$uidname" "$uidimage" /bin/sleep 300
sleep 3

docker cp $uidname:/dist/. dist/
docker stop $uidname
sleep 3

docker image rm "$uidimage"

echo
cat dist/.version-$folder.$ARCH
