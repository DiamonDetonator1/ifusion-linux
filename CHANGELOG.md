# Changelog

## 1.0.1
- Fix: relaunching the GUI after closing it to the tray now brings the existing
  window back instead of flashing and exiting (single-instance via local socket).

## 1.0.0
- Initial release: root daemon feeding CPU temperature (`k10temp`) to the cooler,
  Qt GUI with tray icon, Byte Explorer, systemd service, installer.
