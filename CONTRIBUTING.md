# Contributing

The most useful contribution is **decoding more of the packet** (bytes 3-34).

1. Stop the service: `sudo systemctl stop ifusion-linux` (or use the GUI's Byte Explorer).
2. Set one byte at a time, watch the display, reset between tests.
3. Open an issue or PR describing: byte index, values tried, what the display did.

See `docs/PROTOCOL.md` for what is known and `docs/CAPTURE_GUIDE.md` for how to
capture the original iFusion traffic on a Windows VM.

Code style: plain Python 3, no extra dependencies beyond `pyusb` and `PySide6`.
