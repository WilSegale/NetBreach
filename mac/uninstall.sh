#!/bin/bash
source DontEdit.sh

# Color variables

#checks if the user is ROOT and if they are it says you shouldnt be root to run this scirpt
if [ "$(id -u)" -eq 0 ]; then
    #puts the ERROR message into line art
    echo -e "\e[91m$(figlet ERROR)\e[0m"

    # gives the user something to read so they understand why they got the error
    echo "+++++++++++++++++++++++++++++++++++++++++"
    echo "+   Don't use sudo for this script.     +"
    echo "+   Because it can damage your computer +"
    echo "+++++++++++++++++++++++++++++++++++++++++"
    echo ""
    exit 1
else
    if [[ "${OSTYPE}" == "linux-gnu"* ]]; then

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
                    echo "$package_name is installed."
                    sudo apt-get remove -y "$package_name"
                else
                    echo -e "\e[91m$package_name\e[0m is not installed."
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
                        echo -e "${pipPackage}: uninstalled \e[92msuccessfully\e[0m"
                    fi
                else
                    echo -e "\e[91m${pipPackage}\e[0m: is not installed"
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
                    echo -e "\e[91m${pipPackage}\e[0m"
                done
                echo -e "________ERROR________"
                echo -e "\e[91mError occurred during pip uninstallation\e[0m"
            else
                for package in "${Packages[@]}"
                do
                    echo -e "${package}: \e[92mis removed\e[0m"
                done
                echo -e "________PIP Packages________"
                for pipPackage in "${pipPackages[@]}"
                do
                    echo -e "${pipPackage}: \e[92mis removed\e[0m"
                done
            fi

        elif [[ "${no[*]}" == *"$YES_NO"* ]]; then
            echo -e "\e[91m\e[1m[-]\e[0m Ok, I will not remove the packages."
            exit 1
        fi
    else
        echo -e "\e[91m\e[1mThis script can only be run on Linux\e[0m"
    fi
fi
