#!/bin/sh

ulimit -c 0
exec /usr/bin/tini -- run-pipeline3 --disable-web-server pipeline.py "$@"
