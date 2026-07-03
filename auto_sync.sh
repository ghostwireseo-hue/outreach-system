#!/data/data/com.termux/files/usr/bin/bash
git add -A
git commit -m "manual sync $(date)" >/dev/null 2>&1
git push >/dev/null 2>&1
echo "Synced"
