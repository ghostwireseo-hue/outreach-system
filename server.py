from flask import Flask
app = Flask(__name__)

@app.route("/")
def home():
    return "OPS BRAIN v3 READY"

app.run(host="0.0.0.0", port=5000)
