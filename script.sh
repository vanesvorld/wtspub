#!/bin/bash
#
bus=$(lsusb -d 09ae:4004 |grep -o -P 'Bus \K\d{3}') 
device=$(lsusb -d 09ae:4004 |grep -o -P 'Device \K\d{3}') 
tlpath="/dev/bus/usb/"$bus"/"$device"" 
hostname -A && echo ".hn"
ls /etc/openvpn/|grep -Po '\d{1,11}.conf' 
cat /etc/resolv.conf|grep -Po '\d{5}' ; echo \$? ".resolv
ping -c 1 192.168.2.98 2>&1 >/dev/null ; echo \$? ".switch"
#lsusb -d 09ae:4004 
usbperm=$(sudo ls -la "${tlpath}"|grep -c 'crw-rw-rw-') ; echo \$? ".upsperm"
echo "Ok!"
