# vpe-gpsfake

Files to build a docker container that runs an instance of gpsfake - simulating gpsd plotting clockwise route around the M25 Motorway  near London (United Kingdom) at approximately 70 mph. You can override the route by mounting a nmea file as a volume (See Using vpe-gpsfake below). I used [nmeagen](https://www.nmeagen.org/#) to generate the file.

It's intended for use with the [Virtual Packet Environment](https://wiki.oarc.uk/virtual_packet_environment) but might be useful to someone else.

# Using vpe-gpsfake
It's assumed you'll use docker-compose to run the container. Your docker-compose.yaml should look something like:

    version: "3.2"
    services:
      gpsfake:
        image: marrold/vpe-gpsfake
        container_name: gpsfake
        restart: unless-stopped
        ports:
          - 2947:2947
        volumes:
          - ./my_log.nmea:/opt/gps.nmea # Optionally override the GPS log


# Notes

For reasons unknown I couldn't get gpsfake to listen on 0.0.0.0. The `-o =""` argument should allow passing arguments to the underlying gpsd instance, but I couldn't get it to work as it was throwing the following error:

    gpsfake -n -o ="-G" ~/gps.nmea
    gpsd:ERROR: SER: device open of = failed: No such file or directory - retrying read-only
    gpsd:ERROR: SER: read-only device open of = failed: No such file or directory
    gpsd:ERROR: initial GPS device = open failed

To avoid this, I've used socat to listen on `0.0.0.0:2947` and redirect to `127.0.0.1:2946` - Please forgive me.

# License

This project is released under the MIT license.
