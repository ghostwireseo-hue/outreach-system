#!/data/data/com.termux/files/usr/bin/bash

cd ~/outreach_app || exit

echo "🔄 Starting auto-sync system..."

# Add all changes
git add .

# Check if there is anything to commit
if git diff --cached --quiet; then
    echo "⚠️ No changes detected. Skipping commit."
    exit 0
fi

# Create commit with timestamp
git commit -m "auto sync: $(date '+%Y-%m-%d %H:%M:%S')"

# Push safely
git push origin main

if [ $? -eq 0 ]; then
    echo "✅ Sync successful"
else
    echo "❌ Sync failed - check network or auth"
fi
