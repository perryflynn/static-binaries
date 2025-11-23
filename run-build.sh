#!/bin/bash

set -u
set -e

cpuparallel=1
ARCH="${2:-}"

if [ ! -n "$ARCH" ]; then
    ARCH=amd64
fi

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
else
    BASEIMAGE=reg.git.brickburg.de/bbcontainers/hub/alpine:3
    OWNBASEIMAGE=static-binaries-alpine-amd64:latest
    PLATFORM=linux/amd64
fi

cd "$(dirname "$0")"

# cleanup
#docker system prune -a -f

docker pull $BASEIMAGE

# enable qemu support
if [ ! "$ARCH" == "amd64" ]; then
    docker pull multiarch/qemu-user-static:latest
    docker run --rm --privileged multiarch/qemu-user-static:latest --reset -p yes -c yes
    #docker run --privileged --rm tonistiigi/binfmt --install all
fi

# build base
cd src/base-alpine
docker --debug buildx build --pull --platform "$PLATFORM" -t "$OWNBASEIMAGE" --progress=plain --build-arg BASEIMAGE=$BASEIMAGE .

# build requested binary
cd ../..
folder=${1:-}

if [ ! -n "$folder" ] || [ ! -d "src/$folder" ]; then
    echo "unknown container folder '$folder'"
    exit 1
fi

cd src/$folder

uidimage=static-binary-$folder:latest
docker buildx build -t "$uidimage" --platform "$PLATFORM" --progress=plain \
    --build-arg ARCH=$ARCH --build-arg BASEIMAGE=$OWNBASEIMAGE --build-arg PARALLEL=$cpuparallel .

# extract result
cd ../..
mkdir -p dist

uidname=static-binary-extract-$folder
docker run -d --rm --platform "$PLATFORM" --name "$uidname" "$uidimage" /bin/sleep 300
sleep 3

docker cp $uidname:/dist/. dist/
docker stop $uidname
sleep 3

docker image rm "$uidimage"

echo
cat dist/.version-$folder.$ARCH
