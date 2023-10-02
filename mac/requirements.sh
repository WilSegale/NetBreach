#!/bin/bash

# Color variables
RED='\033[0;31m'
GREEN='\033[0;32m'
BRIGHT='\033[1m'
NC='\033[0m' # No Color

if [ "$(id -u)" -eq 0 ]; then
    #notification message for the user to also if the local host has been copermised at all
    title="ERROR"
    ERROR_MESSAGE="Don't use sudo for this script. Because it can damage your computer"
    osascript -e "display notification \"$ERROR_MESSAGE\" with title \"$title\""
    
    #puts the ERROR message into line art
    echo -e "${RED}$(figlet ERROR)${NC}"
    
    # gives the user something to read so they understand why they got the error
    echo "Don't use sudo for this script." 
    echo "Because it can damage your computer"
    exit 1
else
    if [[ "$1" = "--help" || "$1" = "-h" ]]; then
        echo "This script will install the packages for it to work properly"
    
    else
        # Check if the OS is macOS
        if [[ "$OSTYPE" == "darwin"* ]]; then 
            if ping -c 1 google.com >/dev/null 2>&1; then
                # Packages to install
                Packages=(
                    "wget"
                    "hydra"
                    "nmap"
                    "mysql"
                    "figlet"
                    "zenity"
                )
                
                pipPackages=(
                    "asyncio"
                    "colorama"
                    "pyfiglet"
                )
                
                # Install package
                install_Brew_package() {
                    package_name="$1"
                    if ! command -v "${package_name}" >/dev/null 2>&1; then
                        echo "${package_name} is not installed. Installing..."
                        # Replace the following command with the appropriate package manager for your Linux distribution
                        brew install "${package_name}"
                    else
                        echo -e "${package_name} is already ${GREEN}installed.${NC}"
                    fi
                }

                # Install package
                install_pip_package() {
                    package_name="$1"
                    if ! python3 -m pip show "${package_name}" >/dev/null 2>&1; then
                        echo "${package_name} is not installed. Installing..."
                        pip3 install "${package_name}"
                    else
                        echo -e "${package_name} is already ${GREEN}installed.${NC}"
                    fi
                }
                echo
                echo "_________BREW PACKAGES________"

                # Install BREW packages
                for package in "${Packages[@]}"; do
                    install_Brew_package "${package}"
                done
                
                echo
                echo "_________PIP PACKAGES________"
                # Install PIP packages
                for PIP in "${pipPackages[@]}"; do
                    install_pip_package "${PIP}"
                done

                echo
                
                # updates PIP
                echo "_________PIP UPDATES________"
                /Library/Developer/CommandLineTools/usr/bin/python3 -m pip install --upgrade pip

                echo
                successful_MESSAGE="[+]All packages are installed successfully"
                echo -e "${successful_MESSAGE}"
            else
                title="ERROR"
                ERROR_MESSAGE="NOT CONNECTED TO THE INTERNET"
                osascript -e "display notification \"$ERROR_MESSAGE\" with title \"$title\""
                echo -e "${RED}ERROR:${NC} NOT CONNECTED TO THE INTERNET"
            fi

        # Check if the OS is Linux
        else
            echo "Wrong OS please use the correct OS." #if the user is not using the right OS, it says "You are using the wrong OS"
        fi
    fi
fi