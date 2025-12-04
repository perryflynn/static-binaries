ARG BASEIMAGE TESTIMAGE ARCH=amd64 PARALLEL=4
ARG CURL_VERSION=8.17.0
ARG CHECKSUM=e8e74cdeefe5fb78b3ae6e90cd542babf788fa9480029cfcee6fd9ced42b7910

# -> Build

FROM ${BASEIMAGE} AS build
ARG CURL_VERSION CHECKSUM ARCH PARALLEL

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

RUN --mount=type=cache,target=/download,uid=$USERID,gid=$USERID \
    bbwget.sh https://curl.se/download/curl-${CURL_VERSION}.tar.gz /download/curl-${CURL_VERSION}.tar.gz && \
    bbwget.sh https://curl.se/download/curl-${CURL_VERSION}.tar.gz.asc /download/curl-${CURL_VERSION}.tar.gz.asc && \
    chmod a+x build.sh && ./build.sh

# -> Test

FROM ${TESTIMAGE} AS test
ARG ARCH CURL_VERSION

COPY root/ /
RUN chown builduser:builduser /src

COPY --from=build /dist /dist

RUN chmod a+x /dist/curl.$ARCH && \
    /dist/curl.$ARCH --version | head -n 1 > /dist/.version-curl.$ARCH && \
    /dist/curl.$ARCH --version && \
    /dist/curl.$ARCH --help && \
    BINARY=/dist/curl.$ARCH VERSION=$CURL_VERSION VERSIONINFO=/dist/.version-curl.$ARCH bbensurebuild.sh
