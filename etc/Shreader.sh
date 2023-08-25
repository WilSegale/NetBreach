#!/bin/bash

# Define the green color escape sequence
GREEN='\033[0;32m'

# Reset the text color to default
RESET='\033[0m'

# Define arrays for valid inputs
YES=("yes" "YES" "Yes")

NO=("no" "NO" "No")

HELP=("help" "HELP" "Help")

# Function for file encryption
function sheard() {

   # Prompt user for input
   read -p "Are you sure you want to encrypt your files (YES, NO or Help)? " YesNo

   # Check if input is in the YES array
   if [[ " ${YES[*]} " == *" $YesNo "* ]]; then
      # Specify the number of random strings to generate
      read -p "Enter the number of random strings to generate: " num_strings

      # Specify the length of each random string
      read -p "Enter the length of each random string to generate: " string_length
      read -p "Input the file you want to encrypt: " FileName
      # Generate random strings using openssl
      for ((i=0; i<num_strings; i++)); do
         random_string=$(openssl rand -base64 $((string_length * 3/4)) | tr -dc 'a-zA-Z0-9' | head -c $string_length)
         echo $random_string > $FileName
      done
      
   # Check if input is in the NO array
   elif [[ " ${NO[*]}" == *" $YesNo "* ]]; then
      echo "Exting program..."
      sleep 1
      echo -e "${GREEN}[+]${RESET} Done"
      exit 1

   # Check if input is in the HELP array
   elif [[ " ${HELP[*]}" == *" $YesNo "* ]]; then      
      figlet "HELP ?"
      echo "What this program does is that it encrypts your files and makes them unreadable forever."
      echo "So use at your own risk."

   # Input is not recognized
   else
      echo "ERROR: I DON'T KNOW WHAT YOU MEAN BY '${YesNo}'"
   fi
}

# Call the sheard function
sheard