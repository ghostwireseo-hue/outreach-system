#!/data/data/com.termux/files/usr/bin/bash

BASE="$HOME/outreach_app"
LOG="$BASE/logs/brain.log"

mkdir -p "$BASE/logs"

echo "🧠 OPS BRAIN ONLINE" >> "$LOG"

while true
do
    if ! pgrep -f "python app.py" >/dev/null; then
        echo "[FIX] restarting app" >> "$LOG"
        pkill -f "python app.py"
        cd "$BASE"
        nohup python app.py >> logs/server.log 2>&1 &
    fi

    sleep 10
done
