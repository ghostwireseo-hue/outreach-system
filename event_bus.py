import json, time, os

EVENT_FILE = "logs/events.log"

def emit(event_type, data):
    event = {
        "time": time.time(),
        "type": event_type,
        "data": data
    }
    with open(EVENT_FILE, "a") as f:
        f.write(json.dumps(event) + "\n")
