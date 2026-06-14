#!/usr/bin/env python3
"""Read CAVA raw output from FIFO and print JSON for EWW."""
import os, sys, json, struct

FIFO = os.path.expanduser("~/.cache/eww-music/cava.fifo")
BARS = 12

def read_bars():
    try:
        with open(FIFO, 'rb') as f:
            data = f.read(BARS)
            if len(data) == BARS:
                vals = struct.unpack('B' * BARS, data)
                return {f"cava_{i:02d}": max(2, int(v / 3)) for i, v in enumerate(vals)}
    except (IOError, OSError):
        pass
    return {f"cava_{i:02d}": 2 for i in range(BARS)}

print(json.dumps(read_bars()))
