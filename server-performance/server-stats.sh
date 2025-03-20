#!/bin/bash

INTERVAL = 1

LOG_FILE ="/tmp/cpu_usage.log"

while true; do

CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | awk -F '%' '{print $1}')

echo "CPU Usage: $CPU_USAGE%"

if [ -n "$LOG_FILE" ]; then
echo "$(date '+%Y-%m-%d %H:%M:%S'): $CPU_USAGE%" >> "$LOG_FILE"
fi

sleep $INTERNAL
done