ARG BASEIMAGE
FROM ${BASEIMAGE}

ARG ARCH=amd64

COPY /root /

USER root
RUN apk add --no-cache nghttp2-dev nghttp2-static libssh2-dev libssh2-static && \
    chown guest:users -R /src

USER guest
RUN chmod a+x build.sh && ./build.sh

RUN chmod a+x /dist/curl.$ARCH && \
    /dist/curl.$ARCH --version | head -n 1 > /dist/.version-curl.$ARCH && \
    /dist/curl.$ARCH --version && \
    /dist/curl.$ARCH --help
