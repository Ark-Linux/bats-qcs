#!/bin/bash

echo `bats kim.bats > log_kim`
cat log_kim
sleep 1
cat log_adb_devices
sleep 1
cat log_country_code
sleep 1
cat log_bt_pair
sleep 1
cat log_bt_connect
sleep 1
cat log_wifi_stauts
sleep 1
cat log_bt_state