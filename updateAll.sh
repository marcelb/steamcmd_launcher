#!/bin/bash
# Crontab helper for the nightly update
# 0 5 * * * ~/BarotraumaServer/updateAll.sh
cd ~/BarotraumaServer
~/BarotraumaServer/baroserver.sh stop Baro1
sleep 5
~/BarotraumaServer/baroserver.sh start Baro1
sleep 240
~/BarotraumaServer/baroserver.sh stop Baro2
sleep 5
~/BarotraumaServer/baroserver.sh start Baro2
sleep 240
