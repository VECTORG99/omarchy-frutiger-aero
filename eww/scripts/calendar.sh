#!/usr/bin/env python3
"""Calendar data for EWW — flat JSON with 42 day slots."""
import json, sys, calendar as cal_mod
from datetime import date

try:
    OFFSET = int(sys.argv[1]) if len(sys.argv) > 1 else 0
except ValueError:
    OFFSET = 0

today = date.today()
y, m = today.year, today.month
m += OFFSET
while m > 12:
    y += 1; m -= 12
while m < 1:
    y -= 1; m += 12

cal = cal_mod.Calendar(firstweekday=6)
weeks_raw = cal.monthdatescalendar(y, m)

data = {
    "month": cal_mod.month_name[m],
    "year": str(y),
}

idx = 0
for week in weeks_raw:
    for d in week:
        if d.month == m:
            data[f"d{idx:02d}"] = str(d.day)
            data[f"h{idx:02d}"] = "." if d == today else ""
        else:
            data[f"d{idx:02d}"] = ""
            data[f"h{idx:02d}"] = ""
        idx += 1

while idx < 42:
    data[f"d{idx:02d}"] = ""
    data[f"h{idx:02d}"] = ""
    idx += 1

json.dump(data, sys.stdout)
