from flask import Flask, jsonify, request

app = Flask(__name__)

@app.route("/")
def home():
    return jsonify({"status":"online","system":"ops v2"})

@app.route("/api/update", methods=["POST"])
def update():
    data = request.json
    return jsonify({"received": data, "status":"ok"})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
