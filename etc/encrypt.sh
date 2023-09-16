#!/bin/bash
# List of colors for the program to read and output
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# List of valid help commands for user guidance
help=("help" 
      "HELP" 
      "What happens" 
      "what do you do"
      "y"
      "yes"
      "YES"
      "Y")

no=("N"
    "n"
    "no" 
    "NO")

startOfProgram() {
  echo "Would you like to know what this program does? [y/n]"

  read -p ">>> " info

  # Convert input to lowercase for case-insensitive comparison
  info_lower=$(echo "$info" | tr '[:upper:]' '[:lower:]')

  if [[ " ${help[*]} " == *" ${info_lower} "* ]]; then
    # Display help information
    figlet "? HELP ?"
    echo "The process will first encrypt the plain text file,"
    echo "turning it into a random string of letters and numbers."
    echo "Then it will delete the original file and retain the encrypted file."
    exit 1
  elif [[ " ${no[*]} " == *" ${info_lower} "* ]]; then
    # Display the project logo
    figlet -f slant "Encrypter"

    # Display a blank line
    echo

    # List all files in the directory, including hidden ones
    ls -a

    # Prompt the user to input the name of the file to encrypt
    read -e -p "Enter the filename you want to encrypt: " fileName

    # Prompt the user to input a new filename for the encrypted file
    read -p "Enter a new filename for the encrypted file: " NewFileName

    # Function to initiate the encryption process
    function start() {
      # Encrypt the file using AES-256 encryption
      openssl enc -aes-256-cbc -salt -in "$fileName" -out "$NewFileName"
    }

    # Function to handle file deletion and cleanup
    function delete_file() {
      # Ask the user if they are done and want to delete the original file
      read -p "Are you done? (yes or no) You can also type (HELP) to learn more: " confirm

      # Convert confirm to lowercase for case-insensitive comparison
      confirm_lower=$(echo "$confirm" | tr '[:upper:]' '[:lower:]')

      if [ "$confirm_lower" == "yes" ]; then
        # Check if the file exists and is not a directory
        if [ -f "$fileName" ]; then
          # Remove the original file
          rm -f "$fileName"
          echo "[+] DONE"
        elif [ -d "$fileName" ]; then
          # Remove the directory
          rm -rf "$fileName"
          echo "[+] DONE"
        fi
      fi
    }
  else
    echo "I don't know what you mean by: '$info'"
    echo
    echo -e "If you need help with this program, type: ${GREEN}'${help[*]}'${NC}"
  fi
}

# Call the functions to execute the program
startOfProgram
