FROM alpine:3.9.2

RUN apk add gcc g++ make automake libpcap-dev

WORKDIR /opt
RUN wget http://www.tcpdump.org/release/tcpdump-4.9.2.tar.gz \
    && tar -xvf tcpdump-4.9.2.tar.gz \
    && cd tcpdump-4.9.2 \
    && CFLAGS=-static ./configure --without-crypto \
    && make

RUN mkdir /dist && mv tcpdump-4.9.2/tcpdump /dist/tcpdump.86_64
