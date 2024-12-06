# server-performance-stats
Goal of this project is to write a script to analyse server performance stats.


## Requirements
You are required to write a script server-stats.sh that can analyse basic server performance stats. You should be able to run the script on any Linux server and it should give you the following stats:

Total CPU usage
Total memory usage (Free vs Used including percentage)
Total disk usage (Free vs Used including percentage)
Top 5 processes by CPU usage
Top 5 processes by memory usage
Stretch goal: Feel free to optionally add more stats such as os version, uptime, load average, logged in users, failed login attempts etc.


## How to run ?

```bash
docker build -t server-stats .
docker run --rm server-stats
````

or interactively

```bash
docker run -it --rm server-stats /bin/bash
./server-stats.sh # Run this line multiple times if needed
```