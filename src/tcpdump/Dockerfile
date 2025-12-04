ARG BASEIMAGE TESTIMAGE ARCH=amd64 PARALLEL=4
ARG tcpdumpversion=4.99.5
ARG tcpdumpchecksum=d76395ab82d659d526291b013eee200201380930793531515abfc6e77b4f2ee5
ARG libpcapversion=1.10.5
ARG libpcapchecksum=84fa89ac6d303028c1c5b754abff77224f45eca0a94eb1a34ff0aa9ceece3925

# -> Build

FROM ${BASEIMAGE} AS build
ARG ARCH PARALLEL tcpdumpversion tcpdumpchecksum libpcapversion libpcapchecksum

COPY root/ /
RUN chown builduser:builduser /src

USER builduser

RUN --mount=type=cache,target=/download,uid=$USERID,gid=$USERID \
    bbwget.sh https://www.tcpdump.org/release/libpcap-${libpcapversion}.tar.xz /download/libpcap-${libpcapversion}.tar.xz && \
    bbwget.sh https://www.tcpdump.org/release/libpcap-${libpcapversion}.tar.xz.sig /download/libpcap-${libpcapversion}.tar.xz.sig && \
    echo "$libpcapchecksum /download/libpcap-${libpcapversion}.tar.xz" | sha256sum -c && \
    bbchecksig.sh "signing-key-RSA-E089DEF1D9C15D0D.asc" "/download/libpcap-${libpcapversion}.tar.xz.sig" "/download/libpcap-${libpcapversion}.tar.xz" && \
    tar xf /download/libpcap-${libpcapversion}.tar.xz && \
    cd libpcap-${libpcapversion} && \
    CFLAGS=-static ./configure --with-pcap=linux && \
    make

RUN --mount=type=cache,target=/download,uid=$USERID,gid=$USERID \
    bbwget.sh https://www.tcpdump.org/release/tcpdump-${tcpdumpversion}.tar.xz /download/tcpdump-${tcpdumpversion}.tar.xz && \
    bbwget.sh https://www.tcpdump.org/release/tcpdump-${tcpdumpversion}.tar.xz.sig /download/tcpdump-${tcpdumpversion}.tar.xz.sig && \
    echo "$tcpdumpchecksum /download/tcpdump-${tcpdumpversion}.tar.xz" | sha256sum -c && \
    bbchecksig.sh "signing-key-RSA-E089DEF1D9C15D0D.asc" "/download/tcpdump-${tcpdumpversion}.tar.xz.sig" "/download/tcpdump-${tcpdumpversion}.tar.xz" && \
    tar xf /download/tcpdump-${tcpdumpversion}.tar.xz && \
    cd tcpdump-${tcpdumpversion} && \
    CFLAGS=-static ./configure --without-crypto && \
    make -j${PARALLEL} && \
    mv tcpdump /dist/tcpdump.$ARCH && \
    bbstrip.sh /dist/tcpdump.$ARCH

# -> Test

FROM ${TESTIMAGE} AS test
ARG ARCH tcpdumpversion

COPY --from=build /dist /dist

RUN chmod a+x /dist/tcpdump.$ARCH && \
    /dist/tcpdump.$ARCH --version | tr '\n' ';' > /dist/.version-tcpdump.$ARCH && \
    /dist/tcpdump.$ARCH --version && \
    /dist/tcpdump.$ARCH --help && \
    BINARY=/dist/tcpdump.$ARCH VERSION=$tcpdumpversion VERSIONINFO=/dist/.version-tcpdump.$ARCH bbensurebuild.sh
