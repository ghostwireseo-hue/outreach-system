#!/data/data/com.termux/files/usr/bin/bash

APP="$HOME/outreach_app/controller.sh"

while true; do
  echo "🛡️ watchdog checking system..."

  if ! pgrep -f "python app.py" > /dev/null; then
    echo "⚠️ server down — restarting"
    bash "$APP" start
  fi

  sleep 10
done
