#!/bin/bash

INTERVAL=5
MAX_LOG_SIZE=10485760
ROTATE_COUNT=5
LOG_FILE="/tmp/cpu_usage.log"


# Signal Handling

trap cleanup SIGINT SIGTERM
cleanup(){
    echo "Stopping monitoring..."
    exit 0
}

# Log rotation function
check_log_rotation(){
    if [ -f "$LOG_FILE" ]; then
    current_size=$(stat -f%z "$LOG_FILE" 2>/dev/null || stat -c%s "$LOG_FILE")
    if [ "$current_size" -gt "$MAX_LOG_SIZE" ]; then
    for i in $(seq $((ROTATE_COUNT-1)) -1 0); do
    if [-f "${LOG_FILE}.$i"]; then
    mv "${LOG_FILE}.$i" "${LOG_FILE}.$((i+1))"
    fi
done
mv "$LOG_FILE" "${LOG_FILE}.0"
touch "$LOG_FILE"
fi
fi
}
monitor_resources(){
    while true; do

CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9]*\)%* id.*/\1/" | awk '{print 100 - $1}')

# Get memory usage

MEM_INFO=$(free | grep Mem)
TOTAL_MEM=$(echo "$MEM_INFO" | awk '{print $2}')
USED_MEM=$(echo "$MEM_INFO" | awk '{print $3}')
MEM_USAGE=$(awk "BEGIN {printf \"%.2f\", $USED_MEM/$TOTAL_MEM*100}")

 TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
        
        # Log data
        if [ -n "$LOG_FILE" ]; then
            echo "$TIMESTAMP - CPU: ${CPU_USAGE}%, MEM: ${MEM_USAGE}%" >> "$LOG_FILE"
            check_log_rotation
        fi
        
        # Display current stats
        echo "[$TIMESTAMP]"
        echo "CPU Usage: ${CPU_USAGE}%"
        echo "Memory Usage: ${MEM_USAGE}%"
        echo "-------------------"
        
        sleep "$INTERVAL"
    done
}

# Check if log directory exists
LOG_DIR=$(dirname "$LOG_FILE")
if [ ! -d "$LOG_DIR" ]; then
    mkdir -p "$LOG_DIR" || { echo "Error: Cannot create log directory"; exit 1; }
fi

# Start monitoring
echo "Starting server monitoring (Ctrl+C to stop)..."
monitor_resources