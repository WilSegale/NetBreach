#!/bin/bash

# Define color escape sequences
GREEN='\033[0;32m'
RESET='\033[0m'

# Define arrays for valid inputs
VALID_YES=("yes" "YES" "Yes")
VALID_NO=("no" "NO" "No")
VALID_HELP=("help" "HELP" "Help")

# Define a function for file encryption
function encryptFiles() {
    # Prompt user for input
    read -p "Do you wish to proceed with file encryption? (YES, NO, or Help): " userResponse

    # Check if input is in the valid YES array
    if [[ " ${VALID_YES[*]} " == *" ${userResponse} "* ]]; then
        read -p "Enter the number of random strings to generate: " numStrings
        read -p "Enter the length of each random string to generate: " stringLength
        read -p "Enter the name of the file you want to encrypt: " targetFile

        # Generate random strings using openssl
        for ((i=0; i<numStrings; i++)); do
            randomString=$(openssl rand -base64 $((stringLength * 3/4)) | tr -dc 'a-zA-Z0-9' | head -c "${stringLength}")
            echo "${randomString}" > "${targetFile}"
        done
      
    # Check if input is in the valid NO array
    elif [[ " ${VALID_NO[*]}" == *" ${userResponse} "* ]]; then
        echo "Exiting program..."
        sleep 1
        echo -e "${GREEN}[+]${RESET} Done"
        exit 1

    # Check if input is in the valid HELP array
    elif [[ " ${VALID_HELP[*]}" == *" ${userResponse} "* ]]; then      
        figlet "HELP ?"
        echo "This program encrypts your files, rendering them permanently unreadable."
        echo "Use this program cautiously and at your own risk."

    # Input is not recognized
    else
        echo "ERROR: Unrecognized input '${userResponse}'"
    fi
}

# Call the encryptFiles function
encryptFiles
