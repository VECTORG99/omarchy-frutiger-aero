#!/usr/bin/env python3
import json, sys, calendar
from datetime import date

OFFSET = int(sys.argv[1]) if len(sys.argv) > 1 else 0

today = date.today()
y, m = today.year, today.month
m += OFFSET
while m > 12: y += 1; m -= 12
while m < 1: y -= 1; m += 12

cal = calendar.Calendar(firstweekday=6)
weeks_raw = cal.monthdatescalendar(y, m)

data = {
    "month": calendar.month_name[m],
    "year": str(y),
}
idx = 0
for week in weeks_raw:
    for d in week:
        if d.month == m:
            data[f"d{idx:02d}"] = str(d.day)
            data[f"t{idx:02d}"] = "true" if d == today else "false"
        else:
            data[f"d{idx:02d}"] = ""
            data[f"t{idx:02d}"] = "false"
        idx += 1
# Fill remaining slots (up to 42) with empty
while idx < 42:
    data[f"d{idx:02d}"] = ""
    data[f"t{idx:02d}"] = "false"
    idx += 1

print(json.dumps(data))
