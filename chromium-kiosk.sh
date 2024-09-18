#!/bin/bash

# Set DISPLAY environment variable
export DISPLAY=:0

# Optional: Set XAUTHORITY if your system requires it
# export XAUTHORITY=/home/christ/.Xauthority

# Path to Chromium executable
CHROME=/usr/bin/chromium-browser

# URL to load
URL="http://localhost:8080/webvisu.htm"

# Chromium flags
FLAGS="--kiosk $URL \
       --noerrdialogs \
       --disable-infobars \
       --disable-session-crashed-bubble \
       --disable-restore-session-state \
       --disable-prompt-on-repost \
       --disable-extensions \
       --disable-translate \
       --disable-background-networking \
       --disable-client-side-phishing-detection \
       --disable-component-update \
       --disable-default-apps \
       --no-first-run \
       --incognito \
       --disable-gpu \
       --fast \
       --single-process"

# Log file (optional)
LOGFILE=/home/christ/chromium-kiosk.log

# Loop to restart Chromium if it crashes
while true
do
    echo "$(date): Starting Chromium" >> $LOGFILE
    $CHROME $FLAGS >> $LOGFILE 2>&1
    echo "$(date): Chromium crashed. Restarting in 2 seconds..." >> $LOGFILE
    sleep 2  # Wait before restarting
done
