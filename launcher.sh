#!/bin/bash
set -e

ROOT_DIR=$1
SERVER_NAME=$2
APP_ID=$3
RUN_SERVER_CMD=$4
PREPARE_CMD=$5
STEAM_CMD=~/Steam/steamcmd.sh

echo "Running Server with parameters: $ROOT_DIR, $SERVER_NAME, $APP_ID"

#For fixing server files:
#  +app_update $APP_ID validate 

while true
do
	cd $ROOT_DIR/$SERVER_NAME
	$STEAM_CMD \
		+login anonymous \
		+force_install_dir $ROOT_DIR/$SERVER_NAME/Server \
		+app_update $APP_ID \
		+quit
	$PREPARE_CMD
	# rm -f $ROOT_DIR/$SERVER_NAME/Barotrauma/serversettings.xml
	# cp $ROOT_DIR/${SERVER_NAME}_serversettings.xml $ROOT_DIR/$SERVER_NAME/Barotrauma/serversettings.xml
	cd $ROOT_DIR/$SERVER_NAME/Server
	$RUN_SERVER_CMD # mono ./Server.exe # ./DedicatedServer.exe
	cd $ROOT_DIR/$SERVER_NAME
	echo "Press CTRL+C to stop..."
	sleep 5
done
