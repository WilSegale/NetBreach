#!/bin/bash

# Color variables
RED='\033[0;31m'
GREEN='\033[0;32m'
BRIGHT='\033[1m'
NC='\033[0m' # No Color

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
    install_package() {
        package_name="$1"
        if ! command -v "$package_name" >/dev/null 2>&1; then
            echo "$package_name is not installed. Installing..."
            # Replace the following command with the appropriate package manager for your Linux distribution
            brew install "$package_name"
        else
            echo -e "$package_name is already ${GREEN}installed.${NC}"
        fi
    }
    
    for pipPackage in "${pipPackages[@]}"; do
        if pip3 show "$pipPackage" >/dev/null 2>&1; then
            echo -e "Uninstalling $pipPackage..."
            pip3 uninstall -y "$pipPackage"
            if [ $? -eq 0 ]; then
                echo -e "$pipPackage: uninstalled successfully"
            else
                echo -e "Error occurred during uninstallation of $pipPackage"
                exit 1
            fi
        fi
        echo -e "Installing $pipPackage..."
        pip3 install "$pipPackage"
        if [ $? -eq 0 ]; then
            echo -e "$pipPackage: installed successfully"
        else
            echo -e "Error occurred during installation of $pipPackage"
            exit 1
        fi
    done
    
    # Install packages
    for package in "${Packages[@]}"; do
        install_package "$package"
    done
else
    echo -e "${RED}ERROR: NOT CONNECTED TO THE INTERNET${NC}"
fi
