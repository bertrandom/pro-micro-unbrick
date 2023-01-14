#!/bin/bash

# Linux Script for unbricking a Sparkfun Pro Micro
# Successfully downloading a program unbricks the bootloader but
# this is time sensitive. Grounding the reset pin twice in quick 
# succession wakes the bootloader up & opens the USB port for 8 seconds,
# which is usually not enough time to manually select the port
# and start an upload with the Arduino IDE.

# Needs a precompiled program such as Blink in HEX form, to find the hex:
# switch on verbose compile in Arduino IDE & check output to see
# where the HEX file is put, usually in /tmp.   
# Then copy the HEX file to a known place, see INOHEX below

# The script loops until PORT is detected and then immediately
# runs avrdude. The script grabs the port well before 8 seconds expires.

# After a program has been successfully installed the Arduino IDE
# should recognise the Pro Micro normally. 

INOHEX="Blink.ino.with_bootloader.hex"
PORT="/dev/cu.usbmodem21201"

# Loop until port exists
while ! [ -e $PORT ]
do
	echo Reset Pro Micro twice or ctrl-c to exit
    echo `date`
	sleep 0.33
done

# Got the port, do the download!
avrdude -v -patmega32u4 -cavr109 -P $PORT -b57600 -D -U flash:w:$INOHEX:i