#!/bin/bash

# Path to Chromium executable
CHROME=/usr/bin/chromium-browser

# URL to load
URL="http://localhost:8080/webvisu.htm"

# Chromium flags
FLAGS="--kiosk $URL --noerrdialogs --disable-infobars --disable-session-crashed-bubble --disable-restore-session-state --disable-prompt-on-repost --disable-extensions --disable-translate --disable-background-networking --disable-client-side-phishing-detection --disable-component-update --disable-default-apps --no-first-run --incognito --disable-gpu --fast --single-process"

# Loop to restart Chromium if it crashes
while true
do
    $CHROME $FLAGS
    sleep 2  # Wait before restarting
done
