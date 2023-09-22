#!/bin/bash

# Color variables
RED='\033[0;31m'
GREEN='\033[0;32m'
BRIGHT='\033[1m'
NC='\033[0m' # No Color

if [ "$(id -u)" -eq 0 ]; then
    #notification message for the user to also if the local host has been compromised at all
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
        if [ -f /etc/os-release ]; then
            source /etc/os-release
            if [ "$OSTYPE" = "linux"* ]; then
                if ping -c 1 google.com >/dev/null 2>&1; then
                    # Packages to install
                    Packages=(
                        "wget"
                        "hydra"
                        "nmap"
                        "mysql-server"
                        "figlet"
                        "zenity"
                    )

                    pipPackages=(
                        "asyncio"
                        "colorama"
                        "pyfiglet"
                    )

                    # Install package
                    install_Package() {
                        package_name="$1"
                        if ! dpkg -l | grep -q "$package_name"; then
                            echo "$package_name is not installed. Installing..."
                            sudo apt-get install "$package_name" -y
                        else
                            echo -e "$package_name is already ${GREEN}installed.${NC}"
                        fi
                    }

                    # Install PIP package
                    install_pip_package() {
                        package_name="$1"
                        if ! python3 -m pip show "$package_name" >/dev/null 2>&1; then
                            echo "$package_name is not installed. Installing..."
                            pip3 install "$package_name"
                        else
                            echo -e "$package_name is already ${GREEN}installed.${NC}"
                        fi
                    }

                    echo
                    echo "_________APT PACKAGES________"

                    # Install packages
                    for package in "${Packages[@]}"; do
                        install_Package "$package"
                    done

                    echo
                    echo "_________PIP PACKAGES________"

                    # Install PIP packages
                    for PIP in "${pipPackages[@]}"; do
                        install_pip_package "$PIP"
                    done

                    echo

                    # Update PIP
                    echo "_________PIP UPDATES________"
                    sudo python3 -m pip install --upgrade pip

                    echo
                    title="Packages"
                    ERROR_MESSAGE="All packages are installed successfully"
                    notify-send "$title" "$ERROR_MESSAGE" # Use notify-send for Linux desktop notifications
                    echo -e "${GREEN}All packages installed.${NC}"
                else
                    title="ERROR"
                    ERROR_MESSAGE="NOT CONNECTED TO THE INTERNET"
                    notify-send "${title}" "${ERROR_MESSAGE}" # Use notify-send for Linux desktop notifications
                    echo -e "${RED}ERROR${NC}: NOT CONNECTED TO THE INTERNET"
                fi
            else
                echo "Unsupported Linux distribution."
            fi
        else
            echo "This script is designed for Linux and won't work on macOS."
        fi
    fi
fi
