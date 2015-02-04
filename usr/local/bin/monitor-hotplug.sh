#!/bin/bash -

INTNAME="eDP1"
#INTSTATUS="connected"
EXTNAME="DP1"
EXTSTATUS=$(cat /sys/class/drm/card0-DP-1/status)

displaynum=`ls /tmp/.X11-unix/* | sed s#/tmp/.X11-unix/X##`
display=":$displaynum"
export DISPLAY=":$displaynum"

user=$(loginctl list-users | grep -P '\d{4}' | awk '{print $2}') # Assuming uid >= 1000 #FIXME
if [ -n "$user" ]; then
  export XAUTHORITY="/home/$user/.Xauthority"
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
