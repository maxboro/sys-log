## Description
System resource logging for Linux.

Measurements performed each second.
Metrics tracked:
- CPU utilization
- RAM used

## Example
```terminal
Sat Jan 18 13:23:45 2025 | CPU Utilization: 1.7%, RAM Utilization: 533 MB
Sat Jan 18 13:23:46 2025 | CPU Utilization: 1.6%, RAM Utilization: 533 MB
Sat Jan 18 13:23:48 2025 | CPU Utilization: 7.7%, RAM Utilization: 532 MB
Sat Jan 18 13:23:49 2025 | CPU Utilization: 3.3%, RAM Utilization: 532 MB
Sat Jan 18 13:23:50 2025 | CPU Utilization: 3.1%, RAM Utilization: 532 MB
Sat Jan 18 13:23:51 2025 | CPU Utilization: 3.2%, RAM Utilization: 532 MB
Sat Jan 18 13:23:52 2025 | CPU Utilization: 3.2%, RAM Utilization: 531 MB
Sat Jan 18 13:23:54 2025 | CPU Utilization: 0%, RAM Utilization: 531 MB
Sat Jan 18 13:23:55 2025 | CPU Utilization: 3.3%, RAM Utilization: 531 MB
Sat Jan 18 13:23:56 2025 | CPU Utilization: 4.7%, RAM Utilization: 531 MB
Sat Jan 18 13:23:57 2025 | CPU Utilization: 0%, RAM Utilization: 530 MB
Sat Jan 18 13:23:58 2025 | CPU Utilization: 4.8%, RAM Utilization: 530 MB
```

## Dependencies

This project requires the following dependencies:

- **Lua 5.x** (tested with Lua 5.4.7)
- **LuaSocket**: A Lua library for networking and utility functions

### Installation Instructions

#### Install Lua and LuaRocks
On Ubuntu/Debian:
```bash
sudo apt update
sudo apt install lua5.3 luarocks
```