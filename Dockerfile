FROM python:3
ARG VERSION=20190803.01
# ARG wget_lua=http://xor.meo.ws/zEMhOKrjwKi69SIWBdxiQGJ2IpzzSIx4/wget-lua
ARG wget_lua=http://xor.meo.ws/W9UAWrao_ftJLSVoBXf3EK9YLffbBUjv/wget-lua
ENV LC_ALL=C
RUN DEBIAN_FRONTEND=noninteractive DEBIAN_PRIORITY=critical apt-get -qqy --no-install-recommends -o Dpkg::Options::=--force-confdef -o Dpkg::Options::=--force-confold -o Dpkg::Options::=--force-unsafe-io update \
 && DEBIAN_FRONTEND=noninteractive DEBIAN_PRIORITY=critical apt-get -qqy --no-install-recommends -o Dpkg::Options::=--force-confdef -o Dpkg::Options::=--force-confold -o Dpkg::Options::=--force-unsafe-io install rsync liblua5.1-0 libluajit-5.1-2 libidn11 \
 && pip install requests seesaw warcio \
 && wget "${wget_lua}" -O /usr/local/bin/wget-lua \
 && chmod +x /usr/local/bin/wget-lua \
 && rm -rf /var/lib/apt/lists/* \
 && sed -i 's|DEFAULT_RETRY_DELAY = 60$|DEFAULT_RETRY_DELAY = 0|;s|self\.retry_delay += 10|self.retry_delay += 0|' /usr/local/lib/python3.7/site-packages/seesaw/tracker.py
WORKDIR /grab
STOPSIGNAL SIGINT
ENTRYPOINT ["run-pipeline3", "--disable-web-server", "pipeline.py"]
