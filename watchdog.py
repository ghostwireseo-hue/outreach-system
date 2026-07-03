import requests
import time
import json

URL = "http://127.0.0.1:5000"

def check():
    try:
        r = requests.get(URL, timeout=2)
        return r.status_code == 200
    except:
        return False

while True:
    status = check()

    with open("health.json", "w") as f:
        json.dump({"alive": status}, f)

    if not status:
        print("[WATCHDOG] System unhealthy")

    time.sleep(3)
