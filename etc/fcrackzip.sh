#!/bin/bash

# Define constants for URL, OS type, and file names
SITE_URL="https://google.com"
MAC="darwin"
password_file=".password.txt"  # File to store the password
hint_file=".hint.txt"          # File to store the password hint

# Check if the script is running on macOS
if [[ "$OSTYPE" == "${MAC}"* ]]; then
    # Function to handle password setup and retrieval
    getPassword() {
        if [ -f "${password_file}" ]; then
            pass=$(cat "${password_file}")  # Read the password from the file
        else
            # Prompt the user to create a new password
            read -sp "Set a new password: " pass
            echo
            read -sp "Retype your password: " RetypePassword

            # Verify that the passwords match
            if [ "${pass}" != "${RetypePassword}" ]; then
                echo
                echo "ERROR"
                getPassword  # Retry if passwords don't match
            else
                echo "${pass}" > "${password_file}"  # Save the password
            fi
        fi

        if [ -f "${hint_file}" ]; then
            hint=$(cat "${hint_file}")  # Read the hint from the file
        else
            # Prompt the user to set a hint for the password
            echo
            read -p "Set a hint for the password: " hint
            echo "${hint}" >> "${hint_file}"  # Save the hint
        fi
    }

    # Call the getPassword function
    getPassword

    # Function to handle zip file password cracking
    FCRACKZIP() {
        # List of required packages
        packages=("fcrackzip" 
                  "figlet" 
                  "ffmpeg")

        # Display the password hint to the user
        echo "| ${hint} |"
        echo
        read -s -p "Enter Password: " EnterPassword
        echo

        # Validate the entered password
        if [ "${EnterPassword}" != "${pass}" ]; then
            echo "Wrong Password"
            
            # Display an error notification
            title="ERROR"
            WrongPassword="Wrong Password"
            osascript -e "display notification \"$WrongPassword\" with title \"$title\""

            # Get the user's geolocation info using an API
            geo_info=$(curl -s ipinfo.io)

            # Extract latitude and longitude
            latitude=$(echo "${geo_info}" | jq -r '.loc | split(",")[0]')
            longitude=$(echo "${geo_info}" | jq -r '.loc | split(",")[1]')

            # Extract city and country
            city=$(echo "$geo_info" | jq -r '.city')
            country=$(echo "$geo_info" | jq -r '.country')

            # Display location information in a dialog
            title="Location information"
            Location1="Latitude: ${latitude}"
            Location2="Longitude: ${longitude}"
            osascript -e "display dialog \"${Location1} \n${Location2}\n\nCity: ${city} \nCountry: ${country} \" with title \"$title\""

            # Take a photo of the user using ffmpeg
            ffmpeg -f avfoundation -framerate 30 -video_size 1280x720 -i "0" -frames:v 1 image.jpg

            # Open the captured image
            open image.jpg
            
            # Exit the script
            exit 1
        else
            # Array to track missing packages
            missing_packages=()

            # Check if all required packages are installed
            for package in "${packages[@]}"; do
                if ! type "${package}" >/dev/null 2>&1; then
                    missing_packages+=("${package}")
                fi
            done

            # Install missing packages if necessary
            if [ ${#missing_packages[@]} -eq 0 ]; then
                clear
                PackgeInstalled="Packages"
                alreadyInstalled="All packages are installed."
                osascript -e "display notification \"$alreadyInstalled\" with title \"$PackgeInstalled\""
            else
                echo "Installing missing packages: ${missing_packages[*]}"
                if type brew >/dev/null 2>&1; then
                    brew install "${missing_packages[@]}"
                else
                    title="Error:"
                    HomebrewMessage="Homebrew is required for package installation."
                    osascript -e "display notification \"$HomebrewMessage\" with title \"$PackgeInstalled\""
                    exit 1
                fi

                clear
                PackgeInstall="Packages"
                installed="Packages installed."
                osascript -e "display notification \"$installed\" with title \"$PackgeInstall\""
            fi

            # Display a stylized header
            figlet -f slant "fcrackzip"

            # List all files (including hidden files)
            ls -a

            # Prompt for target file and password file
            read -e -p "Input the file name: " FileName
            read -e -p "Input the password file name: " PasswordFile

            # Attempt to crack the zip file password
            fcrackzip -u -D -p "${PasswordFile}" "${FileName}"

            # Unzip the file
            unzip "${FileName}"
        fi
    }

    # Call the FCRACKZIP function
    FCRACKZIP
else
    # Print error message if OS is not macOS
    echo "[-] Wrong OS"
fi