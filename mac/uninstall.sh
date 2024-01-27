#!/bin/bash
source DontEdit.sh

# Color variables

# Checks if the user is ROOT and if they are, it prompts them not to use sudo
if [ "$(id -u)" -eq 0 ]; then
    # Puts the ERROR message into line art
    echo -e "\e[91m$(figlet ERROR)\e[0m"

    # Gives the user something to read so they understand why they got the error
    echo "+++++++++++++++++++++++++++++++++++++++++"
    echo "+   Don't use sudo for this script.     +"
    echo "+   Because it can damage your computer +"
    echo "+++++++++++++++++++++++++++++++++++++++++"
    echo ""
    exit 1
else
    if [[ "${OSTYPE}" == "darwin"* ]]; then

        echo -e "\e[91m\e[1m!Are you sure you want to remove your Packages (YES/NO)!: \e[0m"

        read -p ">>> " YES_NO

        if [[ "${yes[*]}" == *"$YES_NO"* ]]; then
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
                if command -v "${package_name}" >/dev/null 2>&1; then
                    echo "${package_name} is installed."
                    brew uninstall "${package_name}"
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
                if python3 -m pip show "${pipPackage}" >/dev/null 2>&1; then
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
                for package in "${Packages[@]}"
                do
                    echo -e "The packages that are removed are: ${package}"
                done
                echo -e "________PIP Packages________"
                for pipPackage in "${pipPackages[@]}"
                do
                    echo -e "${RED}${pipPackage}${NC}"
                done
                echo -e "________ERROR________"
                echo -e "${RED}Error occurred during pip uninstallation${NC}"
            else
                for package in "${Packages[@]}"
                do
                    echo -e "${package}: ${RED}is removed${NC}"
                done
                echo -e "________PIP Packages________"
                for pipPackage in "${pipPackages[@]}"
                do
                    echo -e "${pipPackage}: ${RED}is removed${NC}"
                done
            fi

        elif [[ "${no[*]}" == *"$YES_NO"* ]]; then
            echo -e "${RED}${BRIGHT}Ok, I will not remove the packages.${NC}"
            exit 1
        fi
    else
        echo -e "${RED}This script can only be run on macOS${NC}"
    fi
fi
