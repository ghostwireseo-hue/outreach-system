import os

def fix(action_type):
    if action_type == "PORT_CONFLICT":
        print("🔧 Killing duplicate processes")
        os.system("pkill -f app.py")

    elif action_type == "MISSING_DEPENDENCY":
        print("📦 Attempting safe pip repair")
        os.system("pip install -r requirements.txt 2>/dev/null")

    elif action_type == "APP_CRASH":
        print("♻️ Restarting app safely")
        os.system("pkill -f app.py")
        os.system("nohup python app.py > logs/server.log 2>&1 &")

    elif action_type == "PERMISSION_ERROR":
        print("⚠️ No auto-fix (requires manual action)")

    else:
        print("🤷 No safe fix available")
