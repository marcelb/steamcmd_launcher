#!/bin/bash
# example file (for barotrauma)
# Crontab helper for the nightly update
# 0 5 * * * ~/BarotraumaServer/updateAll.sh
ROOT_DIR=~/Zomboid/ZomboidLauncher
cd $ROOT_DIR
$ROOT_DIR/server.sh stop Stream 
sleep 5
$ROOT_DIR/server.sh start Stream -screen
