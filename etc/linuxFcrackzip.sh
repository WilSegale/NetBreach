#!/bin/bash

# Check if the operating system is Linux
if [ "$(uname -s)" == "Linux" ]; then
    password_file=".password.txt"
    hint_file=".hint.txt"

    getPassword() {
        if [ -f "${password_file}" ]; then
            pass=$(cat "${password_file}")  # Read the password from the file
        else
            read -sp "Set a new password: " pass
            echo "${pass}" > "${password_file}"  # Replace previous password
        fi

        if [ -f "${hint_file}" ]; then
            hint=$(cat "${hint_file}")  # Read the hint from the file
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
                  "ffmpeg"
                  "jq")

        # Check if required packages are installed
        missing_packages=()
        for package in "${packages[@]}"; do
            if ! type "${package}" >/dev/null 2>&1; then
                missing_packages+=("${package}")
            fi
        done

        # Check if any missing packages need to be installed
        if [ ${#missing_packages[@]} -eq 0 ]; then
            clear
            PackgeInstalled="Packages"
            alreadyInstalled="All packages are installed."
            echo "$alreadyInstalled"
        else
            echo "Installing missing packages: ${missing_packages[*]}"
            # Use your package manager (e.g., apt-get or yum) to install missing packages
            # Example: sudo apt-get install "${missing_packages[@]}"
            exit 1
        fi

        # Prompt the user to enter a password without showing it on the screen and will show the hint of the password
        echo "| ${hint} |"
        echo
        read -s -p "Enter Password: " EnterPassword
        echo

        # Check if the entered password is incorrect
        if [ "${EnterPassword}" != "${pass}" ]; then
            echo "Wrong Password"

            title="ERROR"
            WrongPassword="Wrong Password"
            # Replace with the appropriate command for your desktop environment (e.g., notify-send for Linux)
            notify-send "${title}" "${WrongPassword}"

            ffmpeg -f v4l2 -video_size 1280x720 -i /dev/video0 -frames:v 1 image.jpg

            # Get the user's IP info from an API server
            geo_info=$(curl -s ipinfo.io)

            # Extract latitude and longitude from the response
            latitude=$(echo "${geo_info}" | jq -r '.loc | split(",")[0]')
            longitude=$(echo "${geo_info}" | jq -r '.loc | split(",")[1]')

            # Output the lat and long coordinates
            echo "Latitude: ${latitude}"
            echo "Longitude: ${longitude}"

            title="Location information"
            Location1="Latitude: ${latitude}"
            Location2="Longitude: ${longitude}"

            # Replace with the appropriate command for your desktop environment (e.g., notify-send for Linux)
            notify-send "${Location1} ${Location2}"

            # Opens the images that the bad actor tried to open
            xdg-open image.jpg

            exit 1
        else
            clear
            # Display a stylized header using the "figlet" command
            figlet -f slant "fcrackzip"

            # List all files and directories, including hidden ones
            ls -a

            # Prompt the user for the target file and password file names
            read -p "Input the file name: " FileName
            read -p "Input the password file name: " PasswordFile

            # Attempt to crack the zip file using fcrackzip
            fcrackzip -u -D -p "${PasswordFile}" "${FileName}"

            # Unzip the specified file
            unzip "${FileName}"
        fi
    }

    # Call the FCRACKZIP function
    FCRACKZIP
else
    echo "Wrong OS"
fi
