# Server Monitoring Tool

A lightweight bash script for monitoring server performance metrics.

## Features
- Real-time CPU usage monitoring
- Memory usage tracking
- Automated log rotation
- Configurable monitoring intervals
- Signal handling for clean exit

## Prerequisites
- Linux/Unix-based system
- Bash shell
- `top` command
- `free` command

## Installation
1. Clone the repository:
```bash
git clone https://github.com/MeFerdi/DevOps-Practice.git

cd server-performance
```
Make the script executable:
## Usage
Run the script:
```bash
chmod +x server-stats.sh
```
To run in background:
```bash
nohup ./server-stats.sh &
```
## Configuration
Edit these variables in server-stats.sh:
```sh
INTERVAL: Monitoring frequency (seconds)
MAX_LOG_SIZE: Maximum log file size (bytes)
ROTATE_COUNT: Number of log backups to keep
LOG_FILE: Log file location
```

### Log Management
Logs are automatically rotated when they reach MAX_LOG_SIZE. Default location: cpu_usage.log

Example Output
```sh
[2024-02-20 10:15:30]
CPU Usage: 25.5%
Memory Usage: 60.2%
-------------------
```
## Stopping the Monitor
Press Ctrl+C for clean exit

