#!/bin/bash

#holds the packages and color vars for the program to work
source DontEdit.sh

if [[ "${OSTYPE}" == "linux-gnu"* ]]; then

    echo -e "${BRIGHT}${RED}Are you sure you want to remove your Packages (YES/NO)!: ${NC}"

    read -p ">>> " YES_NO

    if [[ "${yes[*]}" == *"${YES_NO}"* ]]; then

        # Function to check and uninstall a package
        check_package() {
            package_name="$1"
            if command -v "${package_name}" >/dev/null 2>&1; then
                echo "${package_name} is installed."
                sudo apt-get remove -y "${package_name}"
            else
                echo -e "${RED}${package_name}${NC} is not installed."
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
                pip3 uninstall "${pipPackage}" --break-system-packages -y

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
                echo -e "${GREEN}${pipPackage}${NC}"
            done
            echo -e "________ERROR________"
            echo -e "${RED}Error occurred during pip uninstallation${NC}"
        else
            for package in "${Packages[@]}"
            do
                echo -e "${package}: \e[92mis removed\e[0m"
            done
            echo -e "________PIP Packages________"
            for pipPackage in "${pipPackages[@]}"
            do
                echo -e "${pipPackage}: ${GREEN}is removed${NC}"
            done
        fi

    elif [[ "${no[*]}" == *"${YES_NO}"* ]]; then
        echo -e "${RED}[-]${NC} Ok, I will not remove the packages."
        exit 1
    fi
else
    echo -e "${RED}This script can only be run on Linux${NC}"
fi
