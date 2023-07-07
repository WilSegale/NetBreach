#!/bin/bash

# Color variables
RED='\033[0;31m'
GREEN='\033[0;32m'
BRIGHT='\033[1m'
NC='\033[0m' # No Color
if [[ "$OSTYPE" == "linux"* ]]; then   
    if ping -q -c 1 -W 1 google.com >/dev/null; then # checks if the user is connected to the internet
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
                sudo apt-get install $package_name
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
        echo -e "${RED}ERROR: NOT CONNECTED TO THE INTERNET${NC}"
    fi

else
    echo "Wrong OS please use the correct OS." #if the users is not useing the right OS it says "You are useing the wrong OS"
fi