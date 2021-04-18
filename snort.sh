#!/usr/bin/env bash

wget https://www.snort.org/downloads/snort/snort-2.9.17.1.tar.gz
tar -zxvf snort-2.9.17.1.tar.gz
cd snort-2.9.17.1
./configure --sourcefire && make && sudo make install && cd ..