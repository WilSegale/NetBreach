#!/bin/bash

# ANSI color codes
GREEN="\033[32m"
NC='\033[0m' # No Color

# Display project logo
echo -e "${GREEN}"
figlet "Encrypter"
echo -e "${NC}"

# Help commands
help=("help" "HELP" "What happens" "what do you do")

# List files in the current directory
ls -A

# Get input file name
read -p "Enter the name of the file to encrypt: " fileName

# Get new file name for encrypted version
read -p "Enter a new file name for the encrypted file: " newFileName

function encrypt_file() {
  if [ -f "$fileName" ]; then
    # Encrypt the file using AES zip encryption
    zip -e "$newFileName" "$fileName"
    echo "File encrypted as $newFileName"
  else
    echo "Error: $fileName is not a valid file"
    exit 1
  fi
}

function delete_original() {
  # Ask for confirmation
  read -p "Are you sure you want to delete the original file? (yes/no): " confirm
  case $confirm in
    [Yy][Ee][Ss])
      if [ -f "$fileName" ]; then
        # Generate a random string and overwrite the file
        random_string=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 10000)
        echo "$random_string" > "$fileName"
        rm -rf "$fileName"
        echo "Original file deleted and overwritten with random data"
      elif [ -d "$fileName" ]; then
        rm -r "$fileName"
        echo "Directory $fileName deleted"
      else
        echo "Error: $fileName not found"
      fi
      ;;
    *)
      echo "Keeping the original file"
      ;;
  esac
}

# Main execution
encrypt_file
delete_original
