#!/bin/bash
#
bus=$(lsusb -d 09ae:4004 |grep -o -P 'Bus \K\d{3}') ; device=$(lsusb -d 09ae:4004 |grep -o -P 'Device \K\d{3}') ; tlpath="/dev/bus/usb/"$bus"/"$device"" 
hn=$(hostname -A) ; echo $hn".hn"
ls /etc/openvpn/|grep -Po '\d{1,11}.conf' 
res=$(cat /etc/resolv.conf|grep -Po '\d{5}') ; echo $res".resolv"
ping -c 1 -t 1 192.168.2.98 2>&1 >/dev/null ; echo $?".switch"
usbperm=$(ls -la "${tlpath}"|grep -c 'crw-rw-rw-'); echo $usbperm".usbperm"
test -s /etc/udev/rules.d/usb.rules ; echo $?".udevok"
test -x /var/state ; echo $?".vsok"
test -x /var/state/ups ; echo $?".vsuok"
varf=$(ls -la /var/state/ups | grep -c "drwxrwxrwx") ; echo $varf".varfolderok" #must be gt 2
