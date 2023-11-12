#!/bin/bash

#connects to the dont edit file to see what os they are using
source DontEdit.sh

# Color variables
RED='\033[0;31m'
GREEN='\033[0;32m'
BRIGHT='\033[1m'
NC='\033[0m' # No Color

# List of packages to install
Packages=(
    "wget"
    "hydra"
    "nmap"
    "mysql-server"
    "figlet"
    "zenity"
    "xtightvncviewer"
)

# List of Python packages to install
pipPackages=(
    "asyncio"
    "colorama"
    "pyfiglet"
)

if [ "$(id -u)" -eq 0 ]; then
    # Notification message for the user to also if the local host has been compromised at all
    title="ERROR"
    ERROR_MESSAGE="Don't use sudo for this script. Because it can damage your computer"
    notify-send "${title}" "${ERROR_MESSAGE}" # Use notify-send for Linux desktop notifications
    echo -e "${RED}ERROR${NC}"
    echo "Don't use sudo for this script."
    echo "Because it can damage your computer"
    exit 1
else
    if [[ "$1" == "--help" || "$1" == "-h" ]]; then
        echo "This script will install the packages for it to work properly"
    else
        # Check if the OS is Linux
        if [[ "$OSTYPE" == "${OS}"* ]]; then
            if ping -c 1 google.com >/dev/null 2>&1; then
                echo
                echo "_________APT PACKAGES________"

                # Install packages
                for package in "${Packages[@]}"; do
                    echo "Installing $package..."
                    sudo apt-get install "$package" -y
                done

                echo
                echo "_________PIP PACKAGES________"

                # Install PIP packages
                for PIP in "${pipPackages[@]}"; do
                    echo "Installing ${PIP}..."
                    pip3 install "${PIP}"
                done

                echo

                # Update PIP
                echo "_________PIP UPDATES________"
                python3 -m pip install --upgrade pip

                echo
                title="Packages"
                ERROR_MESSAGE="All packages are installed successfully"
                notify-send "${title}" "${ERROR_MESSAGE}" # Use notify-send for Linux desktop notifications
                echo -e "${GREEN}All packages installed.${NC}"
            else
                title="ERROR"
                ERROR_MESSAGE="NOT CONNECTED TO THE INTERNET"
                notify-send "${title}" "${ERROR_MESSAGE}" # Use notify-send for Linux desktop notifications
                echo -e "${RED}ERROR${NC}: NOT CONNECTED TO THE INTERNET"
            fi
        else
            echo -e "${RED}[-]${NC} This script is designed for Linux and won't work on macOS."
        fi
    fi
fi
