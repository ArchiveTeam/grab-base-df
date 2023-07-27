ARG TLSTYPE=openssl
FROM atdr.meo.ws/archiveteam/wget-lua:v1.21.3-at-${TLSTYPE} AS wget
FROM python:3.9-slim-bullseye
LABEL version="20230725.01"
LABEL wget-at.version="1.21.3-at.20230605.01"
COPY --from=wget /wget /usr/local/bin/wget-lua
COPY --from=wget /usr/local/lib /usr/local/lib
RUN ldconfig
ENV LC_ALL=C
RUN DEBIAN_FRONTEND=noninteractive DEBIAN_PRIORITY=critical apt-get -qqy --no-install-recommends -o Dpkg::Options::=--force-confdef -o Dpkg::Options::=--force-confold -o Dpkg::Options::=--force-unsafe-io update \
 && DEBIAN_FRONTEND=noninteractive DEBIAN_PRIORITY=critical apt-get -qqy --no-install-recommends -o Dpkg::Options::=--force-confdef -o Dpkg::Options::=--force-confold -o Dpkg::Options::=--force-unsafe-io install \
  # to be used: libluajit-5.1-2
  gzip rsync gcc git liblua5.1-0 luarocks \
  # for PDF to HTML conversion in urls-grab
  poppler-utils \
  # for lua 'idn2'
  libidn2-dev \
  # for lua 'luasec'
  libssl-dev \
  # for lua 'luazip'
  libzzip-dev \
  libpsl5 \
 && chmod +x /usr/local/bin/wget-lua \
 && rm -rf /var/lib/apt/lists/*
RUN echo "#!/bin/bash\n\$@" > /usr/bin/sudo \
 && chmod +x /usr/bin/sudo
RUN /usr/local/bin/wget-lua --help | grep -iE "gnu|warc|lua|dns|host|resolv"
COPY requirements.txt /tmp/requirements.txt
COPY requirements-0-0.rockspec /tmp/requirements-0-0.rockspec
WORKDIR /tmp
RUN luarocks install --only-deps requirements-0-0.rockspec
RUN pip install --no-cache-dir -r requirements.txt
WORKDIR /grab
ONBUILD COPY . /grab
ONBUILD RUN (test -x warrior-install.sh || touch warrior-install.sh) && sh warrior-install.sh
ONBUILD RUN test -x /grab/wget-at || ln -fs /usr/local/bin/wget-lua /grab/wget-at
STOPSIGNAL SIGINT
ENTRYPOINT ["run-pipeline3", "--disable-web-server", "pipeline.py"]
