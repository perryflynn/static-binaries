ARG BASEIMAGE
FROM ${BASEIMAGE}

ARG tcpdumpversion=4.99.4
ARG libpcapversion=1.10.4

ARG package=tcpdump
ARG CROSS_COMPILE=
ARG NAME=

ENV CFLAGS=-static
ENV LDFLAGS=-static
ENV CPPFLAGS=-static
ENV CFLAGS_APPEND=-static
ENV LDFLAGS_APPEND=-static
ENV CPPFLAGS_APPEND=-static

RUN wget https://www.tcpdump.org/release/libpcap-${libpcapversion}.tar.gz && \
    tar -xvf libpcap-${libpcapversion}.tar.gz && \
    cd libpcap-${libpcapversion} && \
    MAKEARGS=() && \
    ( if [ -n "$CROSS_COMPILE" ]; then MAKEARGS+=("--host=$CROSS_COMPILE"); fi ) && \
    CC="${CROSS_COMPILE:+$CROSS_COMPILE-}gcc" ./configure "${MAKEARGS[@]}" --with-pcap=linux && \
    make

RUN wget https://www.tcpdump.org/release/tcpdump-${tcpdumpversion}.tar.gz && \
    tar -xvf tcpdump-${tcpdumpversion}.tar.gz && \
    cd tcpdump-${tcpdumpversion} && \
    ( if [ -n "$CROSS_COMPILE" ]; then MAKEARGS+=("--host=$CROSS_COMPILE"); fi ) && \
    CC="${CROSS_COMPILE:+$CROSS_COMPILE-}gcc" ./configure "${MAKEARGS[@]}" --without-crypto && \
    make

RUN mkdir /dist && mv tcpdump-${tcpdumpversion}/tcpdump /dist/tcpdump.$NAME
