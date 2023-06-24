ARG BASEIMAGE
FROM ${BASEIMAGE}

ARG tcpdumpversion=4.99.4
ARG libpcapversion=1.10.4

WORKDIR /src
SHELL [ "/bin/bash", "-c" ]

RUN wget wget https://www.tcpdump.org/release/libpcap-${libpcapversion}.tar.gz \
    && tar -xvf libpcap-${libpcapversion}.tar.gz \
    && cd libpcap-${libpcapversion} \
    && CFLAGS=-static ./configure \
    && make

RUN wget https://www.tcpdump.org/release/tcpdump-${tcpdumpversion}.tar.gz \
    && tar -xvf tcpdump-${tcpdumpversion}.tar.gz \
    && cd tcpdump-${tcpdumpversion} \
    && CFLAGS=-static ./configure --without-crypto \
    && make

RUN mkdir /dist && mv tcpdump-${tcpdumpversion}/tcpdump /dist/tcpdump.86_64
