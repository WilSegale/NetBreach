#!/bin/bash
source DontEdit.sh

# Check if the OS is Linux
if [[ "${OSTYPE}" == "linux-gnu"* ]]; then
    if ping -c 1 google.com >/dev/null 2>&1; then
        sudo apt-get install -y "${package_name}"

        # Function to install package using apt package manager
        install_linux_package() {
            package_name="$1"
            sudo apt-get install -y "${package_name}"
            if [ $? -eq 0 ]; then
                echo -e "[ ${GREEN}OK${NC} ] ${package_name} installed successfully."
            else
                echo -e "[ ${RED}ERROR${NC} ] Failed to install ${package_name}."
                return 1
            fi
        }

        # Function to install package using pip
        install_pip_package() {
            package_name="$1"
            python3 -m pip install --user --upgrade "${package_name}" >/dev/null 2>&1
            if [ $? -eq 0 ]; then
                echo -e "[ ${GREEN}OK${NC} ] ${package_name} installed successfully."
            else
                echo -e "[ ${RED}ERROR${NC} ] Failed to install ${package_name}."
                return 1
            fi
        }

        echo "_________APT PACKAGES________"

        # Install APT packages
        for package in "${Packages[@]}"; do
            install_linux_package "${package}" || failed_packages+=("${package}")
        done

        echo "_________PIP PACKAGES________"
        # Install PIP packages
        for PIP in "${pipPackages[@]}"; do
            install_pip_package "${PIP}" || failed_packages+=("${PIP}")
        done

        # Update PIP
        echo "_________PIP UPDATES________"
        python3 -m pip install --upgrade pip >/dev/null 2>&1
        if [ $? -eq 0 ]; then
            echo -e "[ ${GREEN}OK${NC} ] pip packages updated successfully."
        else
            echo -e "[ ${RED}ERROR${NC} ] Failed to update pip packages."
            failed_packages+=("pip_packages_update")
        fi

        # Check for failed package installations
        if [ ${#failed_packages[@]} -eq 0 ]; then
            echo "All packages installed successfully."
        else
            echo "Error: The following packages failed to install:"
            printf "%s\n" "${failed_packages[@]}"
        fi

    else
        echo -e "[ ${RED}FAIL${NC} ]: NOT CONNECTED TO THE INTERNET"
    fi
else
    echo -e "[ ${RED}FAIL${NC} ] Wrong OS, please use the correct OS."
fi
