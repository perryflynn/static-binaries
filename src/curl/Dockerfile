ARG BASEIMAGE
FROM ${BASEIMAGE}

ARG ARCH=amd64
ARG PARALLEL=4
ARG CURL_VERSION=8.11.1
ARG CHECKSUM=a889ac9dbba3644271bd9d1302b5c22a088893719b72be3487bc3d401e5c4e80

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
    /dist/curl.$ARCH --help
