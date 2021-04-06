#!/usr/bin/env bash
set -euo pipefail

### Rofi - Application launcher

# Launch rofi
rofi \
    -show-icons \
    -theme solarized \
    -modi "drun" -show "drun"
