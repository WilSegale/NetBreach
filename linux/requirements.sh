#!/bin/bash
source DontEdit.sh

# Initialize array for failed packages
failed_packages=()

# Check if the OS is Linux
if [[ "${OSTYPE}" == "linux-gnu"* ]]; then
    if ping -c 1 google.com >/dev/null 2>&1; then
        # Function to install package using apt package manager
        install_linux_package() {
            package_name="$1"
            sudo apt-get install "${package_name}" -y
            if [ $? -eq 0 ]; then
                echo -e "[ OK ] ${package_name} installed successfully."
            else
                echo -e "[ ERROR ] Failed to install ${package_name}."
                failed_packages+=("${package_name}")
            fi
        }

        # Function to install package using pip
        install_pip_package() {
            package_name="$1"
            python3 -m pip install --user --upgrade "${package_name}"
            if [ $? -eq 0 ]; then
                echo -e "[ OK ] ${package_name} installed successfully."
            else
                echo -e "[ ERROR ] Failed to install ${package_name}."
                failed_packages+=("${package_name}")
            fi
        }

            # Install package using pip
            install_pip_package() {
                package_name="$1"
                if ! python3 -m pip show "${package_name}" >/dev/null 2>&1; then
                    sudo -k
                    pip3 install "${package_name}" --break-system-packages
                else
                    echo -e "[ ${GREEN}OK${NC} ] ${package_name} is already installed."
                fi
            }

        # Install APT packages
        for package in "${Packages[@]}"; do
            install_linux_package "${package}"
        done

        echo ""
        echo "_________PIP PACKAGES________"
        # Install PIP packages
        for PIP in "${pipPackages[@]}"; do
            install_pip_package "${PIP}"
        done

        # Update PIP
        echo ""
        echo "_________PIP UPDATES________"
        python3 -m pip install --upgrade pip
        if [ $? -eq 0 ]; then
            echo -e "[ OK ] pip packages updated successfully."
        else
            echo -e "[ ERROR ] Failed to update pip packages."
            failed_packages+=("pip_packages_update")
        fi

        # Check for failed package installations
        if [ ${#failed_packages[@]} -eq 0 ]; then
            echo "All packages installed successfully."
        else
            echo ""
            echo "_________FAILED PACKAGE(S) INSTALL________"
            echo -e "[ ERROR ] The following packages failed to install:"
            printf "%s\n" "${failed_packages[@]}"
        fi

        else
            echo -e "[ FAIL ] NOT CONNECTED TO THE INTERNET"
        fi
    else
        echo -e "[ FAIL ] Wrong OS, please use the correct OS."
    fi

requiredments
