#!/bin/bash

# Determine absolute script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Kill any leftovers
"$SCRIPT_DIR/stop-remote-chromium.sh"

# Start X virtual display
Xvfb :99 -screen 0 1280x720x24 > /dev/null 2>&1 &
export DISPLAY=:99
sleep 2

# Start VNC and Chromium
x11vnc -display :99 -nopw -forever -bg
chromium --disable-gpu --start-maximized > /dev/null 2>&1 &

# Start noVNC in foreground so systemd stays alive
cd "$SCRIPT_DIR/noVNC"
exec "$SCRIPT_DIR/noVNC/utils/novnc_proxy" --vnc localhost:5900
