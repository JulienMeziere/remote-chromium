#!/bin/bash

# Kill background processes cleanly
pkill -x Xvfb
pkill -x x11vnc
pkill -x chromium
pkill -f "utils/novnc_proxy"

# Clean up X display lock
rm -f /tmp/.X99-lock
rm -rf /tmp/.X11-unix/X99
