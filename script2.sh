#!/bin/bash
#
bus=$(lsusb -d 09ae:4004 |grep -o -P 'Bus \K\d{3}') 
device=$(lsusb -d 09ae:4004 |grep -o -P 'Device \K\d{3}') 
tlpath="/dev/bus/usb/"$bus"/"$device"" 
echo hostname -A".hn"
ls /etc/openvpn/|grep -Po '\d{1,11}.conf' 
echo cat /etc/resolv.conf|grep -Po '\d{5}'".resolv"
echo ping -c 1 192.168.2.98 2>&1 >/dev/null".switch"
#lsusb -d 09ae:4004 
usbperm=$(ls -la "${tlpath}"|grep -c 'crw-rw-rw-')
echo $usbperm
echo "Ok!"
