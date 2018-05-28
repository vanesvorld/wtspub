#!/bin/bash
#
vpnconf=$(ls /etc/openvpn/ | grep -Po '\d{1,11}.conf')
echo $vpnconf
cat /etc/openvpn/mcdonalds-$vpnconf
echo $vpnconf
