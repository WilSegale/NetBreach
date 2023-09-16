#!/bin/bash
# List of colors for the program to read and output
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# List of valid help commands for user guidance
help=("help" 
      "HELP" 
      "What happens" 
      "what do you do")

yes=("yes" 
     "Yes" 
     "YES")

no=("N"
    "n"
    "no" 
    "NO")

startOfProgram() {
  echo "Would you like to know what this program does? Type HELP if not type NO"

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
    read -p "Do you want to have the encryption level openssl(This type of encryption can not be recvered esaly) [Y/N]: " Encrpyion
    # Encrypt the file using AES-256 encryption
    if [[ " ${yes[*]} " == *" ${Encrpyion} "* ]]; then
    openssl enc -aes-256-cbc -salt -in "$fileName" -out "$NewFileName"
    
    else
      zip -e "$NewFileName" "$fileName" 
      delete_file
    fi
      # Function to delete a file
      deleteFile() {
          local file="$1"
          if [ -f "$file" ]; then
              rm -f "$file"
              echo "Deleted: $file"
          else
              echo "File not found: $file"
          fi
      }

      # Prompt the user for the file to delete
      read -p "Enter the name of the file to delete: " fileToDelete

      # Call the deleteFile function with the user-specified file
      deleteFile "$fileToDelete"

      # Check if the file was deleted successfully
      if [ $? -eq 0 ]; then
          echo "File deleted successfully."
      else
          echo "Failed to delete the file."
      fi
}

# Call the functions to execute the program
startOfProgram