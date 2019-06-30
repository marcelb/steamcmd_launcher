#!/bin/bash
set -e

SERVER_LIST=("Baro1" "Baro2")

function contains() {
    local n=$#
    local value=${!n}
    for ((i=1;i < $#;i++)) {
        if [ "${!i}" == "${value}" ]; then
            return 0
        fi
    }
    return 1
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

COMMAND=$1
SERVER_NAME=$2

case "$COMMAND" in
	start)
		echo "Starting..."
            	;;
	stop)
		echo "Stopping..."
		;;
	status)
		echo "Status..."
		;;
	attach)
		echo "Attaching..."
		;;
	*)
		echo $"Usage: $0 {start|stop|status|attach} [ServerName]"
		exit 1
esac

echo "$COMMAND"

