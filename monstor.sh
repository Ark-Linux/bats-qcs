#!/bin/bash
echo `adb shell adk-message-monitor -a > log &`
echo `bats kim.bats > log_kim`
cat log_kim
sleep 1
cat log
sleep 1
cat log_adb_devices
sleep 1
cat log_country_code
kill -9 $(pgrep adb) 

