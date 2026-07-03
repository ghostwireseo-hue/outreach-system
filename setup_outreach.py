import os, json

project = "outreach_v2"

os.makedirs(f"{project}/templates", exist_ok=True)

# ---------------- app.py ----------------
app_py = r'''
from flask import Flask, render_template, request
import json
from datetime import datetime

app = Flask(__name__)

def load_logs():
    try:
        with open("data.json", "r") as f:
            return json.load(f)
    except:
        return []

@app.route("/")
def home():
    logs = load_logs()[::-1]

    html_logs = ""
    for log in logs[:10]:
        html_logs += f"<p><b>{log['time']}</b><br>{log['text']}</p><hr>"

    return f"""
    <html>
    <head>
        <title>Outreach Live System</title>
        <meta name="description" content="Live transparency outreach system and daily updates.">
    </head>

    <body style="font-family:Arial;background:#111;color:white;padding:20px">

    <h1>Live Outreach Feed</h1>

    <p>Transparent real-time updates.</p>

    <h2>Latest Updates</h2>
    {html_logs if html_logs else "<p>No updates yet.</p>"}

    <hr>
    <a href="/story" style="color:white">Story</a> |
    <a href="/support" style="color:lightgreen">Support</a>

    </body>
    </html>
    """

@app.route("/api/update", methods=["POST"])
def update():
    data = request.json

    logs = load_logs()

    logs.append({
        "time": str(datetime.now()),
        "text": data.get("text", "")
    })

    with open("data.json", "w") as f:
        json.dump(logs, f, indent=2)

    return {"status": "ok"}

@app.route("/story")
def story():
    return "<h1>Our Story</h1><p>Real-time documented recovery journey.</p>"

@app.route("/support")
def support():
    return """
    <h1>Support Us</h1>
    <p>Help with food, shelter, and transportation.</p>
    <a href='https://cash.app/$TravisLambert497'>Donate via Cash App</a>
    """

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
'''

# ---------------- data.json ----------------
data_json = "[]"

# write files
with open(f"{project}/app.py", "w") as f:
    f.write(app_py)

with open(f"{project}/data.json", "w") as f:
    f.write(data_json)

print("\nSETUP COMPLETE")
print("Run:")
print(f"cd {project}")
print("pip install flask")
print("python app.py")
