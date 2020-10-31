FROM python:3
ARG VERSION=20190803.01
# Current wget-at version: 1.20.3-at.20201030.01
ARG wget_lua=http://xor.meo.ws/1hh92cDPD-Rfbd7dUT_AGmsHutAr_QeT/wget-lua
ENV LC_ALL=C
RUN echo deb http://deb.debian.org/debian buster-backports main contrib > /etc/apt/sources.list.d/backports.list \
 && DEBIAN_FRONTEND=noninteractive DEBIAN_PRIORITY=critical apt-get -qqy --no-install-recommends -o Dpkg::Options::=--force-confdef -o Dpkg::Options::=--force-confold -o Dpkg::Options::=--force-unsafe-io update \
 && DEBIAN_FRONTEND=noninteractive DEBIAN_PRIORITY=critical apt-get -qqy --no-install-recommends -o Dpkg::Options::=--force-confdef -o Dpkg::Options::=--force-confold -o Dpkg::Options::=--force-unsafe-io install rsync liblua5.1-0 libluajit-5.1-2 libidn11 lua-socket \
 && DEBIAN_FRONTEND=noninteractive DEBIAN_PRIORITY=critical apt-get -qqy --no-install-recommends -o Dpkg::Options::=--force-confdef -o Dpkg::Options::=--force-confold -o Dpkg::Options::=--force-unsafe-io -t buster-backports install zstd libzstd-dev libzstd1 \
 && pip install requests seesaw zstandard \
 && wget "${wget_lua}" -O /usr/local/bin/wget-lua \
 && chmod +x /usr/local/bin/wget-lua \
 && rm -rf /var/lib/apt/lists/*
WORKDIR /grab
STOPSIGNAL SIGINT
ENTRYPOINT ["run-pipeline3", "--disable-web-server", "pipeline.py"]
