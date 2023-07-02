#!/bin/bash

# Color variables
RED='\033[0;31m'
GREEN='\033[0;32m'
BRIGHT='\033[1m'
NC='\033[0m' # No Color

yes=("yes" "Yes" "YES")


if ping -q -c 1 -W 1 google.com >/dev/null; then # checks if the user is connected to the internet
    # Packages to check for installation
    Packages=(
        "wget"
        "hydra"
        "nmap"
        "mysql"
        "figlet"
    )

    # PIP packages that will be installed if they are not already installed
    pipPackages=(
        "tqdm"
        "asyncio"
        "colorama"
    )

    # Check package installation
    check_package() {
        package_name="$1"
        if command -v "$package_name" >/dev/null 2>&1; then
            echo "$package_name is already installed."
        else
            echo -e "${RED}$package_name${NC} is not installed. Installing..."
            brew install "$package_name"
        fi
    }

    # Check packages
    for package in "${Packages[@]}"
    do
        check_package "$package"
    done

    # Install PIP packages
    for pipPackage in "${pipPackages[@]}"
    do
        if pip3 show "$pipPackage" >/dev/null 2>&1; then
            echo -e "${pipPackage} is already installed."
        else
            echo -e "${RED}${pipPackage}${NC} is not installed. Installing..."
            pip3 install "$pipPackage"
        fi
    done

    # Check the exit status of the last command
    if [ $? -ne 0 ]; then
        echo -e "Error occurred during package installation."
        exit 1
    else
        echo -e "Packages installed ${GREEN}successfully${NC}"
        echo -e "The packages that are installed are: ${GREEN}"
        for package in "${Packages[@]}"
            do
                echo -e "$package"
        done
        echo -e "________PIP Packages________"
        for pipPackage in "${pipPackages[@]}"
            do
                echo -e "$pipPackage"
        done
    fi

else
    echo -e "${RED}ERROR: NOT CONNECTED TO THE INTERNET${NC}"
fi
