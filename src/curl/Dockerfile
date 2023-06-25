FROM reg.git.brickburg.de/bbcontainers/hub/alpine:3

COPY /root /
WORKDIR /src

RUN chmod a+x build.sh && ./build.sh
