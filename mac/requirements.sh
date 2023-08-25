#!/bin/bash

# Color variables
RED='\033[0;31m'
GREEN='\033[0;32m'
BRIGHT='\033[1m'
NC='\033[0m' # No Color

if [ "$1" = "--help" ]; then
    echo "This script will install the packages for it to work properly"
fi
#sees if the OS is mac os
if [[ "$OSTYPE" == "Darwin"* ]]; then 
    if ping -c 1 google.com >/dev/null 2>&1; then
        # Packages to install
        Packages=(
            "wget"
            "hydra"
            "nmap"
            "mysql"
            "figlet"
        )
        
        pipPackages=(
            "tqdm"
            "asyncio"
            "colorama"
        )
        
        # Install package
        install_Brew_package() {
            package_name="$1"
            if ! command -v "$package_name" >/dev/null 2>&1; then
                echo "$package_name is not installed. Installing..."
                # Replace the following command with the appropriate package manager for your Linux distribution
                brew install "$package_name"
            else
                echo -e "$package_name is already ${GREEN}installed.${NC}"
            fi
        }

        # Install package
        install_pip_package() {
            package_name="$1"
            if ! python3 -m pip show "$package_name" >/dev/null 2>&1; then
                echo "$package_name is not installed. Installing..."
                pip3 install "$package_name"
            else
                echo -e "$package_name is already ${GREEN}installed.${NC}"
            fi
        }
        
        # Install BREW packages
        for package in "${Packages[@]}"; do
            install_Brew_package "${package}"
        done

        # Install PIP packages
        for PIP in "${pipPackages[@]}"; do
            install_pip_package "${PIP}"
        done
    else
        echo -e "${RED}ERROR:${NC} NOT CONNECTED TO THE INTERNET"
    fi

else
    echo "Wrong OS please use the correct OS." #if the users is not useing the right OS it says "You are useing the wrong OS"
fi