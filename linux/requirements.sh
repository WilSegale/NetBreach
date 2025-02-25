#!/bin/bash
# Check if root user
# Load DontEdit.sh if it exists
if [ -f "DontEdit.sh" ]; then
    source DontEdit.sh
else
    echo "DontEdit.sh not found!"
    exit 1
fi

if [[ "$OSTYPE" == "${OS}"* ]]; then

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

    # Load DontEdit.sh if it exists
    if [ -f "DontEdit.sh" ]; then
        source DontEdit.sh
    else
        echo "DontEdit.sh not found!"
        exit 1
    fi

    # Help function
    HELP() {
        echo "REQUIREMENTS HELP"
        echo "_________________"
        echo "This script is used to check if the system has the required packages installed."
        echo "If the pip packages fail to install type"
        echo '''bash requirements.sh --pipForce'''
        echo "_________________"
        exit 1
    }

    # Function to install packages using apt (modify if using another package manager)
    install_package() {

        package_name="$1"
        if ! dpkg -l | grep -q "^ii  ${package_name} "; then
            sudo apt update
            sudo apt install -y "${package_name}"
            if [ $? -eq 0 ]; then
                echo -e "[ ${GREEN}OK${NC} ] ${package_name} installed successfully."
            else
                echo -e "[ ${yellow}WARNING${NC} ] ${package_name} installation failed."
            fi
        else
            echo -e "[ ${GREEN}OK${NC} ] ${package_name} is already installed."
        fi
    }

    # Function to check for installed packages
    checkForPackages() {
        for package in "${Packages[@]}"; do
            if dpkg -l | grep -q "^ii  ${package} "; then
                echo -e "[ ${GREEN}OK${NC} ] ${package}"
            else
                echo -e "[ ${RED}FAIL${NC} ] ${package}"
            fi
        done

        echo -e "________PIP Packages________"
        for pipPackage in "${pipPackages[@]}"; do
            if python3 -c "import ${pipPackage}" &>/dev/null; then
                echo -e "[ ${GREEN}OK${NC} ] ${pipPackage}"
            else
                echo -e "[ ${RED}FAIL${NC} ] ${pipPackage}"
            fi
        done
    }

    # Function to install pip package
    install_pip_package() {
        if $pipForceMode; then
            title="[+] PIP FORCE"
            message="Using PIP FORCE mode"
            notify-send "$title" "$message"
            if python3 -m pip install --upgrade pip --break-system-packages; then
                echo -e "[ ${GREEN}OK${NC} ] pip upgraded successfully."
            else
                echo -e "[ ${RED}ERROR${NC} ] Failed to upgrade pip with force."
            fi
        else
            title="[-] PIP FORCE"
            message="Not using PIP FORCE mode"
            notify-send "$title" "$message"
            if python3 -m pip install --upgrade pip; then
                echo -e "[ ${GREEN}OK${NC} ] pip upgraded successfully."
            else
                echo -e "[ ${RED}ERROR${NC} ] Failed to upgrade pip."
            fi
        fi

        package_name="$1"
        python3 -m pip install --user --upgrade "${package_name}" --break-system-packages
        if [ $? -eq 0 ]; then
            if python3 -c "import ${package_name}" &>/dev/null; then
                echo -e "[ ${GREEN}OK${NC} ] ${package_name} installed and verified successfully."
            else
                echo -e "[ ${RED}FAIL${NC} ] ${package_name} installed but could not be imported in Python."
                exit 1
            fi
        else
            echo -e "[ ${RED}FAIL${NC} ] Failed to install ${package_name}."
            exit 1
        fi
    }

    # Install packages function
    installPackages() {
        echo "_________PACKAGES INSTALLATION________"
        for package in "${Packages[@]}"; do
            install_package "${package}"
        done

        echo "_________PIP PACKAGES INSTALLATION AND PIP UPDATE________"
        for PIP in "${pipPackages[@]}"; do
            install_pip_package "${PIP}"
        done

        echo "_________INSTALLED PACKAGES________"
        checkForPackages
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
    echo -e "[ ${yellow}${BRIGHT}WARNING${NC} ] This script is only supported on ${GREEN}${OS}${NC} operating systems."
    exit 1
fi