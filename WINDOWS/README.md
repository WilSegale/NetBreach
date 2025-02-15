# NetBreachX - Network Security Tool

NetBreachX is a network security tool that provides functionalities for network scanning, SSH session management, and weak password checking. It is designed to help with security auditing by identifying active hosts on a network, managing SSH sessions, and performing parallelized SSH login attempts to check for weak passwords.
# Home Page
- [Home README.md](../)
## Features
- **Network Scan**: Scans a given subnet for active hosts.
- **SSH Session Management**: Connects and disconnects SSH sessions.
- **Weak Password Checking**: Checks for weak passwords using a given list of potential passwords in parallel.
- **Terminate SSH Session**: Terminates SSH sessions on the local system.

## Requirements
- Python 3.6+
- `paramiko` for SSH connections
- `aiohttp` for async network scanning

## Installation
1. Clone this repository:
   ```bash
   git clone https://github.com/wilsegale/NetBreachX.git

