FROM reg.git.brickburg.de/bbcontainers/hub/alpine:3

COPY /root /
WORKDIR /src

ARG ARCH=amd64

RUN apk add build-base clang openssl-dev nghttp2-dev nghttp2-static libssh2-dev libssh2-static && \
    apk add openssl-libs-static zlib-static || true

RUN chmod a+x build.sh && ./build.sh
