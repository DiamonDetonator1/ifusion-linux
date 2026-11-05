#!/bin/bash
# Manual installer (for the zip). Arch Linux. Installs to /usr/local.
set -e
cd "$(dirname "$0")"

echo ":: Installing dependencies"
sudo pacman -S --needed --noconfirm python python-pyusb pyside6 polkit

echo ":: Removing old test service (if any)"
sudo systemctl disable --now nixie.service 2>/dev/null || true
sudo rm -f /etc/systemd/system/nixie.service /usr/local/bin/nixie-daemon

echo ":: Installing files"
sudo install -Dm755 src/ifusion-linux-daemon /usr/local/bin/ifusion-linux-daemon
sudo install -Dm755 src/ifusion-linux /usr/local/bin/ifusion-linux
sed 's|/usr/bin/ifusion-linux-daemon|/usr/local/bin/ifusion-linux-daemon|' \
  systemd/ifusion-linux.service | sudo tee /etc/systemd/system/ifusion-linux.service >/dev/null
sudo install -Dm644 data/ifusion-linux.desktop /usr/local/share/applications/ifusion-linux.desktop
sudo install -Dm644 data/ifusion-linux.svg /usr/local/share/icons/hicolor/scalable/apps/ifusion-linux.svg
sudo install -Dm644 data/ifusion-linux-modules.conf /etc/modules-load.d/ifusion-linux.conf
sudo modprobe k10temp 2>/dev/null || true
sudo update-desktop-database /usr/local/share/applications 2>/dev/null || true

echo ":: Enabling service"
sudo systemctl daemon-reload
sudo systemctl enable --now ifusion-linux.service

echo
echo "Done. Service status:   systemctl status ifusion-linux"
echo "Launch the GUI:         ifusion-linux   (or find 'iFusion for Linux' in your app menu)"
