#!/bin/bash
# header: tun, hn, ovpnconf, resolv, sw, usbperm, udev, vs, vsu, varf,

ls /etc/openvpn/|grep -Po '\d{1,11}.conf' 
res=$(cat /etc/resolv.conf|grep -Po '\d{5}') ; echo $res".resolv,"
# Begin nsnhint
nsnhint=$(cat /etc/resolv.conf |grep -o -P "\d{5}")
nsn=$(echo "$nsnhint")
if [[ $nsnhint = "" ]]; then
	echo "Couldn't determine NSN. Please enter it now (enter): "
	read -t 2 -p "Couldn't determine NSN. Please enter it now (2s)" -n 1 -r
	#read nsn ; nsn=$(echo "$nsnhint")
fi
#End nsnhint

#Begin other info
echo "Need cam pw: " ; read cpw
fo=$'102'
#echo "Need fourth octet: " ; read fo
nw=$'192.168.2.'
cmid=$'/axis-cgi/operator/param.cgi?action='
# End other info

# Begin camera read loop? Maybe we define the range of cameras or whatever
# Important to note that this defaults at 17 cameras
for (( i=1; i<17; i++ )); do
	ping -c 1 $nw$fo 2>&1 >/dev/null
		if [[ $? -eq 0 ]]; then
			ov=$(curl -s --anyauth -u root:$cpw 'http://'$nw$fo$cmid'list&group=Image.I0.Text.String' | cut -c 22-99)
			curl -s --anyauth -u root:$cpw 'http://'$nw$fo$cmid'list&group=Brand.ProdNbr' | cut -c 15-99
			curl -s --anyauth -u root:$cpw 'http://'$nw$fo$cmid'list&group=Image.I0.Appearance.Resolution' | cut -c 32-99
			curl -s --anyauth -u root:$cpw 'http://'$nw$fo$cmid'list&group=Network.IPAddress' | cut -c 19-99
			curl -s --anyauth -u root:$cpw 'http://'$nw$fo$cmid'list&group=Network.eth0.MACAddress' | cut -c 25-99
			curl -s --anyauth -u root:$cpw 'http://'$nw$fo$cmid'list&group=Properties.Firmware.Version' | cut -c 29-99
			curl -s --anyauth -u root:$cpw 'http://'$nw$fo$cmid'list&group=Properties.System.SerialNumber' | cut -c 32-99
			curl -s --anyauth -u root:$cpw 'http://'$nw$fo$cmid'list&group=Time.POSIXTimeZone' | cut -c 20-99
			curl -s --anyauth -u root:$cpw 'http://'$nw$fo$cmid'list&group=Time.SyncSource' | cut -c 17-99
			curl -s --anyauth -u root:$cpw 'http://'$nw$fo$cmid'list&group=Time.NTP.Server' | cut -c 17-99
			echo "This is the current overlay of the camera at "$nw$fo": "$ov
			# Begin camera write loop
			#read -t 5 -p "Really do it? (y/n, 5s)" -n 1 -r ; echo
			#if [[ $REPLY =~ ^[Yy]$ ]]; then
			#        curl -s --anyauth -u root:$cpw 'http://'$nw$fo$cmid'update&Image.I0.Text.String='$newov
			#        #curl --anyauth -s -u root:$cpw 'http://'$nw$fo'/axis-cgi/jpg/image.cgi' -o $nsn_$nw$fo'.jpg' # Grab collat
			#        # This little snippet might help crop the image off (for 720p, probably need tweak for 1920)
			#        #head  -c 10000 $nsn_$nw$fo.jpg > $nsn_$nw$fo_cropped.jpg
			#fi
			newov=\($nsn\)$ov # Concat new overlay
			echo "This is the overlay we are going to write to the camera at "$nw$fo": "$newov
			fo=$((fo+1))
		else
			echo "Skip" $fo
			fo=$((fo+1))
		fi
done
