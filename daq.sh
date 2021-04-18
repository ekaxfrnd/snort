#!/usr/bin/env bash

wget https://www.snort.org/downloads/snort/daq-2.0.7.tar.gz
tar -zxvf daq-2.0.7.tar.gz
cd daq-2.0.7
autoreconf -f -i
./configure && make && sudo make install