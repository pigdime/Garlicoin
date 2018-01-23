FROM ubuntu:xenial

RUN apt-get update -y \
    	&& apt-get install -y \
        git                 \
        build-essential     \
        libtool             \
        autotools-dev       \
        automake            \
        pkg-config          \
        libssl-dev          \
        libevent-dev        \
        bsdmainutils        \
        libboost-all-dev    \
        && apt-get clean

COPY . /tmp/bacoin/
WORKDIR /tmp/bacoin

RUN ./autogen.sh \
        && ./configure --with-gui=no --disable-wallet --disable-tests --with-incompatible-db \
        && make \
        && make install
EXPOSE 42075
ENTRYPOINT ["bacoind", "-testnet"]
