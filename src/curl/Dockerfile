ARG BASEIMAGE
FROM ${BASEIMAGE}

ARG ARCH=amd64
ARG PARALLEL=4
ARG CURL_VERSION=8.8.0
ARG CHECKSUM=77c0e1cd35ab5b45b659645a93b46d660224d0024f1185e8a95cdb27ae3d787d

COPY /root /

USER root
RUN apk add --no-cache nghttp2-dev nghttp2-static libssh2-dev libssh2-static && \
    chown builduser:builduser -R /src

USER builduser
RUN chmod a+x build.sh && ./build.sh

RUN chmod a+x /dist/curl.$ARCH && \
    /dist/curl.$ARCH --version | head -n 1 > /dist/.version-curl.$ARCH && \
    /dist/curl.$ARCH --version && \
    /dist/curl.$ARCH --help
