FROM reg.git.brickburg.de/bbcontainers/hub/alpine:3

COPY /root /
WORKDIR /src

ARG ARCH=amd64

RUN chmod a+x build.sh && ./build.sh
