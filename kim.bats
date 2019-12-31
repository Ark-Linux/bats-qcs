#!/usr/bin/env bats


@test "adb devices" {                                    
  run echo `adb devices > log_adb_devices`
  
  [ $status -eq 0 ] 
  
}

@test "onboard" {  
                                    
  run adb shell adk-message-send 'connectivity_wifi_onboard{}'                                            
  [ $status -eq 0 ]
   
}

@test "country code" {  
  run echo `adb shell sed -n '99p' /etc/misc/wifi/sta_mode_hostapd.conf > log_country_code`
  [ $status -eq 0 ]
}



@test "connect to wifi" {  
                         
  run adb shell adk-message-send 'connectivity_wifi_connect {ssid:"Tencent"password:"tymph@ny123" homeap:true}'       
  
  [ $status -eq 0 ]
  sleep 15 
}


@test "exchange another wifi" {  
  run adb shell adk-message-send 'connectivity_wifi_onboard{}'
  sleep 1  
  run adb shell adk-message-send 'connectivity_wifi_connect {ssid:"Tencent-5G"password:"tymph@ny123" homeap:true}'
  [ $status -eq 0 ]
  sleep 15  
                                                         
}

@test "wifi_stauts" {  
  run echo `adb shell wpa_cli status > log_wifi_stauts`
  
  [ $status -eq 0 ]
  sleep 1
                                                         
}

@test "bt_enable" {  
  run echo `adb shell adk-message-send 'connectivity_bt_enable{}'`
  sleep 1
  run echo `adb shell adk-message-send 'connectivity_bt_getstate{}' > log_bt_state`

  [ $status -eq 0 ]
  sleep 1
                                                         
}



@test "bt_pair" {  
  run echo `adb shell adk-message-send 'connectivity_bt_pair{address : "a4:ca:a0:ae:e6:93"}' > log_bt_pair`
  [ $status -eq 0 ] 
  sleep 1
  run echo `adb shell adk-message-send 'connectivity_bt_connect{address : "a4:ca:a0:ae:e6:93"}' > log_bt_connect`
  [ $status -eq 0 ] 
  sleep 10
                                                        
}

@test "bt_connect" { 
  run echo `adb shell adk-message-send 'connectivity_bt_pair{address : "a4:ca:a0:ae:e6:93"}' > log_bt_pair`
  [ $status -eq 0 ] 
  sleep 1
  run echo `adb shell adk-message-send 'connectivity_bt_connect{address : "a4:ca:a0:ae:e6:93"}' > log_bt_connect`
  [ $status -eq 0 ] 
  sleep 10
  run echo `adb shell adk-message-send 'connectivity_bt_connect{address : "a4:ca:a0:ae:e6:93"}' > log_bt_connect`
  [ $status -eq 0 ]
  sleep 5
                                                         
}


