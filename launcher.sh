#!/bin/bash
set -e

ROOT_DIR=$1
SERVER_NAME=$2
APP_ID=$3
STEAMCMD=~/Steam/steamcmd.sh

echo "Running Server with parameters: $ROOT_DIR, $SERVER_NAME, $APP_ID"

while true
do
	cd $ROOT_DIR/$SERVER_NAME
	$STEAMCMD \
		+login anonymous \
		+force_install_dir $ROOT_DIR/$SERVER_NAME/Barotrauma \
		+app_update $APP_ID validate \
		+quit
	rm -f $ROOT_DIR/$SERVER_NAME/Barotrauma/serversettings.xml
	cp $ROOT_DIR/${SERVER_NAME}_serversettings.xml $ROOT_DIR/$SERVER_NAME/Barotrauma/serversettings.xml
	cd $ROOT_DIR/$SERVER_NAME/Barotrauma
	./DedicatedServer
	cd $ROOT_DIR/$SERVER_NAME
	echo "Press CTRL+C to stop..."
	sleep 5
done
