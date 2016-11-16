#!/bin/sh

#Set our Window Title
@title ROOT SHELL TEST
mode 100,30
echo.--------------------------------------------------------------------------------------------
echo.--------------------------------------------------------------------------------------------
echo [*] BEFORE WE BEGIN THE SCRIPT WILL RUN "ADB DEVICES" AND SEE IF YOU HAVE DRIVERS INSTLLED
echo [*] THE NEEDED RESPONSE IS SIMILAR TO BELOW 
echo [*]
echo [*] List of devices attached
echo [*] ****************        device
echo [*] 
echo [*] INSTEAD OF STARS IT WILL BE YOUR SERIAL NUMBER 
echo [*] IF NO DEVICE LISTED YOU ARE NOT READY TO RUN THIS SCRIPT. CLOSE THIS WINDOW NOW IF NOT READY
echo [*] 
echo [*] IF DEVICE IS LISTED PRESS ANY KEY ON COMPUTER TO START
echo [*]
adb devices
read -rsp $'Press enter to continue...\n'
adb wait-for-device
clear
echo [*] copying dirtycow to /data/local/tmp/dirtycow
adb push pushed/dirtycow /data/local/tmp/dirtycow
sleep 2 
echo [*] copying recowvery-app_process32 to /data/local/tmp/recowvery-app_process32
adb push pushed/recowvery-app_process32 /data/local/tmp/recowvery-app_process32
sleep 2 
echo [*] copying busybox to /data/local/tmp/busybox
adb push pushed/busybox /data/local/tmp/busybox
sleep 2 
echo [*] copying cp_comands.txt to /data/local/tmp/cp_comands.txt
adb push pushed/cp_comands.txt /data/local/tmp/cp_comands.txt
sleep 2 
echo [*] changing permissions on copied files
adb shell chmod 0777 /data/local/tmp/*
sleep 2 
clear
echo.--------------------------------------------------------------------------------------------
echo [*] DONE PUSHING FILES TO PHONE. NOW WE ARE GOING TO TEMP WRITE OVER THE APP_PROCESS
echo [*] WITH A MODIFIED VERSION THAT HAS lsh IN IT USING A SYSTEM-SERVER AS ROOT SHELL
echo [*] THIS STEP WILL CAUSE PHONE TO DO A SOFT REBOOT AND WILL NOT RESPOND TO BUTTON PUSHES
echo [*] 
adb shell /data/local/tmp/dirtycow /system/bin/app_process32 /data/local/tmp/recowvery-app_process32
echo.--------------------------------------------------------------------------------------------
clear
echo.--------------------------------------------------------------------------------------------
echo.--------------------------------------------------------------------------------------------
echo [*]WAITING 60 SECONDS FOR ROOT SHELL TO SPAWN
sleep 60 > nul
echo.--------------------------------------------------------------------------------------------
echo [*] OPENING A ROOT SHELL ON THE NEWLY CREATED SYSTEM_SERVER
echo [*] CREATE A NEW DIRECTORY AS A TEST
echo [*] CHANGING PERMISSIONS ON NEW DIRECTORY
adb shell "/data/local/tmp/busybox nc localhost 11112 < /data/local/tmp/cp_comands.txt"
read -rsp $'Press enter to continue...\n'
clear
echo [*]  
echo.--------------------------------------------------------------------------------------------
echo.--------------------------------------------------------------------------------------------
echo [*] PRESS ENTER KEY TO FINISH THIS SCRIPT.
read -rsp $'Press enter to continue...\n'
exit