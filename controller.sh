#!/data/data/com.termux/files/usr/bin/bash

APP_DIR="$HOME/outreach_app"
PORT=5000

cd "$APP_DIR" || exit

echo "🧠 AI OPS CONTROLLER v1"

stop() {
  echo "Stopping server..."
  pkill -f "python app.py" 2>/dev/null
  pkill -f "live_app.py" 2>/dev/null
}

start() {
  stop
  echo "Starting server..."
  nohup python app.py > logs/server.log 2>&1 &
  echo "Running on port $PORT"
}

status() {
  ps aux | grep python | grep -v grep
}

sync() {
  git add .
  git commit -m "auto sync $(date)"
  git push
}

case "$1" in
  start) start ;;
  stop) stop ;;
  restart) start ;;
  status) status ;;
  sync) sync ;;
  *) echo "Usage: start|stop|restart|status|sync" ;;
esac
