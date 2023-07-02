#!/bin/bash
os_name=$(uname -s)  # Get the operating system name

package=("fcrackzip"
         "figlet")  # Set the package name to be installed

if [[ $os_name == "Linux" ]]; then  # If the OS is Linux
    if ! dpkg -s "$package" >/dev/null 2>&1; then  # Check if the package is not installed
        sudo apt-get install fcrackzip  # Install fcrackzip package
        sudo apt-get install figlet  # Install figlet package
    else
        clear
        echo "${package} is already installed"  # Package is already installed
    fi
    
elif [[ $os_name == "Darwin" ]]; then  # If the OS is macOS
    if ! brew list -1 | grep -q "$package"; then  # Check if the package is not installed
        brew install fcrackzip  # Install fcrackzip package using Homebrew
        brew install figlet  # Install figlet package using Homebrew
    else
        clear
        echo "${package} is already installed"  # Package is already installed
    fi
else
    echo "Your System is not recognized"  # System not recognized
fi

figlet -f slant "fcrackzip"  # Display "fcrackzip" in ASCII art
ls -a  # List all files, including hidden ones
read -p "Input the file name: " FileName  # Prompt for the file name
read -p "Input the Password File: " PasswordFile  # Prompt for the password file

if [[ "$FileName" == "exit" ]]; then  # If the file name is "exit"
    clear
    echo "Exiting program"  # Display exit message
    sleep 1  # Pause for 1 second
    clear
    exit  # Exit the script
fi

fcrackzip -u -D -p "${PasswordFile}" "${FileName}"  # Run fcrackzip with the provided arguments
unzip "${FileName}"  # Unzip the file
