#!/usr/bin/env bash
set -euo pipefail

WORKSPACE_DIR="${PWD}"
export DISPLAY=:99

echo "Starting dbus (if needed)..."
if ! pgrep -x dbus-daemon >/dev/null 2>&1; then
  /etc/init.d/dbus start >/dev/null 2>&1 || true
fi

echo "Starting Xvfb on :99..."
Xvfb :99 -screen 0 1920x1080x24 >/tmp/xvfb.log 2>&1 &
XVFB_PID=$!
sleep 1

echo "Starting xfce4 session..."
dbus-launch startxfce4 >/tmp/xfce4.log 2>&1 &
sleep 2

echo "Starting x11vnc on display :99 (RFB 5900)..."
x11vnc -display :99 -nopw -forever -shared -rfbport 5900 >/tmp/x11vnc.log 2>&1 &
sleep 1

echo "Starting websockify (noVNC) on port 6080..."
# websockify installed via venv; novnc files are in /opt/novnc
websockify --web /opt/novnc 6080 127.0.0.1:5900 >/tmp/websockify.log 2>&1 &
sleep 1

# XFCE desktop environment is now ready for use

echo "Startup complete. Open port 6080 from Codespaces 'Ports' panel and choose 'Open in Browser'."

exec bash
