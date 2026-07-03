import time, json
from diagnosis import analyze
from actions import fix
from event_bus import emit

STATE_FILE = "health.json"

def load():
    try:
        return json.load(open(STATE_FILE))
    except:
        return {"score": 100, "failures": 0}

def save(s):
    json.dump(s, open(STATE_FILE, "w"), indent=2)

def tick():
    state = load()

    issue = analyze()

    emit("diagnosis", {"issue": issue})

    print("🧠 DETECTED:", issue)

    if issue != "UNKNOWN":
        state["failures"] += 1
        fix(issue)
        state["score"] -= 10
    else:
        state["failures"] = 0
        state["score"] = min(100, state["score"] + 1)

    if state["failures"] >= 3:
        print("🧨 SAFE MODE ENGAGED (no destructive rollback)")
        state["score"] = 30

    save(state)

if __name__ == "__main__":
    while True:
        tick()
        time.sleep(6)
