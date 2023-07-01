ARG BASEIMAGE
FROM ${BASEIMAGE}

ARG BIND9_VERSION=9.16.7
ARG ARCH=amd64

USER root
RUN apk add --no-cache libuv-dev libuv-static

USER builduser
RUN id && wget https://downloads.isc.org/isc/bind9/${BIND9_VERSION}/bind-${BIND9_VERSION}.tar.xz && \
    tar xvf bind-${BIND9_VERSION}.tar.xz && \
    cd $(find . -maxdepth 1 -mindepth 1 -type d) && \
    CFLAGS="-static -O2" ./configure --without-python --disable-symtable --disable-backtrace --disable-linux-caps && \
    cd lib/dns/ && make && \
    cd ../bind9/ && make && \
    cd ../isc && make && \
    cd ../isccfg/ && make && \
    cd ../irs/ && make && \
    cd ../../bin/dig && make && \
    strip dig && \
    cp dig /dist/dig.$ARCH

RUN chmod a+x /dist/dig.$ARCH && \
    /dist/dig.$ARCH -v > /dist/.version-dig.$ARCH 2>&1 && \
    /dist/dig.$ARCH -v 2>&1 && \
    /dist/dig.$ARCH -h 2>&1
