#!/data/data/com.termux/files/usr/bin/bash

echo "Starting Outreach System..."

# kill old servers safely
pkill -f live_app.py

# wait a moment
sleep 1

# start server in background
nohup python live_app.py > server.log 2>&1 &

echo "Server started on background"
echo "Logs: server.log"
