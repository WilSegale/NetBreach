#!/bin/bash

# Check if running as root
if [[ "$EUID" -ne 0 ]]; then
    echo "Please run as root."
    exit 1
fi

# Load DontEdit.sh if it exists
if [[ ! -f "DontEdit.sh" ]]; then
    echo "DontEdit.sh not found!"
    exit 1
fi

source DontEdit.sh

# Check if system is Linux-based
if [[ "$OSTYPE" == "linux"* ]]; then

    # Default values
    pipForceMode=false

    # Argument Parsing
    for arg in "$@"; do
        case $arg in
            --pipForce)
                pipForceMode=true
                shift
                ;;
        esac
    done

    # Help function
    HELP() {
        echo "REQUIREMENTS HELP"
        echo "_________________"
        echo "This script checks and installs required packages."
        echo "If pip packages fail to install, run:"
        echo '''bash requirements.sh --pipForce'''
        echo "_________________"
        exit 1
    }

    # Function to install system packages
    install_package() {
        local package_name="$1"
        if ! dpkg -l | grep -q "^ii  ${package_name} "; then
            sudo apt update
            sudo apt install -y "${package_name}"
            if [[ $? -eq 0 ]]; then
                echo -e "[ ${GREEN}OK${NC} ] ${package_name} installed successfully."
            else
                echo -e "[ ${YELLOW}WARNING${NC} ] ${package_name} installation failed."
            fi
        else
            echo -e "[ ${GREEN}OK${NC} ] ${package_name} is already installed."
        fi
    }

    # Function to install pip packages
    install_pip_package() {
        if $pipForceMode; then
            echo "[+] Using PIP FORCE mode"
            python3 -m pip install --upgrade pip --break-system-packages
        else
            echo "[-] Not using PIP FORCE mode"
            python3 -m pip install --upgrade pip
        fi

        local package_name="$1"
        python3 -m pip install --user --upgrade "${package_name}" --break-system-packages
        if [[ $? -eq 0 ]] && python3 -c "import ${package_name}" &>/dev/null; then
            echo -e "[ ${GREEN}OK${NC} ] ${package_name} installed and verified."
        else
            echo -e "[ ${RED}FAIL${NC} ] Failed to install ${package_name}."
            exit 1
        fi
    }

    # Install required packages
    installPackages() {
        echo "_________INSTALLING SYSTEM PACKAGES_________"
        for package in "${Packages[@]}"; do
            install_package "${package}"
        done

        echo "_________INSTALLING PIP PACKAGES_________"
        for PIP in "${pipPackages[@]}"; do
            install_pip_package "${PIP}"
        done

        echo "_________VERIFYING INSTALLED PACKAGES_________"
        ./check_packages.sh  # Calls the check script
    }

    # Handle Ctrl+Z (SIGTSTP)
    trap 'EXIT_PROGRAM_WITH_CTRL_Z' SIGTSTP

    # Handle Ctrl+C (SIGINT)
    trap 'EXIT_PROGRAM_WITH_CTRL_C' SIGINT

    if [[ "$1" == "--help" || "$1" == "-h" ]]; then
        HELP
    else
        installPackages
    fi
else
    echo -e "[ ${YELLOW}WARNING${NC} ] This script is only supported on Linux."
    exit 1
fi