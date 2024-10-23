# Server Stats Script

This script is made to give basic server performance stats, like cpu usage, memory usage, and disk usage. It should work on any Linux server and helps to get a quick idea of the server performance.

## Features

- Total cpu usage
- Total memory usage (used vs free, with percent)
- Total disk usage (used vs free, with percent)
- Top 5 processes using most cpu
- Top 5 processes using most memory

## Usage

1. Make the script executable:

   ```bash
   chmod +x server-stats.sh
   ```

2. Run the script:

   ```bash
   ./server-stats.sh
   ```

## Requirements

- Linux server
- Bash shell
- You need these commands: `top`, `free`, `df`, `ps`, `awk`, `bc`

## Author

Ömer