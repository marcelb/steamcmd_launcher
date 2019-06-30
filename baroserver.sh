#!/bin/bash
set -e

SERVER_LIST=("Baro1" "Baro2")
ROOT_DIR=~/BarotraumaServer
APP_ID=1026340

function contains()
{
	local n=$#
	local value=${!n}
	for ((i=1;i < $#;i++)) {
		if [ "${!i}" == "${value}" ]; then
			return 0
		fi
	}
	return 1
}

create_all_server_dirs()
{
	for i in "${SERVER_LIST[@]}"
	do
		mkdir -p $ROOT_DIR/$i
	done
}

check_server_name()
{
	if contains "${SERVER_LIST[@]}" "$SERVER_NAME" ; then
        	echo "Using Server $SERVER_NAME..."
	else
        	echo "Server '$SERVER_NAME' doesn't exist."
        	exit 1
	fi
}

update_and_run()
{
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
}



# PROGRAM START

PINK='\033[0;35m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${PINK}Welcome to SteamCMD Runner 0.1${NC}"
COMMAND=$1
SERVER_NAME=$2
cd $ROOT_DIR
echo -e "${GREEN}Running in $( pwd ).${NC}"
echo -e "${GREEN}Making sure all server directories exist.${NC}"
create_all_server_dirs

case "$COMMAND" in
	start)
		echo "Starting."
		check_server_name
		screen -S $SERVER_NAME -d -m ./baroserver_launch.sh $SERVER_NAME $APP_ID
            	;;
	stop)
		echo "Stopping."
		check_server_name
		screen -S $SERVER_NAME -X quit
		;;
	status)
		echo "Status:"
		screen -list
		;;
	attach)
		echo "Attaching."
		check_server_name
		screen -r $SERVER_NAME
		;;
	*)
		echo ""
		echo -e $"${RED}Usage: $0 {start|stop|status|attach} [ServerName]${NC}"
		exit 1
esac || true

echo -e "${GREEN}Done.${NC}"

