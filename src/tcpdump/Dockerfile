ARG BASEIMAGE
FROM ${BASEIMAGE}

ARG tcpdumpversion=4.99.4
ARG libpcapversion=1.10.4
ARG PARALLEL=4
ARG ARCH=amd64
ARG tcpdumpchecksum=93c46aafd8946c47136275a22dfdc9b5ca1c5c5018995b6ab8505f7006ac5ffc
ARG libpcapchecksum=ce62241f0dea7c8130df7b80d6b0ccb7b3f084a32fc891dffc01bf61b75cbb86

COPY root/ /
RUN chown builduser:builduser /src

USER builduser

RUN wget https://www.tcpdump.org/release/libpcap-${libpcapversion}.tar.xz \
        https://www.tcpdump.org/release/libpcap-${libpcapversion}.tar.xz.sig && \
    echo "$libpcapchecksum libpcap-${libpcapversion}.tar.xz" | sha256sum -c && \
    bbchecksig.sh "signing-key-RSA-E089DEF1D9C15D0D.asc" "libpcap-${libpcapversion}.tar.xz.sig" "libpcap-${libpcapversion}.tar.xz" && \
    tar -xvf libpcap-${libpcapversion}.tar.xz && \
    cd libpcap-${libpcapversion} && \
    CFLAGS=-static ./configure --with-pcap=linux && \
    make

RUN pwd && ls -lisahF && wget https://www.tcpdump.org/release/tcpdump-${tcpdumpversion}.tar.xz \
        https://www.tcpdump.org/release/tcpdump-${tcpdumpversion}.tar.xz.sig && \
    echo "$tcpdumpchecksum tcpdump-${tcpdumpversion}.tar.xz" | sha256sum -c && \
    bbchecksig.sh "signing-key-RSA-E089DEF1D9C15D0D.asc" "tcpdump-${tcpdumpversion}.tar.xz.sig" "tcpdump-${tcpdumpversion}.tar.xz" && \
    tar -xvf tcpdump-${tcpdumpversion}.tar.xz && \
    cd tcpdump-${tcpdumpversion} && \
    CFLAGS=-static ./configure --without-crypto && \
    make -j${PARALLEL} && \
    mv tcpdump /dist/tcpdump.$ARCH && \
    strip /dist/tcpdump.$ARCH

RUN chmod a+x /dist/tcpdump.$ARCH && \
    /dist/tcpdump.$ARCH --version | tr '\n' ';' > /dist/.version-tcpdump.$ARCH && \
    /dist/tcpdump.$ARCH --version && \
    /dist/tcpdump.$ARCH --help
