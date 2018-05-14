#!/bin/bash
#
bus=$(lsusb -d 09ae:4004 |grep -o -P 'Bus \K\d{3}') ; device=$(lsusb -d 09ae:4004 |grep -o -P 'Device \K\d{3}') ; tlpath="/dev/bus/usb/"$bus"/"$device"" 
hn=$(hostname -A) ; echo $hn".hn"
ls /etc/openvpn/|grep -Po '\d{1,11}.conf' 
res=$(cat /etc/resolv.conf|grep -Po '\d{5}') ; echo $res".resolv"
ping -c 1 -t 1 192.168.2.98 2>&1 >/dev/null ; echo $?".switch" #0 is pass
usbperm=$(ls -la "${tlpath}"|grep -c 'crw-rw-rw-'); echo $usbperm".usbperm" #0 is fail
test -s /etc/udev/rules.d/usb.rules ; echo $?".udevok" #0 is pass
test -x /var/state ; echo $?".vsok" #0 is pass
test -x /var/state/ups ; echo $?".vsuok" #0 is pass
varf=$(ls -la /var/state/ups | grep -c "drwxrwxrwx") ; echo $varf".varfolderok" #2 is pass2

#ex passing output:
#0.switch
#1.usbperm
#0.udevok
#0.vsok
#0.vsuok
#2.varfolderok

