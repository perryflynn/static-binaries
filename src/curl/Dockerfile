ARG BASEIMAGE
FROM ${BASEIMAGE}

WORKDIR /src

ARG ARCH=amd64

COPY /root /

RUN chmod a+x build.sh && ./build.sh

RUN chmod a+x dist/curl.$ARCH && \
    /dist/curl.$ARCH --version | head -n 1 > /dist/.version-curl.$ARCH && \
    /dist/curl.$ARCH --version && \
    /dist/curl.$ARCH --help
