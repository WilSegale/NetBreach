#!/bin/bash

password_file="password.txt"
hint_file="hint.txt"

getPassword() {
    if [ -f "$password_file" ]; then
        pass=$(cat "$password_file")  # Read the password from the file
    else
        read -sp "Set a new password: " pass
        echo "${pass}" > "${password_file}"  # Replace previous password
    fi

    if [ -f "$hint_file" ]; then
        hint=$(cat "$hint_file")  # Read the hint from the file
    else
        read -p "Set a hint for the password: " hint
        echo "${hint}" > "${hint_file}"  # Store the hint
    fi
}

getPassword

# Define a function named FCRACKZIP
FCRACKZIP() {
    # List of required packages
    packages=("fcrackzip" 
              "figlet"
              "unzip"
              "jq"
              "curl")

    # Prompt the user to enter a password without showing it on the screen and will show the hint of the password
    echo "| ${hint} |"
    echo
    read -s -p "Enter Password: " EnterPassword
    echo

    # Check if the entered password is incorrect
    if [ "$EnterPassword" != "$pass" ]; then
        echo "Wrong Password"

        # Capture IP information using curl and jq
        geo_info=$(curl -s ipinfo.io)
        latitude=$(echo "$geo_info" | jq -r '.loc | split(",")[0]')
        longitude=$(echo "$geo_info" | jq -r '.loc | split(",")[1]')
        echo "Latitude: $latitude"
        echo "Longitude: $longitude"
        
        exit 1
    else
        # Initialize an array to store missing packages
        missing_packages=()

        # Check if required packages are installed
        for package in "${packages[@]}"; do
            if ! type "$package" >/dev/null 2>&1; then
                missing_packages+=("$package")
            fi
        done

        # Check if any missing packages need to be installed
        if [ ${#missing_packages[@]} -eq 0 ]; then
            clear
            echo "Packages are already installed."
        else
            echo "Installing missing packages: ${missing_packages[*]}"
            
            # Check if the package manager (e.g., apt) is available for package installation
            if type apt >/dev/null 2>&1; then
                sudo apt install "${missing_packages[@]}"
            else
                echo "Error: A package manager is required for package installation."
                exit 1
            fi
            
            clear
            echo "Packages installed."
        fi

        # Display a stylized header using the "figlet" command
        figlet -f slant "fcrackzip"

        # List all files and directories, including hidden ones
        ls -a

        # Prompt the user for the target file and password file names
        read -p "Input the file name: " FileName
        read -p "Input the password file name: " PasswordFile

        # Attempt to crack the zip file using fcrackzip
        fcrackzip -u -D -p "$PasswordFile" "$FileName"

        # Unzip the specified file
        unzip "$FileName"
    fi
}

# Call the FCRACKZIP function
FCRACKZIP
