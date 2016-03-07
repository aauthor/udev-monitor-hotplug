#!/bin/bash -

# modify these three variables accordingly for your system
INTERAL_X_OUTPUT="LVDS"
EXTERNAL_X_OUTPUT="HDMI-0"
EXTERNAL_DRM_CONNECTOR="card0-HDMI-A-1"

EXTERNAL_MONITOR_STATUS=$(cat /sys/class/drm/$EXTERNAL_DRM_CONNECTOR/status)

export DISPLAY=":0"

user=$(loginctl list-users | grep -P '\d{4}' | awk '{print $2}') # Assuming uid >= 1000 #FIXME
if [ -n "$user" ]; then
  export XAUTHORITY="/home/$user/.Xauthority"
else
  echo "Unable to find an X session."
  exit 1
fi

if [[ $EXTERNAL_MONITOR_STATUS = "connected" ]]; then
  xrandr --output $INTERAL_X_OUTPUT --off --output $EXTERNAL_X_OUTPUT --auto
elif [[ $EXTERNAL_MONITOR_STATUS  = "disconnected" ]]; then
  xrandr --output $INTERAL_X_OUTPUT --auto --output $EXTERNAL_X_OUTPUT --off
fi
