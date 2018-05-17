#!/bin/bash
#
# saniTized conf / valid taskS v1.0-05162018a
# No sudo

# Need to probably insert \n after cams with no name to prevent strange formatting
# Mask password on entry?

nsnhint=$(cat /etc/resolv.conf |grep -o -P "\d{5}") 			
vf="~/Downloads/wts_valid_cams_"$nsnhint".txt"
upcams=$(arp|grep -c "ac:cc")

if [[ $upcams > 1 ]]; then
	echo ; echo "At least " $upcams" Axis devices appear to be up." >> "${vf}"
	echo "Cameras(16): " ; read cams
	echo "Camera un: " ; read un
	echo "Camera pass: " ; read cpw
	echo "Camera nw: " ; read nw
	echo "Camera fourth: " ; read fourth
	reftime=$(date '+%b %d, %Y %R:%S')
	echo >> "${vf}"
	echo "Collecting times from up to "$cams" cameras starting at "$nw$fourth >> "${vf}"
	echo "   " $reftime >> "${vf}"
	echo "[INFO] PLEASE WAIT (checking camera times)"
	echo "   "$reftime
	for (( i=1; i <= $cams; i++ )); do 
		echo -ne $fourth" " >> "${vf}"
		ping -c 1 $nw$fourth 2>&1 >/dev/null
		if [[ $? == 0 ]]; then
			curl -s --anyauth -u $un:$cpw 'http://'$nw$fourth'/axis-cgi/date.cgi?action=get' >> "${vf}"
			curl -s --anyauth -u $un:$cpw 'http://'$nw$fourth'/axis-cgi/operator/param_authenticate.cgi?action=list' |grep -o 'String=.\+' >> "${vf}"
			sudo sed -i 's/String=/ /' $vf ; tail -n 1 $vf
		else
			echo $fourth "[SKIP]" >> "${vf}" ; echo >> "${vf}" ; tail -n 1 $vf
		fi
		fourth=$((fourth+1))
		done
	echo "Done" ; sudo sed -i 's/String=/ /' $vf
	reftime=$(date '+%b %d, %Y %R:%S')
	echo "   " $reftime >> "${vf}" ; echo
	tail -n 20 $vf
fi



echo "End"
