#!/bin/bash

# Log start of script
echo "$(date): Chromium Kiosk script started." >> /home/christ/kiosk/chromium-kiosk.log

# Set CPU governor to "performance" for all available cores (requires root privileges)
echo "performance" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo "performance" > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
echo "performance" > /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor
echo "performance" > /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor

# Set environment variables
export DISPLAY=:0
export XAUTHORITY=/home/christ/.Xauthority  # Uncomment if required

# Optional: Add a delay to ensure the graphical session is ready
sleep 10

# Path to Chromium executable
CHROME=/usr/bin/chromium-browser

# URL to load
URL="http://localhost:8080/webvisu.htm"

# Chromium flags optimized for performance
FLAGS="--kiosk $URL \
       --noerrdialogs \
       --password-store=basic \
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
       --ozone-platform=x11 \
       --enable-logging=stderr \
       --log-level=0 \
       --disable-speech-api \
       --disable-background-timer-throttling \
       --disable-backgrounding-occluded-windows \
       --disable-plugins \
       --disable-pinch \
       --disable-features=TranslateUI"

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
