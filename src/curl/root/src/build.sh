#!/bin/sh
# https://github.com/moparisthebest/static-curl/blob/master/build.sh

set -eu

#apk add build-base clang openssl-dev nghttp2-dev nghttp2-static libssh2-dev libssh2-static
#apk add openssl-libs-static zlib-static || true

echo -n "Checksum of downloaded file: "
sha256sum /download/curl-${CURL_VERSION}.tar.gz
echo "$CHECKSUM /download/curl-${CURL_VERSION}.tar.gz" | sha256sum -c
bbchecksig.sh "mykey.asc" "/download/curl-${CURL_VERSION}.tar.gz.asc" "/download/curl-${CURL_VERSION}.tar.gz"

tar xzf /download/curl-${CURL_VERSION}.tar.gz
cd curl-${CURL_VERSION}/

# gcc is apparantly incapable of building a static binary, even gcc -static helloworld.c ends up linked to libc, instead of solving, use clang
export CC=clang

ARCH=$ARCH LDFLAGS="-static" PKG_CONFIG="pkg-config --static" ./configure --disable-shared --enable-static \
    --with-openssl \
    --with-zlib \
    --with-zstd \
    --enable-ipv6 \
    --enable-unix-sockets \
    --without-libidn2 \
    --with-nghttp2 \
    --with-pic \
    --enable-websockets \
    --without-libssh2 \
    --without-libpsl \
    --disable-ldap \
    --disable-brotli

ARCH=$ARCH make -j${PARALLEL} V=1 LDFLAGS="-static -all-static"

# binary is ~13M before stripping, 2.6M after
bbstrip.sh src/curl

# we only want to save curl here
mv src/curl "/dist/curl.$ARCH"
