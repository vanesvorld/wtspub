#!/bin/bash
# header: tun, hn, ovpnconf, resolv, sw, usbperm, udev, vs, vsu, varf,

ls /etc/openvpn/|grep -Po '\d{1,11}.conf' 
res=$(cat /etc/resolv.conf|grep -Po '\d{5}') ; echo $res".resolv,"
