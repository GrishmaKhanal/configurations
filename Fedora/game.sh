#!/bin/bash

# Get the current date and time in the format YYYY-MM-DD_HH-MM-SS
CURRENT_TIME=$(date +"%Y-%m-%d_%H-%M-%S")

# Define the log file path with the date and time
LOG_FILE="steam_logs/app_output_$CURRENT_TIME.log"
touch $LOG_FILE

# Launch the app and log output continuously
unbuffer steam >& "$LOG_FILE" &
APP_PID=$!

wait $APP_PID
