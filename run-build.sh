#!/bin/bash

set -u
set -e

cd "$(dirname "$0")"

# command line and ENV arguments
# usage: ./run-build.sh <foldername> <architecture> <optional special mode>
cpuparallel=${PARALLEL:-1}
FOLDER=${1:-}
ARCH="${2:-}"
MODE="${3:-}"

if [ ! -n "$ARCH" ]; then
    ARCH=amd64
fi

# configuration by architecture
if [ "$ARCH" == "x86" ]; then
    BASEIMAGE=reg.git.brickburg.de/bbcontainers/hub/i386/alpine:3
    OWNBASEIMAGE=static-binaries-alpine-x86:latest
    PLATFORM=linux/386
elif [ "$ARCH" == "aarch64" ]; then
    BASEIMAGE=reg.git.brickburg.de/bbcontainers/hub/arm64v8/alpine:3
    OWNBASEIMAGE=static-binaries-alpine-aarch64:latest
    PLATFORM=linux/arm64/v8
elif [ "$ARCH" == "armv7" ]; then
    BASEIMAGE=reg.git.brickburg.de/bbcontainers/hub/arm32v7/alpine:3
    OWNBASEIMAGE=static-binaries-alpine-armv7:latest
    PLATFORM=linux/arm/v7
elif [ "$ARCH" == "amd64" ]; then
    BASEIMAGE=reg.git.brickburg.de/bbcontainers/hub/alpine:3
    OWNBASEIMAGE=static-binaries-alpine-amd64:latest
    PLATFORM=linux/amd64
else
    echo "Unsupported architecture: $ARCH"
    exit 1
fi

# define exit trap
uidimage=static-binary-$FOLDER:latest
uidname=static-binary-extract-$FOLDER

cleanup() {
    docker stop $uidname || true
    sleep 3
    docker image rm "$uidimage" || true
}

trap cleanup EXIT

# binfmt images and architectures to use
BINFMTIMAGE=reg.git.brickburg.de/bbcontainers/hub/tonistiigi/binfmt:qemu-v10.0.4
BINFMTARCHS=arm64,386,arm/v7

# cleanup
docker pull $BASEIMAGE

# enable qemu multi arch support
if [ ! "$ARCH" == "amd64" ]; then
    docker pull reg.git.brickburg.de/bbcontainers/hub/tonistiigi/binfmt:qemu-v10.0.4
    #docker run --rm --privileged multiarch/qemu-user-static:latest --reset -p yes -c yes
    docker run --privileged --rm "$BINFMTIMAGE" --uninstall "$BINFMTARCHS"
    docker run --privileged --rm "$BINFMTIMAGE" --install "$BINFMTARCHS"
fi

# build base
cd src/base-alpine
docker --debug buildx build --pull --platform "$PLATFORM" -t "$OWNBASEIMAGE" --progress=plain --build-arg BASEIMAGE=$BASEIMAGE .

# build requested binary
cd ../..

if [ ! -n "$FOLDER" ] || [ ! -d "src/$FOLDER" ]; then
    echo "unknown container folder '$FOLDER'"
    exit 1
fi

cd src/$FOLDER

docker buildx build -t "$uidimage" --platform "$PLATFORM" --progress=plain \
    --build-arg ARCH=$ARCH --build-arg BASEIMAGE=$OWNBASEIMAGE --build-arg PARALLEL=$cpuparallel .

# extract result
cd ../..
mkdir -p dist

docker run -d --rm --platform "$PLATFORM" --name "$uidname" "$uidimage" /bin/sleep 300
sleep 3

if [ "$MODE" == "shell" ]; then
    docker exec -it "$uidname" bash
else
    docker cp $uidname:/dist/. dist/

    echo
    cat dist/.version-$FOLDER.$ARCH
fi
