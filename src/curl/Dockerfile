ARG BASEIMAGE
FROM ${BASEIMAGE}

WORKDIR /src

ARG ARCH=amd64

COPY /root /

RUN chmod a+x build.sh && ./build.sh
