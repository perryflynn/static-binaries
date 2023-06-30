#!/bin/sh

# https://github.com/moparisthebest/static-curl/blob/master/build.sh
# to test locally, run one of:
# docker run --rm -v $(pwd):/tmp -w /tmp -e ARCH=amd64 alpine /tmp/build.sh
# docker run --rm -v $(pwd):/tmp -w /tmp -e ARCH=aarch64 multiarch/alpine:aarch64-latest-stable /tmp/build.sh
# docker run --rm -v $(pwd):/tmp -w /tmp -e ARCH=ARCH_HERE ALPINE_IMAGE_HERE /tmp/build.sh

env

CURL_VERSION='8.1.2'

[ "$1" != "" ] && CURL_VERSION="$1"

set -exu

#apk add build-base clang openssl-dev nghttp2-dev nghttp2-static libssh2-dev libssh2-static
#apk add openssl-libs-static zlib-static || true

if [ ! -f curl-${CURL_VERSION}.tar.gz ]
then

    # for gpg verification of the curl download below
    #apk add gnupg

    wget https://curl.haxx.se/download/curl-${CURL_VERSION}.tar.gz \
        https://curl.haxx.se/download/curl-${CURL_VERSION}.tar.gz.asc

    # convert mykey.asc to a .pgp file to use in verification
    gpg --no-default-keyring --yes -o ./curl.gpg --dearmor mykey.asc
    # this has a non-zero exit code if it fails, which will halt the script
    gpg --no-default-keyring --keyring ./curl.gpg --verify curl-${CURL_VERSION}.tar.gz.asc

fi

rm -rf "curl-${CURL_VERSION}/"
tar xzf curl-${CURL_VERSION}.tar.gz

cd curl-${CURL_VERSION}/

# gcc is apparantly incapable of building a static binary, even gcc -static helloworld.c ends up linked to libc, instead of solving, use clang
export CC=clang

ARCH=$ARCH LDFLAGS="-static" PKG_CONFIG="pkg-config --static" ./configure --disable-shared \
    --enable-static --disable-ldap --enable-ipv6 --enable-unix-sockets --with-ssl --with-libssh2

ARCH=$ARCH make -j4 V=1 LDFLAGS="-static -all-static"

# binary is ~13M before stripping, 2.6M after
strip src/curl

# print out some info about this, size, and to ensure it's actually fully static
echo "arch=$ARCH"
ls -lah src/curl
file src/curl
# exit with error code 1 if the executable is dynamic, not static
ldd src/curl && exit 1 || true

./src/curl -V

# we only want to save curl here
mkdir -p /dist
mv src/curl "/dist/curl.$ARCH"
