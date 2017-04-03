FROM ubuntu:16.04

ENV SRC /usr/local/src
ENV MAKE_PREFIX /usr/local/pacbio

RUN apt-get update && apt-get install -y \
    bzip2 \
    curl \
    build-essential \
    git \
    python \
    libncurses-dev \
    libz-dev \
    wget \
    unzip \
    vim

# https://github.com/PacificBiosciences/pitchfork/wiki/Installing-blasr-with-pitchfork
RUN mkdir -p ${SRC}/pitchfork && \ 
    git clone https://github.com/PacificBiosciences/pitchfork.git ${SRC}/pitchfork && \
    cd ${SRC}/pitchfork && \
    make PREFIX=${MAKE_PREFIX} blasr && \
    rm -rf ${SRC}/pitchfork

COPY docker-entrypoint.sh /docker-entrypoint.sh

RUN mkdir -p /data

WORKDIR /data
VOLUME ["/data"]
ENTRYPOINT ["/docker-entrypoint.sh"]
