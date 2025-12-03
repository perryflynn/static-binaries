ARG BASEIMAGE
FROM ${BASEIMAGE}

ARG tcpdumpversion=4.99.5
ARG libpcapversion=1.10.5
ARG PARALLEL=4
ARG ARCH=amd64
ARG tcpdumpchecksum=d76395ab82d659d526291b013eee200201380930793531515abfc6e77b4f2ee5
ARG libpcapchecksum=84fa89ac6d303028c1c5b754abff77224f45eca0a94eb1a34ff0aa9ceece3925

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
    /dist/tcpdump.$ARCH --help && \
    BINARY=/dist/tcpdump.$ARCH VERSION=$tcpdumpversion VERSIONINFO=/dist/.version-tcpdump.$ARCH bbensurebuild.sh
