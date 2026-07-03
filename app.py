from flask import Flask, request, jsonify
import json
from datetime import datetime

app = Flask(__name__)

DATA_FILE = "data.json"


def load_data():
    try:
        with open(DATA_FILE, "r") as f:
            return json.load(f)
    except:
        return []


def save_data(data):
    with open(DATA_FILE, "w") as f:
        json.dump(data, f, indent=2)


@app.route("/")
def home():
    logs = load_data()[::-1]

    html = ""
    for log in logs[:10]:
        html += f"<p><b>{log['time']}</b><br>{log['text']}</p><hr>"

    return f"""
    <html>
    <body style="font-family:Arial;background:#111;color:white;padding:20px">
        <h1>Outreach Live System</h1>

        <a href="https://cash.app/$TravisLambert497" style="color:lightgreen;">
            Donate via Cash App
        </a>

        <h2>Live Feed</h2>
        {html if html else "<p>No updates yet.</p>"}
    </body>
    </html>
    """


@app.route("/api/update", methods=["POST"])
def update():
    data = request.json

    logs = load_data()

    logs.append({
        "time": str(datetime.now()),
        "text": data.get("text", "")
    })

    save_data(logs)

    return jsonify({"status": "ok"})


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
