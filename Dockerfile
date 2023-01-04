FROM debian:bullseye-slim as base
RUN apt-get update && apt-get -y dist-upgrade \
 && apt-get install -y gpsd gpsd-clients python3 python3-distutils socat \
 && rm -rf /var/lib/apt/lists/* 

WORKDIR /opt

COPY ./start.sh .
COPY ./gpsd /etc/default/gpsd
COPY ./gps.nmea .


CMD ["/bin/bash", "/opt/start.sh"]
