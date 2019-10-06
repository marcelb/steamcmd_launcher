#!/bin/bash
# example file (for barotrauma)
# Crontab helper for the nightly update
# 0 5 * * * ~/BarotraumaServer/updateAll.sh
cd ~/BarotraumaServer
~/BarotraumaServer/server.sh stop Baro1
sleep 5
~/BarotraumaServer/server.sh start Baro1
sleep 240
~/BarotraumaServer/server.sh stop Baro2
sleep 5
~/BarotraumaServer/server.sh start Baro2
sleep 240
~/BarotraumaServer/server.sh stop BaroPrivate
sleep 5
~/BarotraumaServer/server.sh start BaroPrivate
sleep 5
