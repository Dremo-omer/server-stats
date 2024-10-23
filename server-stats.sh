#!/bin/bash

# script to get basic server stats, not too complicated
# author: Ömer
# this script provides cpu, memory, and disk usage stats along with top processes

print_divider() {
    echo "-----------------------------"
}

get_cpu_usage() {
    echo "checking cpu usage..."
    cpu_idle=$(top -bn1 | grep "Cpu(s)" | awk '{print $8}')
    cpu_usage=$(echo "scale=2; 100 - $cpu_idle" | bc)
    echo "cpu usage: $cpu_usage%"
}

get_memory_usage() {
    echo ""
    echo "checking memory usage..."
    total_mem=$(free -m | awk '/Mem:/ {print $2}')
    used_mem=$(free -m | awk '/Mem:/ {print $3}')
    free_mem=$(free -m | awk '/Mem:/ {print $4}')
    mem_usage_pct=$(echo "scale=2; $used_mem/$total_mem*100" | bc)

    echo "total memory: $total_mem mb"
    echo "used memory: $used_mem mb"
    echo "free memory: $free_mem mb"
    echo "memory usage: $mem_usage_pct%"
}

get_disk_usage() {
    echo ""
    echo "checking disk usage..."
    disk_info=$(df -h --total | grep 'total')
    total_disk=$(echo $disk_info | awk '{print $2}')
    used_disk=$(echo $disk_info | awk '{print $3}')
    available_disk=$(echo $disk_info | awk '{print $4}')
    disk_usage_pct=$(echo $disk_info | awk '{print $5}')

    echo "total disk space: $total_disk"
    echo "used disk space: $used_disk"
    echo "available disk space: $available_disk"
    echo "disk usage: $disk_usage_pct"
}

get_top_cpu_processes() {
    echo ""
    echo "top 5 processes using the most cpu:"
    ps -eo pid,ppid,cmd,%cpu --sort=-%cpu | head -n 6 | awk '{printf "pid: %s, cpu%%: %s, command: %s
", $1, $4, $3}'
}

get_top_mem_processes() {
    echo ""
    echo "top 5 processes using the most memory:"
    ps -eo pid,ppid,cmd,%mem --sort=-%mem | head -n 6 | awk '{printf "pid: %s, memory%%: %s, command: %s
", $1, $4, $3}'
}

echo ""
echo "starting server performance check..."
print_divider

get_cpu_usage
get_memory_usage
get_disk_usage
get_top_cpu_processes
get_top_mem_processes

echo ""
print_divider
echo "performance check complete."
echo ""