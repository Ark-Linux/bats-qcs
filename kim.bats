#!/usr/bin/env bats



@test "fastboot_test" {  
  run echo `python fastboot_all.py > log`                                           
  [ $status -eq 0 ]
  sleep 90
   
}


@test "wifi_onboard" {  
                                    
  run adb shell adk-message-send 'connectivity_wifi_onboard{}'                                            
  [ $status -eq 0 ]
  sleep 5
   
}

@test "country_code" {  
  run echo `adb shell sed -n '99p' /etc/misc/wifi/sta_mode_hostapd.conf  >> log`
  [ $status -eq 0 ]
  sleep 1
}



@test "connect_to_wifi" {  
                        
  run adb shell "adk-message-send 'connectivity_wifi_connect {ssid:\"white_cat_wifi\"password:\"cattish1313\" homeap:true}'"
  [ $status -eq 0 ]
  sleep 20
}


@test "exchange_another_wifi" {  
  run adb shell adk-message-send 'connectivity_wifi_onboard{}'
  sleep 1  
  run adb shell "adk-message-send 'connectivity_wifi_connect {ssid:\"white_cat_wifi\"password:\"cattish1313\" homeap:true}'"
  [ $status -eq 0 ]
  sleep 20
                                                         
}

@test "wifi_status" {  
  run echo `adb shell wpa_cli status >> log`
  [ $status -eq 0 ]
  sleep 1
                                                         
}




@test "bt_pair" { 
  run adb shell adk-message-send 'connectivity_bt_enable{}'
  sleep 5
  [ $status -eq 0 ]
  run adb shell adk-message-send 'connectivity_bt_pair{address:\"a4:\ca:\a0:\ae:\e6:\93\"}'
  [ $status -eq 0 ] 
  sleep 10
                                                        
}

@test "bt_connect" { 

  run adb shell adk-message-send 'connectivity_bt_connect{address:\"a4:\ca:\a0:\ae:\e6:\93\"}'
  [ $status -eq 0 ] 
  sleep 10
  run adb shell adk-message-send 'connectivity_bt_connect{address:\"a4:\ca:\a0:\ae:\e6:\93\"}'
  [ $status -eq 0 ]
  sleep 5
  run adb shell adk-message-send 'connectivity_bt_getstate{}'
  [ $status -eq 0 ]
  sleep 5  
}


@test "exchange_wifi_code" {  
                                   
  run adb shell adk-message-send 'connectivity_wifi_onboard{}'         
  sleep 5
  run echo `adb shell adkcfg -f /data/adk.connectivity.wifi.db write connectivity.wifi.onboard_ap_country_code CN --ignore`
  sleep 3
  run adb reboot
  sleep 60
  run adb shell adk-message-send 'connectivity_wifi_onboard{}'
  sleep 10
 
  run adb shell "adk-message-send 'connectivity_wifi_connect {ssid:\"white_cat_wifi\"password:\"cattish1313\" homeap:true}'" 
  sleep 20 
  [ $status -eq 0 ]
  run adb shell adk-message-send 'connectivity_wifi_completeonboarding{}'
  sleep 20 
  [ $status -eq 0 ]
  
                                                         
}

@test "new_country_code" {  
  run echo `adb shell sed -n '99p' /etc/misc/wifi/sta_mode_hostapd.conf  >> log`
  [ $status -eq 0 ]
  sleep 1
}




@test "alexa_onboarding" { 
  run adb push /home/pi/Desktop/fastboot_package/alexafile/alerts.db /data
  [ $status -eq 0 ]
  sleep 2
  run adb push /home/pi/Desktop/fastboot_package/alexafile/AlexaClientSDKConfig.json /data
  [ $status -eq 0 ]
  sleep 2
  run adb push /home/pi/Desktop/fastboot_package/alexafile/cblAuthDelegate.db /data
  [ $status -eq 0 ]
  sleep 2
  run adb push /home/pi/Desktop/fastboot_package/alexafile/certifiedsender.db /data
  [ $status -eq 0 ]
  sleep 2 
  run adb push /home/pi/Desktop/fastboot_package/alexafile/devicesettings.db /data
  [ $status -eq 0 ]
  sleep 2
  run adb push /home/pi/Desktop/fastboot_package/alexafile/entropy_file /data
  [ $status -eq 0 ]
  sleep 2
  run adb push /home/pi/Desktop/fastboot_package/alexafile/miscDatabase.db /data
  [ $status -eq 0 ]
  sleep 2
  run adb push /home/pi/Desktop/fastboot_package/alexafile/notifications.db /data
  [ $status -eq 0 ]
  sleep 2
  run adb push /home/pi/Desktop/fastboot_package/alexafile/settingsca.db /data
  [ $status -eq 0 ]
  sleep 2
  run adb push /home/pi/Desktop/fastboot_package/alexafile/voiceDumpAVS /data/voice-ui-framework
  sleep 2
  [ $status -eq 0 ]
  run adb reboot
  [ $status -eq 0 ]
  sleep 40  
  run adb shell "adk-message-send 'connectivity_wifi_connect {ssid:\"white_cat_wifi\"password:\"cattish1313\" homeap:true}'" 
  [ $status -eq 0 ]
  sleep 20 
  run adb shell adk-message-send 'connectivity_wifi_completeonboarding{}'
  sleep 20 
  [ $status -eq 0 ]
  sleep 10
}


@test "audio_auto_test" {  
 run adb shell "adk-message-send 'voiceui_start_onboarding{client:\"AVS\"}'"
  sleep 2 
  run aplay test0.wav
  [ $status -eq 0 ]
  sleep 6
  run aplay test0.wav
 [ $status -eq 0 ]
  sleep 6
 run aplay test0.wav
 [ $status -eq 0 ]
  sleep 6
}



