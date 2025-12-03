ARG BASEIMAGE
FROM ${BASEIMAGE}

ARG BIND9_VERSION=9.16.50
ARG ARCH=amd64
ARG PARALLEL=4
ARG CHECKSUM=816dbaa3c115019f30fcebd9e8ef8f7637f4adde91c79daa099b035255a15795

USER root
RUN apk add --no-cache libuv-dev libuv-static \
        userspace-rcu-dev userspace-rcu-static userspace-rcu \
        nghttp2-static nghttp2-libs nghttp2-dev \
        libcap-dev libcap2 libcap libcap-static \
        jemalloc jemalloc-dev jemalloc-static

COPY root/ /
RUN chown builduser:builduser /src

USER builduser
RUN wget https://downloads.isc.org/isc/bind9/${BIND9_VERSION}/bind-${BIND9_VERSION}.tar.xz \
        https://downloads.isc.org/isc/bind9/${BIND9_VERSION}/bind-${BIND9_VERSION}.tar.xz.asc && \
    echo "$CHECKSUM bind-${BIND9_VERSION}.tar.xz" | sha256sum -c && \
    bbchecksig.sh "isc-keyblock.asc" "bind-${BIND9_VERSION}.tar.xz.asc" "bind-${BIND9_VERSION}.tar.xz" && \
    tar xvf bind-${BIND9_VERSION}.tar.xz && \
    cd $(find . -maxdepth 1 -mindepth 1 -type d) && \
    CFLAGS="-static -O2" ./configure --without-python --disable-symtable --disable-backtrace --disable-linux-caps && \
    cd lib/dns/ && make -j${PARALLEL} && \
    cd ../bind9/ && make -j${PARALLEL} && \
    cd ../isc && make -j${PARALLEL} && \
    cd ../isccfg/ && make -j${PARALLEL} && \
    cd ../irs/ && make -j${PARALLEL} && \
    cd ../../bin/dig && make -j${PARALLEL} && \
    strip dig && \
    cp dig /dist/dig.$ARCH && \
    cd ../../bin/nsupdate && make -j${PARALLEL} && \
    strip nsupdate && \
    cp nsupdate /dist/nsupdate.$ARCH

RUN chmod a+x /dist/dig.$ARCH && \
    /dist/dig.$ARCH -v > /dist/.version-dig.$ARCH 2>&1 && \
    /dist/dig.$ARCH -v 2>&1 && \
    /dist/dig.$ARCH -h 2>&1 && \
    BINARY=/dist/dig.$ARCH VERSION=$BIND9_VERSION VERSIONINFO=/dist/.version-dig.$ARCH bbensurebuild.sh && \
    chmod a+x /dist/nsupdate.$ARCH && \
    /dist/nsupdate.$ARCH -V > /dist/.version-nsupdate.$ARCH 2>&1 && \
    /dist/nsupdate.$ARCH -V 2>&1 && \
    echo -e "help\nquit" | /dist/nsupdate.$ARCH 2>&1 && \
    BINARY=/dist/nsupdate.$ARCH VERSION=$BIND9_VERSION VERSIONINFO=/dist/.version-nsupdate.$ARCH bbensurebuild.sh && \
