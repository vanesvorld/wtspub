#!/bin/bash
# header: tun, hn, ovpnconf, resolv, sw, usbperm, udev, vs, vsu, varf,
#st=$(date +%s) # Provides little benefit

hn=$(hostname -A) ; echo $hn".hn,"
ls /etc/openvpn/|grep -Po '\d{1,11}.conf' 
res=$(cat /etc/resolv.conf|grep -Po '\d{5}') ; echo $res".resolv,"
ping -c 1 -t 1 192.168.2.98 2>&1 >/dev/null ; echo $?".switch," #0 pass

bus=$(lsusb -d 09ae:4004 |grep -o -P 'Bus \K\d{3}') ; device=$(lsusb -d 09ae:4004 |grep -o -P 'Device \K\d{3}') ; tlpath="/dev/bus/usb/"$bus"/"$device"" 
usbperm=$(ls -la "${tlpath}"|grep -c 'crw-rw-rw-') ; echo $usbperm".usbperm," #0 fail
test -s /etc/udev/rules.d/usb.rules ; echo $?".udevok," #0 pass
test -x /var/state ; echo $?".vsok," #0 pass
test -x /var/state/ups ; echo $?".vsuok," #0 pass
varf=$(ls -la /var/state/ups | grep -c "drwxrwxrwx") ; echo $varf".varf," #2 pass

cat /proc/mdstat |grep super ; echo ","
df |grep /dev/ ; echo ","
#et=$(date +%s) ; rt=$((et-st)) ; echo "rt: "$rt","
