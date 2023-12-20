#!/bin/bash
source DontEdit.sh
# Color variables

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


requiredments(){
    #checks if the user is ROOT and if they are it says you shouldnt be root to run this scirpt
    if [ "$(id -u)" -eq $root ]; then
        #puts the ERROR message into line art
        echo -e "${RED}$(figlet ERROR)${NC}"
        
        # gives the user something to read so they understand why they got the error
        echo "+++++++++++++++++++++++++++++++++++++++++"
        echo "+   Don't use sudo for this script.     +" 
        echo "+   Because it can damage your computer +"
        echo "+++++++++++++++++++++++++++++++++++++++++"
        echo ""
        exit 1
    else
        # helps the users to understand what the program does
        if [[ "$1" = "--help" || "$1" = "-h" ]]; then
            echo "This script will install the packages for it to work properly"
            echo 
        else
            # Check if the OS is macOS
            if [[ "$OSTYPE" == "darwin"* ]]; then 
                if ping -c 1 google.com >/dev/null 2>&1; then
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
                successful_MESSAGE="${GREEN}[+]${NC} All packages are installed successfully"
                echo -e "${successful_MESSAGE}"
            else
                echo -e "${RED}${BRIGHT}ERROR:${NC} NOT CONNECTED TO THE INTERNET"
            fi

        # Check if the OS is Linux
        else
            echo -e "${RED}${BRIGHT}[-]${NC} Wrong OS please use the correct OS." #if the user is not using the right OS, it says "You are using the wrong OS"
        fi
    fi
fi
}
requiredments