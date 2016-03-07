## Description

Simple udev rules and script that turns on the external display and turns off the internal display when the external display is plugged in (and resets when the external display is unplugged.)

## Installation

* (Fork and) clone the repository.
* Configure displays in `usr/local/bin/monitor-hotplug.sh` (see below)
* `sudo install usr/local/bin/monitor-hotplug.sh /usr/local/bin/`
* `sudo install -m644 etc/udev/rules.d/99-monitor-hotplug.rules /etc/udev/rules.d/`
* `sudo systemctl restart systemd-udevd`

## Configuration

For help configuring usr/local/bin/monitor-hotplug.sh, try the following:

1. run `xrandr` and note the output
  * `INTERAL_X_OUTPUT` should be set to the internal output name you find (e.g. `eDP` or `LVDS`)
  * `EXTERNAL_X_OUTPUT` should be set to the external output name you find (e.g. `HDMI-0` or `VGA-0`)
1. run `ls /sys/class/drm` and note the output
  * `EXTERNAL_DRM_CONNECTOR` should be set the the folder that most closely matches the `EXTERNAL_X_OUTPUT` (e.g. `card0-HDMI-A-1` or `card1-VGA-A-1`)

## Debuging
  * `sudo udevadm monitor`
  * Check what's happening when you plug / unplug your external monitor.
