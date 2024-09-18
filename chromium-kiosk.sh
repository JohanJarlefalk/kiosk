#!/bin/bash

# Log start of script
echo "$(date): Chromium Kiosk script started." >> /home/christ/kiosk/chromium-kiosk.log

# Set environment variables
export DISPLAY=:0
export XAUTHORITY=/home/christ/.Xauthority  # Uncomment if required

# Optional: Add a delay to ensure the graphical session is ready
sleep 5

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
       --single-process \
       --ozone-platform=x11 \
       --enable-logging=stderr \
       --log-level=0"

# Log file path
LOGFILE=/home/christ/kiosk/chromium-kiosk.log

# Ensure the log directory exists
mkdir -p /home/christ/kiosk

# Loop to restart Chromium if it crashes
while true
do
    echo "$(date): Starting Chromium with URL: $URL" >> $LOGFILE
    $CHROME $FLAGS >> $LOGFILE 2>&1
    EXIT_CODE=$?
    echo "$(date): Chromium exited with code $EXIT_CODE. Restarting in 2 seconds..." >> $LOGFILE
    sleep 2  # Wait before restarting
done
