FROM reg.git.brickburg.de/bbcontainers/hub/alpine:3

ARG version=4.99.4

RUN apk add gcc g++ make automake libpcap-dev

WORKDIR /opt
RUN wget https://www.tcpdump.org/release/tcpdump-${version}.tar.gz \
    && tar -xvf tcpdump-${version}.tar.gz \
    && cd tcpdump-${version} \
    && CFLAGS=-static ./configure --without-crypto \
    && make

RUN mkdir /dist && mv tcpdump-${version}/tcpdump /dist/tcpdump.86_64
