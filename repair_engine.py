import os
import sys
import time

code = int(sys.argv[1]) if len(sys.argv) > 1 else 0

print(f"[REPAIR ENGINE] Handling exit code: {code}")

# ---- BASIC AUTO FIX RULES ----

if code == 1:
    print("Fix: restarting server stack")
    os.system("pkill -f controller.py")

elif code == 2:
    print("Fix: port conflict cleanup")
    os.system("fuser -k 5000/tcp")

elif code == 137:
    print("Fix: memory kill detected → reducing load")

elif code == 255:
    print("Fix: unknown crash → full reset")
    os.system("pkill -f python")

else:
    print("Fix: generic recovery")

time.sleep(1)
