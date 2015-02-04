## Description

Simple udev rules and scripts to easily switch from laptop display to external display, and vice versa.

Forked from https://github.com/codingtony/udev-monitor-hotplug .

## Installation
  * Clone the repository.
  * `sudo install usr/local/bin/monitor-hotplug.sh /usr/local/bin/`
  * `sudo install -m644 etc/udev/rules.d/99-monitor-hotplug.rules /etc/udev/rules.d/`
  * `sudo systemctl restart systemd-udevd`

## Debuging
  * `sudo udevadm monitor`
  * Check what's happening when you plug / unplug your external monitor.
