# iFusion for Linux

An unofficial Linux replacement for the Windows-only iFusion software, for the
**HL HID Nixie** CPU cooler display (USB `f799:4707`).

- **Daemon** (systemd service): reads your CPU temperature and streams it to the cooler's display at boot.
- **GUI** (Qt, with tray icon): live temperature, manual/fixed value, sensor offset, update interval, service control.
- **Byte Explorer**: a tool for working out what the still-unknown packet bytes do.

> **Status:** only the temperature field is decoded so far. Colour, usage, units and other
> iFusion features are not implemented yet. Help decoding them is welcome (see [CONTRIBUTING](CONTRIBUTING.md)).

Tested on: Arch Linux, KDE Plasma, Ryzen 5 9600X (`k10temp`). Other AMD CPUs with `k10temp`
should work; Intel/other sensors are untested.

## Install (Arch Linux)

```bash
git clone https://github.com/YOURUSER/ifusion-linux.git
cd ifusion-linux
./install.sh
```

This installs the dependencies (`python-pyusb`, `pyside6`, `polkit`), the daemon, the GUI and the
systemd service, and starts it. Launch the GUI with `ifusion-linux` or from the app menu.
For the tray icon at login, tick **Start in the tray when I log in** in the GUI's Settings tab.

A `PKGBUILD` is also provided in `packaging/arch/` if you prefer building a pacman package.

## Update

```bash
git pull
./install.sh
sudo systemctl restart ifusion-linux
```

## Uninstall

```bash
./uninstall.sh
```
Your settings stay in `/var/lib/ifusion-linux/`; delete that folder to remove them too.

## Usage

```bash
systemctl status ifusion-linux        # is it running?
journalctl -u ifusion-linux -f        # live log
sudo systemctl restart ifusion-linux
```

## Troubleshooting

| Problem | Fix |
|---|---|
| Display shows nothing / GUI says "Cooler not found" | Make sure the cooler is not attached to a VM; only one owner at a time. Replug it, then `sudo systemctl restart ifusion-linux`. |
| "No CPU temperature sensor found" | `sudo modprobe k10temp` |
| "Resource busy" in logs | Another program (a VM, or `tools/probe.py`) holds the device. |
| GUI closes but the service keeps running | That is intended (tray). Launch the GUI again, or right-click the tray icon. |
| Cooler temperature differs from other tools | The daemon reports `Tctl`. Use the GUI's offset to adjust. |

## How it works

`ifusion-linux-daemon` (root) sends a 35-byte packet `01 01 <temp> 00...` to endpoint `0x01`
about once a second and exposes a control socket at `/run/ifusion-linux/control.sock`
(world-writable, so any local user can change the display settings). The GUI talks to that socket.
Protocol notes: [docs/PROTOCOL.md](docs/PROTOCOL.md). How the traffic was captured: [docs/CAPTURE_GUIDE.md](docs/CAPTURE_GUIDE.md).

## Repository layout

```
src/                 daemon and GUI
systemd/             service unit
data/                desktop entry, icon, module autoload
packaging/arch/      PKGBUILD (optional)
tools/probe.py       interactive byte probe
docs/                protocol notes and capture guide
install.sh / uninstall.sh
```

## Disclaimer

Not affiliated with the maker of the cooler or the iFusion software. Built by observing USB
traffic and probing the device; use at your own risk.

## License

MIT, see [LICENSE](LICENSE).
