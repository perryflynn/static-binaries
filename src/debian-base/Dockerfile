FROM reg.git.brickburg.de/bbcontainers/hub/debian:bookworm-slim

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get dist-upgrade -y && \
    apt-get install -y libncurses5-dev libncursesw5-dev vim \
        gcc g++ make automake gcc-aarch64-linux-gnu binutils-aarch64-linux-gnu \
        gcc-arm-linux-gnueabi binutils-arm-linux-gnueabi \
        curl wget ca-certificates gnupg2 \
        flex bison

WORKDIR /src
