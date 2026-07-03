#!/data/data/com.termux/files/usr/bin/bash

echo "====================================="
echo "   OPS SYSTEM AUTO INSTALLER v1"
echo "====================================="

BASE="$HOME/outreach_app"

mkdir -p "$BASE"/{logs,data,brain,core}

cd "$BASE" || exit 1

# --------------------------
# CREATE BASIC APP IF MISSING
# --------------------------
cat > app.py << 'EOF'
from flask import Flask, jsonify

app = Flask(__name__)

@app.route("/")
def home():
    return jsonify({"status":"online","system":"outreach core v1"})

@app.route("/api/update", methods=["POST"])
def update():
    return jsonify({"status":"ok"})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
EOF

# --------------------------
# RUN SCRIPT (FIXED ALWAYS)
# --------------------------
cat > run.sh << 'EOF'
#!/data/data/com.termux/files/usr/bin/bash

echo "Starting Outreach System..."

pkill -f "python app.py" 2>/dev/null

nohup python app.py > logs/server.log 2>&1 &

echo "Server started on background"
echo "Logs: logs/server.log"
EOF

chmod +x run.sh

# --------------------------
# AUTO SYNC SCRIPT
# --------------------------
cat > auto_sync.sh << 'EOF'
#!/data/data/com.termux/files/usr/bin/bash

echo "🔄 Auto Git Sync..."

git add .
git commit -m "auto sync: $(date '+%Y-%m-%d %H:%M:%S')" 2>/dev/null
git push 2>/dev/null

echo "✅ Sync done"
EOF

chmod +x auto_sync.sh

# --------------------------
# OPS BRAIN v9 (LIGHT VERSION)
# --------------------------
cat > brain_v9.sh << 'EOF'
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
EOF

chmod +x brain_v9.sh

# --------------------------
# INIT GIT SAFETY
# --------------------------
git init 2>/dev/null

echo "====================================="
echo " INSTALL COMPLETE"
echo " RUN: cd ~/outreach_app && ./run.sh"
echo " BRAIN: ./brain_v9.sh"
echo " SYNC: ./auto_sync.sh"
echo "====================================="
