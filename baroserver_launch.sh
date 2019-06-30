#!/bin/bash
set -e

SERVER_NAME=$1

while false
do
	cd ~/$SERVER_NAME
	~/Steam/steamcmd.sh \
		+login anonymous \
		+force_install_dir ~/$SERVER_NAME/Barotrauma \
		+app_update 1026340 validate \
		+quit
	rm -f ~/$SERVER_NAME/Barotrauma/serversettings.xml
	cp ~/$SERVER_NAME/serversettings.xml ~/$SERVER_NAME/Barotrauma
	cd ~/$SERVER_NAME/Barotrauma
	./DedicatedServer
	cd ~/$SERVER_NAME
	echo "Press CTRL+C to stop..."
	sleep 5
done
