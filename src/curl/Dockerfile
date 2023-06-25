ARG BASEIMAGE
FROM ${BASEIMAGE}

ARG ARCH=amd64

COPY /root /
WORKDIR /src

RUN chmod a+x build.sh && ./build.sh
