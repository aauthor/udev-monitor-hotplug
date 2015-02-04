#!/bin/bash -

INTNAME="eDP1"
#INTSTATUS="connected"
EXTNAME="DP1"
EXTSTATUS=$(cat /sys/class/drm/card0-DP-1/status)

export DISPLAY=":0"

user=$(loginctl list-users | grep -P '\d{4}' | awk '{print $2}') # Assuming uid >= 1000 #FIXME
if [ -n "$user" ]; then
  export XAUTHORITY="/home/$user/.Xauthority"
else
  echo "Unable to find an X session."
  exit 1
fi

if [[ $EXTSTATUS = "connected" ]]; then
  xrandr --output $INTNAME --off --output $EXTNAME --auto
  nitrogen --restore || true
elif [[ $EXTSTATUS = "disconnected" ]]; then
  xrandr --output $INTNAME --auto --output $EXTNAME --off
  nitrogen --restore || true
fi
