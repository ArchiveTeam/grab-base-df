ARG TLSTYPE=openssl
FROM atdr.meo.ws/archiveteam/wget-lua:v1.21.3-at-${TLSTYPE} AS wget
FROM python:3.9-slim-bullseye
LABEL version="20230605.01"
LABEL wget-at.version="1.21.3-at.20230605.01"
COPY --from=wget /wget /usr/local/bin/wget-lua
COPY --from=wget /usr/local/lib /usr/local/lib
RUN ldconfig
ENV LC_ALL=C
RUN DEBIAN_FRONTEND=noninteractive DEBIAN_PRIORITY=critical apt-get -qqy --no-install-recommends -o Dpkg::Options::=--force-confdef -o Dpkg::Options::=--force-confold -o Dpkg::Options::=--force-unsafe-io update \
 && DEBIAN_FRONTEND=noninteractive DEBIAN_PRIORITY=critical apt-get -qqy --no-install-recommends -o Dpkg::Options::=--force-confdef -o Dpkg::Options::=--force-confold -o Dpkg::Options::=--force-unsafe-io install gzip rsync liblua5.1-0 libluajit-5.1-2 libidn11 lua-socket lua-filesystem lua-sec lua-zip libpsl5 git poppler-utils luarocks libidn2-0-dev gcc \
 && pip install --no-cache-dir requests seesaw zstandard \
 && luarocks install html-entities \
 && luarocks install idn2 \
 && chmod +x /usr/local/bin/wget-lua \
 && rm -rf /var/lib/apt/lists/*
RUN echo "#!/bin/bash\n\$@" > /usr/bin/sudo \
 && chmod +x /usr/bin/sudo
RUN /usr/local/bin/wget-lua --help | grep -iE "gnu|warc|lua|dns|host|resolv"
WORKDIR /grab
ONBUILD COPY . /grab
ONBUILD RUN (test -x warrior-install.sh || touch warrior-install.sh) && sh warrior-install.sh
ONBUILD RUN test -x /grab/wget-at || ln -fs /usr/local/bin/wget-lua /grab/wget-at
STOPSIGNAL SIGINT
LABEL com.centurylinklabs.watchtower.stop-signal="SIGINT"
ENTRYPOINT ["run-pipeline3", "--disable-web-server", "pipeline.py"]
