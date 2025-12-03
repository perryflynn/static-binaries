ARG BASEIMAGE
FROM ${BASEIMAGE}

ARG ARCH=amd64
ARG PARALLEL=4
ARG CURL_VERSION=8.17.0
ARG CHECKSUM=e8e74cdeefe5fb78b3ae6e90cd542babf788fa9480029cfcee6fd9ced42b7910

COPY /root /

USER root
RUN apk add --no-cache \
        libidn2-dev libidn2-static \
        libpsl-dev libpsl-static \
        nghttp2-dev nghttp2-static \
        openssl-dev \
        gnu-libiconv-dev \
        zlib-dev zlib-static \
        zstd-dev zstd-static && \
    chown builduser:builduser -R /src

USER builduser
RUN chmod a+x build.sh && ./build.sh

RUN chmod a+x /dist/curl.$ARCH && \
    /dist/curl.$ARCH --version | head -n 1 > /dist/.version-curl.$ARCH && \
    /dist/curl.$ARCH --version && \
    /dist/curl.$ARCH --help && \
    BINARY=/dist/curl.$ARCH VERSION=$CURL_VERSION VERSIONINFO=/dist/.version-curl.$ARCH bbensurebuild.sh
