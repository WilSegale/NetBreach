#!/bin/bash

# Display the project logo
figlet "Encrypter"

# List of valid help commands for user guidance
help=("help" "HELP" 
      "What happens" 
      "what do you do")

# Display a blank line
echo

# List all files in the directory, including hidden ones
ls -a

# Prompt the user to input the name of the file to encrypt
read -p "Enter the filename you want to encrypt: " fileName

# Prompt the user to input a new filename for the encrypted file
read -p "Enter a new filename for the encrypted file: " NewFileName

# Function to initiate the encryption process
function start() {
  # Encrypt the file
  zip -er "$NewFileName" "$fileName"
}

# Function to handle file deletion and cleanup
function delete_file() {
  # Ask the user if they are done and want to delete the original file
  read -p "Are you done? (yes or no) You can also type 'help' to learn more: " confirm
  
  # Check if the provided input matches the valid help commands
  if [[ " ${help[*]} " == *" $confirm "* ]]; then
    # Display help information
    figlet "? Help ?"
    echo "The process will first encrypt the plain text file,"
    echo "turning it into a random string of letters and numbers."
    echo "Then it will delete the original file and retain the encrypted file."
    echo ""
  else
    # If the input is not a valid help command
    if [ "$confirm" == "yes" ]; then
      # Check if the file exists and is not a directory
      if [ -f "$fileName" ]; then
        # Define the length of the random string
        length=10000

        # Generate a random string
        random_string=$(openssl rand -hex "$length" | sed 's/\(..\)/\1/g;s/*$//')

        # Inform the user about the encryption process
        echo "Encrypting $fileName"

        # Write the random string to the file
        echo "$random_string" > "$fileName"

        # Remove the original file
        sudo rm -rf "$fileName"
        sleep 1
        echo "[+] DONE"
      elif [ -d "$fileName" ]; then
        # Remove the directory
        sudo rm -rf "$fileName"
        sleep 1
        echo "[+] DONE"
      fi
    fi
  fi
}

# Call the functions to execute the program
start
delete_file