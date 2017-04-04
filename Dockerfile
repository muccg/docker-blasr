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

RUN gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4
RUN curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.4/gosu-$(dpkg --print-architecture)" \
    && curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.4/gosu-$(dpkg --print-architecture).asc" \
    && gpg --verify /usr/local/bin/gosu.asc \
    && rm /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu

COPY docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
