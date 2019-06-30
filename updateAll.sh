#!/bin/bash
~/BarotraumaServer/baroserver.sh stop Baro1
sleep 5
~/BarotraumaServer/baroserver.sh start Baro1
sleep 240
~/BarotraumaServer/baroserver.sh stop Baro2
sleep 5
~/BarotraumaServer/baroserver.sh start Baro2
sleep 240
