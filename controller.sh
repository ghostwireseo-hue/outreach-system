#!/data/data/com.termux/files/usr/bin/bash

case "$1" in
  start)
    echo "🚀 OPS BRAIN v4 STARTING"
    nohup python app.py > logs/server.log 2>&1 &
    nohup python ops_brain.py > logs/brain.log 2>&1 &
    ;;
  stop)
    pkill -f app.py
    pkill -f ops_brain.py
    ;;
  status)
    ps aux | grep python | grep -v grep
    cat health.json 2>/dev/null
    ;;
  logs)
    tail -n 50 logs/server.log
    ;;
  events)
    tail -n 20 logs/events.log
    ;;
  *)
    echo "start|stop|status|logs|events"
    ;;
esac
