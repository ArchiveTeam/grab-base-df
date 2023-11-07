ARG TLSTYPE=openssl
FROM atdr.meo.ws/archiveteam/wget-lua:v1.21.3-at-${TLSTYPE} AS wget
FROM python:3.9-slim-bullseye
LABEL version="20231107.01"
COPY --from=wget /wget /usr/local/bin/wget-lua
COPY --from=wget /usr/local/lib /usr/local/lib
RUN ldconfig
ENV LC_ALL=C
RUN DEBIAN_FRONTEND=noninteractive DEBIAN_PRIORITY=critical apt-get -qqy --no-install-recommends -o Dpkg::Options::=--force-confdef -o Dpkg::Options::=--force-confold -o Dpkg::Options::=--force-unsafe-io update \
 && DEBIAN_FRONTEND=noninteractive DEBIAN_PRIORITY=critical apt-get -qqy --no-install-recommends -o Dpkg::Options::=--force-confdef -o Dpkg::Options::=--force-confold -o Dpkg::Options::=--force-unsafe-io install \
  gzip sudo rsync gcc git libluajit-5.1-dev luarocks \
  # for PDF to HTML conversion
  poppler-utils \
  # for lua 'idn2'
  libidn2-dev \
  # for lua 'luasec'
  libssl-dev \
  # for lua 'luazip'
  libzzip-dev \
  libpsl5 \
 && rm -rf /var/lib/apt/lists/*
RUN chmod +x /usr/local/bin/wget-lua
RUN /usr/local/bin/wget-lua --help | grep -iE "gnu|warc|lua|dns|host|resolv"
COPY requirements.txt /tmp/requirements.txt
COPY requirements-0-0.rockspec /tmp/requirements-0-0.rockspec
WORKDIR /tmp
RUN luarocks install --only-deps requirements-0-0.rockspec
RUN pip install --no-cache-dir -r requirements.txt
WORKDIR /grab
ONBUILD COPY . /grab
ONBUILD RUN (test -x warrior-install.sh || touch warrior-install.sh) && sh warrior-install.sh
ONBUILD RUN ln -fs /usr/local/bin/wget-lua /grab/wget-at
STOPSIGNAL SIGINT
ENTRYPOINT ["run-pipeline3", "--disable-web-server", "pipeline.py"]
