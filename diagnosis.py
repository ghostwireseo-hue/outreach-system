import os

def analyze(log_file="logs/server.log"):
    if not os.path.exists(log_file):
        return "NO_LOGS"

    with open(log_file) as f:
        logs = f.read().lower()

    if "address already in use" in logs:
        return "PORT_CONFLICT"

    if "module not found" in logs:
        return "MISSING_DEPENDENCY"

    if "permission denied" in logs:
        return "PERMISSION_ERROR"

    if "traceback" in logs or "error" in logs:
        return "APP_CRASH"

    return "UNKNOWN"
