#!/bin/sh

TVSERVICE=/opt/vc/bin/tvservice 

displayIsOn() {
	$TVSERVICE -s | grep "state 0x12001a" > /dev/null
}

turnOnDisplay() {
	if ! displayIsOn 
	then
		echo "schalte Display ein"

#		$TVSERVICE -p > /dev/null
		$TVSERVICE -e "DMT 82"
		sudo chvt 2
		sudo chvt 7
	fi
}

turnOffDisplay() {
	if displayIsOn
	then
		echo "schalte Display aus"

		$TVSERVICE -p > /dev/null
 		$TVSERVICE -o > /dev/null
	fi
}

showStatus() {
	if displayIsOn 
	then
		echo "on"
	else
		echo "off"
	fi
}

case $1 in
	on)	
		turnOnDisplay
		;;
	off)
		turnOffDisplay
		;;
	trigger)
		turnOnDisplay
		sleep 20s
		turnOffDisplay
		;;
	status)
		showStatus
		;;
esac
