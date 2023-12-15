#!/bin/bash
SITE_URL="https://google.com"
MAC="darwin"
password_file=".password.txt"
hint_file=".hint.txt"

if [[ "$OSTYPE" == "${MAC}"* ]]; then
    getPassword() {
        if [ -f "${password_file}" ]; then
            pass=$(cat "${password_file}")  # Read the password from the file
        else
            # makes the file to store the password
            read -sp "Set a new password: " pass
            echo
            read -sp "Retype your password: " RetypePassword
            if [ "${pass}" != "${RetypePassword}" ]; then
                echo
                echo "ERROR"
                getPassword
            else
                echo "${pass}" > "${password_file}"  # Replace previous password
            fi
        fi

        if [ -f "${hint_file}" ]; then
            hint=$(cat "${hint_file}")  # Read the hint from the file
        else
            echo
            read -p "Set a hint for the password: " hint
            echo "${hint}" >> "${hint_file}"  # Store the hint
        fi
    }

    getPassword

    # Define a function named FCRACKZIP
    FCRACKZIP() {
        # List of required packages
        packages=("fcrackzip" 
                  "figlet" 
                  "ffmpeg")

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
            osascript -e "display notification \"$WrongPassword\" with title \"$title\""
            
            #get the users ip info from a API server
            geo_info=$(curl -s ipinfo.io)

            # Extract latitude and longitude from the response
            latitude=$(echo "${geo_info}" | jq -r '.loc | split(",")[0]')
            longitude=$(echo "${geo_info}" | jq -r '.loc | split(",")[1]')

            # Extract city and country from the JSON response
            city=$(echo "$geo_info" | jq -r '.city')
            country=$(echo "$geo_info" | jq -r '.country')

            title="Location information"
            Location1="Latitude: ${latitude}"
            Location2="Longitude: ${longitude}"

            #Display the location information
            osascript -e "display dialog \"${Location1} \n${Location2}\n\nCity: ${city} \nCountry: ${country} \" with title \"$title\""

            #takes a photo of the user so the owner of the computer can see them
            ffmpeg -f avfoundation -framerate 30 -video_size 1280x720 -i "0" -frames:v 1 image.jpg
 
            #opens the images that the bad actor tryed to open
            open image.jpg
            
            exit 1
        else
            # Initialize an array to store missing packages
            missing_packages=()

            # Check if required packages are installed
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
                osascript -e "display notification \"$alreadyInstalled\" with title \"$PackgeInstalled\""

            else
                echo "Installing missing packages: ${missing_packages[*]}"
                
                # Check if Homebrew is available for package installation
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

            # Display a stylized header using the "figlet" command
            figlet -f slant "fcrackzip"

            # List all files and directories, including hidden ones
            ls -a

            # Prompt the user for the target file and password file names
            read -e -p "Input the file name: " FileName
            read -e -p "Input the password file name: " PasswordFile

            # Attempt to crack the zip file using fcrackzip
            fcrackzip -u -D -p "${PasswordFile}" "${FileName}"

            # Unzip the specified file
            unzip "${FileName}"
        fi
    }

    # Call the FCRACKZIP function
    FCRACKZIP
else
    echo "[-] Wrong OS"
fi