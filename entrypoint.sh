#!/usr/bin/env bash

set -euo pipefail

export ATEAM_DNS_IPv4="$(python3 /tmp/get_random_ipv4.py)"
(while true; do dnsmasq --listen-address="${ATEAM_DNS_IPv4}" -k -C /etc/dnsmasq.conf || true; sleep 1; done) &
exec run-pipeline3 --disable-web-server pipeline.py "${@}"

