#!/usr/bin/env bats


@test "fastboot" {  
                                    
   
  run echo `python fastboot_all.py > log`                                           
  [ $status -eq 0 ]
  sleep 90
   
}


@test "onboard" {  
                                    
  run adb shell adk-message-send 'connectivity_wifi_onboard{}'                                            
  [ $status -eq 0 ]
  sleep 5
   
}

@test "country code" {  
  run echo `adb shell sed -n '99p' /etc/misc/wifi/sta_mode_hostapd.conf  >> log`
  [ $status -eq 0 ]
  sleep 1
}



@test "connect to wifi" {  
                         
 run adb shell "adk-message-send 'connectivity_wifi_connect {ssid:\"Kim\"password:\"123456789\" homeap:true}'"       
  
  [ $status -eq 0 ]
  sleep 20
}


@test "exchange another wifi" {  
  run adb shell adk-message-send 'connectivity_wifi_onboard{}'
  sleep 1  
  run adb shell "adk-message-send 'connectivity_wifi_connect {ssid:\"Kim\"password:\"123456789\" homeap:true}'" 
  [ $status -eq 0 ]
  sleep 20
                                                         
}

@test "wifi_stauts" {  
  run echo `adb shell wpa_cli status >> log`
  [ $status -eq 0 ]
  sleep 1
                                                         
}




@test "bt_pair" {  
  run adb shell adk-message-send 'connectivity_bt_enable{}'
  sleep 2
  [ $status -eq 0 ]
  run echo `adb shell adk-message-send 'connectivity_bt_pair{address:\"a4:\ca:\a0:\ae:\e6:\93\"}' > log_bt_pair`
  [ $status -eq 0 ] 
  sleep 5
  run echo `adb shell adk-message-send 'connectivity_bt_connect{address:\"a4:\ca:\a0:\ae:\e6:\93\"}' > log_bt_connect`
  [ $status -eq 0 ] 
  sleep 5
                                                        
}

@test "bt_connect" { 
  run echo `adb shell adk-message-send 'connectivity_bt_pair{address:\"a4:\ca:\a0:\ae:\e6:\93\"}' > log_bt_pair`
  [ $status -eq 0 ] 
  sleep 1
  run echo `adb shell adk-message-send 'connectivity_bt_connect{address:\"a4:\ca:\a0:\ae:\e6:\93\"}' > log_bt_connect`
  [ $status -eq 0 ] 
  sleep 10
  run echo `adb shell adk-message-send 'connectivity_bt_connect{address:\"a4:\ca:\a0:\ae:\e6:\93\"}' > log_bt_connect`
  [ $status -eq 0 ]
  sleep 5
  run echo `adb shell adk-message-send 'connectivity_bt_getstate{}'` 
  [ $status -eq 0 ]
  sleep 5  
}


@test "exchange wifi code" {  
                                   
  run adb shell adk-message-send 'connectivity_wifi_onboard{}'         
  sleep 5
  run echo `adb shell adkcfg -f /data/adk.connectivity.wifi.db write connectivity.wifi.onboard_ap_country_code CF --ignore`
  sleep 3
  run adb reboot
  sleep 60
  run adb shell "adk-message-send 'connectivity_wifi_connect {ssid:\"Kim\"password:\"123456789\" homeap:true}'" 
  sleep 20 
  [ $status -eq 0 ]
  
                                                         
}

@test "new_country_code" {  
  run echo `adb shell sed -n '99p' /etc/misc/wifi/sta_mode_hostapd.conf  >> log`
  [ $status -eq 0 ]
  sleep 1
}




@test "alexa_onboarding" { 
  run echo ` adb shell adk-message-monitor -a > alexa_log &`
  
  [ $status -eq 0 ]
  sleep 1
  run echo `adb shell adk-message-send 'voiceui_start_onboarding{client:\"AVS\"}'` 
  [ $status -eq 0 ]
  sleep 10
}

