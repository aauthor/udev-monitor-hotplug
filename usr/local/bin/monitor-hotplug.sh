#!/bin/bash -

INTNAME="eDP1"
#INTSTATUS="connected"
EXTNAME="DP1"
EXTSTATUS=$(cat /sys/class/drm/card0-DP-1/status)

displaynum=`ls /tmp/.X11-unix/* | sed s#/tmp/.X11-unix/X##`
display=":$displaynum"
export DISPLAY=":$displaynum"

uid=$(loginctl list-users | grep -Po '\d{4}') # Assuming uid >= 1000 #FIXME
if [ -n "$uid" ]; then
  export XAUTHORITY=$(ps -C Xorg.bin -f --no-header | sed -n 's/.*-auth //; s/ -[^ ].*//; p')
else
  echo "unable to find an X session"
  exit 1
fi

if [[ $EXTSTATUS = "connected" ]]; then
  xrandr --output $INTNAME --off --output $EXTNAME --auto
  nitrogen --restore
elif [[ $EXTSTATUS = "disconnected" ]]; then
  xrandr --output $INTNAME --auto --output $EXTNAME --off
  nitrogen --restore
fi
