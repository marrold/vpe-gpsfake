#!/bin/bash
set -e

gpsfake -P 2946 -c 0.33 -n gps.nmea & socat tcp-l:2947,reuseaddr,fork tcp:127.0.0.1:2946
