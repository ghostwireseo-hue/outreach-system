#!/data/data/com.termux/files/usr/bin/bash

while true; do
  if ! pgrep -f app.py > /dev/null; then
    echo "⚠️ crash detected → restarting"
    nohup python app.py > logs/server.log 2>&1 &
  fi
  sleep 5
done
