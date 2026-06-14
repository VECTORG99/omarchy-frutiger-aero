#!/usr/bin/env python3
"""Generate analog clock SVG for EWW widget."""
import math
from datetime import datetime

SIZE = 160
CX = CY = SIZE / 2
R = 70  # clock face radius

def polar(cx, cy, r, angle_deg):
    rad = math.radians(angle_deg - 90)
    return cx + r * math.cos(rad), cy + r * math.sin(rad)

def hand(cx, cy, angle, length, width, color, glow=""):
    x2, y2 = polar(cx, cy, length, angle)
    g = f' stroke-linecap="round"'
    if glow:
        g += f' style="filter:url(#glow)"' if glow == "1" else ""
    return f'<line x1="{cx}" y1="{cy}" x2="{x2:.1f}" y2="{y2:.1f}" stroke="{color}" stroke-width="{width}"{g}/>'

now = datetime.now()
h = now.hour % 12
m = now.minute
s = now.second

ha = (h + m / 60) * 30
ma = (m + s / 60) * 6
sa = s * 6

svg = f'''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {SIZE} {SIZE}" width="{SIZE}" height="{SIZE}">
<defs>
  <filter id="glow"><feGaussianBlur stdDeviation="2"/></filter>
</defs>
<circle cx="{CX}" cy="{CY}" r="{R}" fill="none" stroke="#1B3D5C" stroke-width="4" opacity="0.4"/>
'''
# Hour ticks + numbers
for i in range(12):
    angle = i * 30
    x1, y1 = polar(CX, CY, R - 8, angle)
    x2, y2 = polar(CX, CY, R - 2, angle)
    nx, ny = polar(CX, CY, R - 18, angle)
    num = 12 if i == 0 else i
    svg += f'<line x1="{x1:.1f}" y1="{y1:.1f}" x2="{x2:.1f}" y2="{y2:.1f}" stroke="#557788" stroke-width="2" stroke-linecap="round"/>'
    svg += f'<text x="{nx:.1f}" y="{ny:.1f}" text-anchor="middle" dominant-baseline="central" font-size="11" font-family="Fira Sans, sans-serif" fill="#7799AA" font-weight="600">{num}</text>'

# Minute ticks
for i in range(60):
    if i % 5 != 0:
        angle = i * 6
        x1, y1 = polar(CX, CY, R - 4, angle)
        x2, y2 = polar(CX, CY, R - 2, angle)
        svg += f'<line x1="{x1:.1f}" y1="{y1:.1f}" x2="{x2:.1f}" y2="{y2:.1f}" stroke="#334455" stroke-width="1" stroke-linecap="round"/>'

# Hands
svg += hand(CX, CY, ha, R * 0.55, 5, "#C8F0F0", "1")
svg += hand(CX, CY, ma, R * 0.75, 4, "#1299CA", "")
svg += hand(CX, CY, sa, R * 0.85, 1.5, "#C880E0", "1")

# Center dot
svg += f'<circle cx="{CX}" cy="{CY}" r="5" fill="#1299CA"/>'
svg += f'<circle cx="{CX}" cy="{CY}" r="2.5" fill="#C8F0F0"/>'

svg += '</svg>'

CACHE = os.path.expanduser('~/.cache/eww/analog-clock.svg')
import os
os.makedirs(os.path.dirname(CACHE), exist_ok=True)
with open(CACHE, 'w') as f:
    f.write(svg)
print(CACHE)
