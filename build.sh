#/usr/bin/bash

wget -O opensextant-toolbox-2.2.zip https://github.com/OpenSextant/OpenSextantToolbox/releases/download/v2.2/opensextant-toolbox-2.2.zip
docker build --tag=geointservices/opensextant .
