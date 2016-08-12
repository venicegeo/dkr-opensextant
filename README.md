# Geoint Services Opensextant Docker

This image is based upon the [Openshift base CentOS 7 image](https://hub.docker.com/r/openshift/base-centos7/)

It uses the Java OpenJDK and runs the Opensextant server listening on port 8182.
The final container does not run as root, but as the `default` user (1001).

You can find the applications code in `/opt/app-root/src/opensextant-toolbox-2.2`.

## Building

A convenience shell script is included here. The source code is a large download!

`$ ./build` will build the image for you.

## Running

`$ docker run -d -P geointservices/opensextant` starts the container.

## Verify it
`$ http://your.container.ip:8182/opensextant/extract/` 

    ["geo","general","geolite"]

