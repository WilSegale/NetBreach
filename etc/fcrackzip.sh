#!/bin/bash

MAC="darwin"
password_file="password.txt"

if [[ "$OSTYPE" == "${MAC}"* ]]; then
    getPassword() {
        if [ -f "$password_file" ]; then
            pass=$(cat "$password_file")  # Read the password from the file
        else
            read -sp "Set a new password: " pass
            echo "${pass}" > "${password_file}"  # Replace previous password
        fi
    }

    getPassword

    # Define a function named FCRACKZIP
    FCRACKZIP() {
        # List of required packages
        packages=("fcrackzip" "figlet" "ffmpeg")

        # Prompt the user to enter a password without showing it on the screen
        read -s -p "Enter Password: " EnterPassword
        echo

        # Check if the entered password is incorrect
        if [ "$EnterPassword" != "$pass" ]; then
            echo "Wrong Password"
            say "Wrong password"
            ffmpeg -f avfoundation -framerate 30 -video_size 1280x720 -i "0" -frames:v 1 image.jpg
            
            geo_info=$(curl -s ipinfo.io)

            # Extract latitude and longitude from the response
            latitude=$(echo "$geo_info" | jq -r '.loc | split(",")[0]')
            longitude=$(echo "$geo_info" | jq -r '.loc | split(",")[1]')

            echo "Latitude: $latitude"
            echo "Longitude: $longitude"

            open image.jpg
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
                
                # Check if Homebrew is available for package installation
                if type brew >/dev/null 2>&1; then
                    brew install "${missing_packages[@]}"
                else
                    echo "Error: Homebrew is required for package installation."
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
else
    echo "Wrong OS"
fi
