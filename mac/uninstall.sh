
#!/bin/bash

#imports the dont edit file to see what os the program is using
source DontEdit.sh

# Color variables for formatting output
RED='\033[0;31m'       # Red color
GREEN='\033[0;32m'     # Green color
BRIGHT='\033[1m'       # Bright text
NC='\033[0m'           # No color

# Check if the script is run as root (sudo)
if [ "$(id -u)" -eq 0 ]; then
    figlet "ERROR"  # Display an ASCII art error message
    echo "Don't use sudo for this script." 
    echo "Because it can damage your computer."
    exit 1  # Exit with an error code
else
    # Check if the operating system is macOS
    if [[ "$OSTYPE" == "${MAC}"* ]]; then
        
        # Prompt the user to confirm if they want to remove packages
        echo -e "${RED}${BRIGHT}!Are you sure you want to remove your Packages (YES/NO)!:${NC}"
        read -p ">>> " YES_NO

        if [[ "${yes[*]}" == *"$YES_NO"* ]]; then
            # Check if the user is connected to the internet
            if ping -q -c 1 -W 1 google.com >/dev/null; then 
                # List of Brew packages that will be uninstalled if installed
                Packages=(
                    "wget"
                    "hydra"
                    "nmap"
                    "mysql"
                    "figlet"
                    "zenity"
                )

                # List of PIP packages that will be uninstalled if installed
                pipPackages=(
                    "asyncio"
                    "colorama"
                )

                # Function to check and uninstall a package
                check_package() {
                    package_name="$1"
                    if command -v "$package_name" >/dev/null 2>&1; then
                        echo "$package_name is installed."
                        brew uninstall "$package_name"
                    else
                        echo -e "${RED}$package_name${NC} is not installed."
                    fi
                }

                # Check and uninstall Brew packages
                for package in "${Packages[@]}"
                do
                    check_package "$package"
                done

                # Uninstall PIP packages
                for pipPackage in "${pipPackages[@]}"
                do
                    if pip3 show "$pipPackage" >/dev/null 2>&1; then
                        pip3 uninstall "$pipPackage" -y
                        # Check the exit status of the last command
                        if [ $? -ne 0 ]; then
                            echo -e "Error occurred during uninstallation of \"$pipPackage\""
                            exit 1
                        else
                            echo -e "${pipPackage}: uninstalled ${GREEN}successfully${NC}"
                        fi
                    else
                        echo -e "${RED}${pipPackage}${NC}: is not installed"
                    fi
                done

                # Uninstall PIP itself
                pip3 uninstall -y pip

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
                    echo -e "pip: uninstalled ${GREEN}successfully${NC}"
                    echo -e "The packages that are removed are: ${GREEN}"
                    for package in "${Packages[@]}"
                    do
                        echo -e "${package}"
                    done
                    echo -e "________PIP Packages________"
                    for pipPackage in "${pipPackages[@]}"
                    do
                        echo -e "${pipPackage}"
                    done
                fi
            else
                echo -e "${RED}ERROR: NOT CONNECTED TO THE INTERNET${NC}"
            fi
        elif [[ "${yes[*]}" == *"$YES_NO"* ]]; then
            echo -e "[+] Ok, I will remove the packages."
        elif [[ "${no[*]}" == *"$YES_NO"* ]];then
            echo -e "[-] Ok, I will not remove the packages."
        else
            echo -e "${RED}Please enter a valid option${NC}"
        fi
    else
        echo -e "${RED}${BRIGHT}This script can only be run on Mac OS${NC}"
    fi
fi