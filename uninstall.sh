#!/bin/bash
set -e
sudo systemctl disable --now ifusion-linux.service 2>/dev/null || true
sudo rm -f /etc/systemd/system/ifusion-linux.service \
  /usr/local/bin/ifusion-linux-daemon /usr/local/bin/ifusion-linux \
  /usr/local/share/applications/ifusion-linux.desktop \
  /usr/local/share/icons/hicolor/scalable/apps/ifusion-linux.svg \
  /etc/modules-load.d/ifusion-linux.conf
sudo systemctl daemon-reload
rm -f ~/.config/autostart/ifusion-linux.desktop
echo "Removed. Config left in /var/lib/ifusion-linux (delete it if you want)."
