#!/bin/bash

print_header() {
    echo -e "\n=== $1 ===\n"
}

print_separator() {
    echo "----------------------------------------"
}

print_header "SYSTEM INFORMATION"
echo "OS Version: $(cat /etc/os-release | grep PRETTY_NAME | cut -d'"' -f2)"
echo "Kernel Version: $(uname -r)"
echo "Uptime: $(uptime -p)"
echo "Load Average: $(uptime | awk -F'load average:' '{print $2}')"

print_header "CPU USAGE"
top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}' | awk '{print "Total CPU Usage: " $1 "%"}'

print_header "MEMORY USAGE"
free -h | grep -v + > /tmp/memory_usage
echo "Total Memory: $(awk '/^Mem:/ {print $2}' /tmp/memory_usage)"
echo "Used Memory: $(awk '/^Mem:/ {print $3}' /tmp/memory_usage)"
echo "Free Memory: $(awk '/^Mem:/ {print $4}' /tmp/memory_usage)"
echo "Memory Usage Percentage: $(free | grep Mem | awk '{print int($3/$2 * 100)}')%"

print_header "DISK USAGE"
df -h | grep '^/dev/' | awk '{print $1 " - " $2 " total, " $3 " used, " $4 " free (" $5 " used)"}'

print_header "TOP 5 CPU-CONSUMING PROCESSES"
ps aux | sort -nr -k 3 | head -5 | awk '{print $3 "% CPU - " $11}'

print_header "TOP 5 MEMORY-CONSUMING PROCESSES"
ps aux | sort -nr -k 4 | head -5 | awk '{print $4 "% MEM - " $11}'

print_header "ADDITIONAL INFORMATION"
echo "Currently Logged In Users:"
who

echo -e "\nFailed Login Attempts (last 24h):"
grep "Failed password" /var/log/auth.log | grep "$(date -d '24 hours ago' +'%b %d')" | wc -l

print_header "NETWORK CONNECTIONS"
echo "Active Network Connections: $(netstat -tun | grep ESTABLISHED | wc -l)"
echo "Listening Ports:"
netstat -tuln | grep LISTEN | awk '{print $4}' | sort

print_separator