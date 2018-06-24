#!/bin/bash
# header: (t), h, o, r, sw, usbperm, udev, vs, vsu, varf,

hn=$(hostname -A) ; echo $hn".hn,"
ls /etc/openvpn/|grep -Po '\d{1,11}.conf' 
res=$(cat /etc/resolv.conf|grep -Po '\d{5}') ; echo $res".resolv,"
