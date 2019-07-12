#!/bin/bash
set -e

SERVER_LIST=("Baro1" "Baro2" "BaroPrivate")
ROOT_DIR=~/BarotraumaServer
APP_ID=1026340

PINK='\033[0;35m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

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
        	echo -e "${GREEN}Using ServerName \"$SERVER_NAME\".${NC}"
	else
        	echo -e "${RED}Server \"$SERVER_NAME\" doesn't exist.${NC}"
        	exit 1
	fi
}

# PROGRAM START

echo -e "${PINK}Welcome to SteamCMD Runner 0.1${NC}"
COMMAND=$1
SERVER_NAME=$2
SWITCH=$3
cd $ROOT_DIR
echo -e "${GREEN}Running in $( pwd ).${NC}"
echo -e "${GREEN}Making sure all server directories exist.${NC}"
create_all_server_dirs

case "$COMMAND" in
	start)
		echo -e "${GREEN}Starting Server...${NC}"
		check_server_name
		if [ "-noscreen" == "$SWITCH" ]; then
			$ROOT_DIR/launcher.sh $ROOT_DIR $SERVER_NAME $APP_ID
		else
			screen -S $SERVER_NAME -d -m $ROOT_DIR/launcher.sh $ROOT_DIR $SERVER_NAME $APP_ID
		fi
		sleep 1
            	;;
	stop)
		echo -e "${GREEN}Stopping Server...${NC}"
		check_server_name
		screen -S $SERVER_NAME -X quit
		sleep 1
		;;
	status)
		echo -e "${GREEN}Status:${NC}"
		screen -list
		;;
	attach)
		echo -e "${GREEN}Attaching Console to Server...${NC}"
		check_server_name
		screen -r $SERVER_NAME
		;;
	*)
		echo ""
		echo -e $"${RED}Usage: $0 {start|stop|status|attach} [ServerName]${NC}"
		exit 1
esac || true

echo -e "${GREEN}Done.${NC}"

