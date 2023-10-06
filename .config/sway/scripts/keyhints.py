#!/bin/env python
from pathlib import Path

contents = Path('/home/owpk/.config/sway/scripts/keyhints.sh').read_text()
contents = str(contents)

print(contents)
