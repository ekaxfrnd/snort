#!/usr/bin/env bash

# # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#							#
#      	    script: snort installation 			#
#           author: ekagustimann (un1Que)		#
#          website: https://gustimann.tech/		#
#							#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#							#
#		 preparing your server			#
#							#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# install all the pre-requisite software
sudo apt install -y gcc libpcre3-dev zlib1g-dev libluajit-5.1-dev \
libpcap-dev openssl libssl-dev libnghttp2-dev libdumbnet-dev \
bison flex libdnet autoconf libtool

# # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#							#
# 	      installing from the source		#
#							#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# download daq and snort source
wget https://www.snort.org/downloads/snort/daq-2.0.7.tar.gz
wget https://www.snort.org/downloads/snort/snort-2.9.17.1.tar.gz
# extract the daq source code and get into it
tar -zxvf daq-2.0.7.tar.gz
cd daq-2.0.7
# auto reconfigure DAQ before running the config
autoreconf -f -i
# run the configuration script then compile the program
./configure || ./configure --disable-dependency-tracking
make && sudo make install && cd ..
# extract the snort source and get into it
tar -zxvf snort-2.9.17.1.tar.gz
cd snort-2.9.17.1
# configure the installation with sourcefire enabled
./configure --enable-sourcefire && make && sudo make install

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
#							#
# 	 configuring snort to run in NIDS mode 		#
#							#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# updating the shared libraries
sudo ldconfig
# create a symbolic link
sudo ln -s /usr/local/bin/snort /usr/sbin/snort

# # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#							#
#       setting up username and folder structure	#
#							#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# create a new unprivileged user and group for the daemon
sudo groupadd snort
sudo useradd snort -r -s /sbin/nologin -c SNORT_IDS -g snort
# create the folder structure to house the snort configuration
sudo mkdir -p /etc/snort/rules
sudo mkdir /var/log/snort
sudo mkdir /usr/local/lib/snort_dynamicrules
# set the permission for the new folder accordingly
sudo chmod -R 5775 /etc/snort
sudo chmod -R 5775 /var/log/snort
sudo chmod -R 5775 /usr/local/lib/snort_dynamicrules
sudo chown -R snort:snort /etc/snort
sudo chown -R snort:snort /var/log/snort
sudo chown -R snort:snort /usr/local/lib/snort_dynamicrules
# create new files for the white and blacklists as well as the local rules
sudo touch /etc/snort/rules/white_list.rules
sudo touch /etc/snort/rules/black_list.rules
sudo touch /etc/snort/rules/local.rules && cd ..
# copy the configuration files from snort folder


