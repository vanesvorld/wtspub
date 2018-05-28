#!/bin/bash
#
vpnconf=$(ls /etc/openvpn/ | grep -Po '\d{1,11}.conf')
echo $vpnconf
cat /etc/openvpn/$vpnconf
echo $vpnconf
