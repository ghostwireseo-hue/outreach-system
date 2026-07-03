#!/data/data/com.termux/files/usr/bin/bash

cd ~/outreach_app

termux-wake-lock

echo "[DAEMON] Self-managing AI server starting..."

while true; do
    python controller.py >> logs/system.log 2>&1
    EXIT_CODE=$?

    echo "[DAEMON] Controller died with code $EXIT_CODE"

    python repair_engine.py $EXIT_CODE

    echo "[DAEMON] Restarting in 2 seconds..."
    sleep 2
done
