#!/bin/bash

# Color variables
RED='\033[0;31m'
GREEN='\033[0;32m'
BRIGHT='\033[1m'
NC='\033[0m' # No Color

if [[ "$OSTYPE" == "darwin"* ]]; then

    yes=("yes" "Yes" "YES")
    no=("no" "No" "No")

    echo -e "${RED}${BRIGHT}!Are you sure you want to remove your Packages (YES/NO)!: ${NC}"

    read -p ">>> " YES_NO

    if [[ "${yes[*]}" == *"$YES_NO"* ]]; then
        # Check if Homebrew is installed
        if command -v brew >/dev/null 2>&1; then
            # Packages to check for installation
            Packages=(
                "wget"
                "hydra"
                "nmap"
                "mysql"
                "figlet"
                "zenity"
            )

            # PIP packages that will be uninstalled if they are installed
            pipPackages=(
                "asyncio"
                "pyfiglet"
            )

            # Function to check and uninstall a package
            check_package() {
                package_name="$1"
                if brew list --formula | grep -q "$package_name"; then
                    echo "$package_name is installed."
                    brew uninstall "$package_name"
                else
                    echo -e "${RED}$package_name${NC} is not installed."
                fi
            }

            # Check packages
            for package in "${Packages[@]}"
            do
                check_package "${package}"
            done

            # Uninstall PIP packages
            for pipPackage in "${pipPackages[@]}"
            do
                if pip3 show "${pipPackage}" >/dev/null 2>&1; then
                    pip3 uninstall "${pipPackage}" -y

                    # Check the exit status of the last command
                    if [ $? -ne 0 ]; then
                        echo -e "Error occurred during uninstallation of \"${pipPackage}\""
                        exit 1
                    else
                        echo -e "${pipPackage}: uninstalled ${GREEN}successfully${NC}"
                    fi
                else
                    echo -e "${RED}${pipPackage}${NC}: is not installed"
                fi
            done

            # Check the exit status of the last command
            if [ $? -ne 0 ]; then
                echo -e "The packages that are removed are: ${GREEN}"
                for package in "${Packages[@]}"
                do
                    echo -e "$package"
                done
                echo -e "________PIP Packages________"
                for pipPackage in "${pipPackages[@]}"
                do
                    echo -e "${pipPackage}"
                done
                echo -e "________ERROR________"
                echo -e "${RED}Error occurred during pip uninstallation${NC}"
            else
                echo -e "The packages that are removed are: ${GREEN}"
                for package in "${Packages[@]}"
                do
                    echo -e "${package}"
                done
                echo -e "________PIP Packages________"
                for pipPackage in "${pipPackages[@]}"
                do
                    echo -e "${pipPackage} is removed"
                done
            fi

        else
            echo -e "${RED}ERROR: Homebrew is not installed.${NC}"
        fi

    elif [[ "${no[*]}" == *"$YES_NO"* ]]; then
        echo -e "Ok, I will not remove the packages."
        exit 1
    fi
    
else
    echo -e "${RED}${BRIGHT}This script can only be run on macOS${NC}"
fi