ARG BASEIMAGE
FROM ${BASEIMAGE}

ARG tcpdumpversion=4.99.4
ARG libpcapversion=1.10.4

ARG ARCH=amd64

USER builduser

RUN wget https://www.tcpdump.org/release/libpcap-${libpcapversion}.tar.gz && \
    tar -xvf libpcap-${libpcapversion}.tar.gz && \
    cd libpcap-${libpcapversion} && \
    CFLAGS=-static ./configure --with-pcap=linux && \
    make

RUN wget https://www.tcpdump.org/release/tcpdump-${tcpdumpversion}.tar.gz && \
    tar -xvf tcpdump-${tcpdumpversion}.tar.gz && \
    cd tcpdump-${tcpdumpversion} && \
    CFLAGS=-static ./configure --without-crypto && \
    make && \
    mv tcpdump /dist/tcpdump.$ARCH && \
    strip /dist/tcpdump.$ARCH

RUN chmod a+x /dist/tcpdump.$ARCH && \
    /dist/tcpdump.$ARCH --version | tr '\n' ';' > /dist/.version-tcpdump.$ARCH && \
    /dist/tcpdump.$ARCH --version && \
    /dist/tcpdump.$ARCH --help
