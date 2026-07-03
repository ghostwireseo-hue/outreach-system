#!/data/data/com.termux/files/usr/bin/bash

BASE="$(cd "$(dirname "$0")" && pwd)"
cd "$BASE" || exit 1

LOG="$BASE/logs"
mkdir -p "$LOG"

echo "🧠 OPS BRAIN v3 ACTIVE"

# ---------- SAFE START SERVER ----------
start_server() {
    if [ ! -f server.py ]; then
        echo "[HEAL] Missing server.py -> restoring"
        cat > server.py << 'PY'
from flask import Flask
app = Flask(__name__)

@app.route("/")
def home():
    return "OPS BRAIN v3 RECOVERED"

app.run(host="0.0.0.0", port=5000)
PY
    fi

    echo "[START] Flask server"
    nohup python server.py > "$LOG/server.log" 2>&1 &
    echo $! > "$LOG/server.pid"
}

# ---------- TUNNEL ----------
start_tunnel() {
    echo "[START] Cloudflare tunnel"
    nohup cloudflared tunnel --url http://127.0.0.1:5000 > "$LOG/tunnel.log" 2>&1 &
    echo $! > "$LOG/tunnel.pid"
}

# ---------- AUTO SYNC ----------
sync_git() {
    if [ -d ".git" ]; then
        git add -A >/dev/null 2>&1
        git commit -m "v3 auto-sync $(date)" >/dev/null 2>&1
        git push >/dev/null 2>&1
    fi
}

# ---------- SIMPLE DECISION ENGINE ----------
brain_loop() {
    while true; do
        sleep 10

        # check server alive
        if ! ps -p $(cat "$LOG/server.pid" 2>/dev/null) >/dev/null 2>&1; then
            echo "[HEAL] server died -> restart"
            start_server
        fi

        # auto sync occasionally
        sync_git
    done
}

start_server
start_tunnel

brain_loop
