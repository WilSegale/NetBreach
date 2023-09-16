#!/bin/bash
# list of colors for the program to read and output
GREEN='\033[0;32m'
NC='\033[0m' # No Color


# List of valid help commands for user guidance
help=("help" 
      ,"HELP" 
      "What happens" 
      "what do you do"
      "y"
      "yes"
      "YES")

no=("N"
    "n"
    "no" 
    "NO")


startOfProgram() {
  echo "Would you like to know what this program does? [y/n]"

  read -p ">>> " info

  if [[ " ${help[*]} " == *" ${info} "* ]]; then
    # Display help information
    figlet "? Help ?"
    echo "The process will first encrypt the plain text file,"
    echo "turning it into a random string of letters and numbers."
    echo "Then it will delete the original file and retain the encrypted file."
    exit 1
  
  elif [[ " ${no[*]} " == *" ${info} "* ]]; then
    # Display the project logo
    figlet "Encrypter"
    
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
      # Encrypt the file
      zip -er "${NewFileName}" "${fileName}"
    }

    # Function to handle file deletion and cleanup
    function delete_file() {
      # Ask the user if they are done and want to delete the original file
      read -p "Are you done? (yes or no) You can also type (HELP)  to learn more: " confirm
      
        # If the input is not a valid help command
        if [ "${confirm}" == "yes" ]; then
          # Check if the file exists and is not a directory
          if [ -f "${fileName}" ]; then
            # Define the length of the random string
            length=10000

            # Generate a random string
            random_string=$(openssl rand -hex "${length}" | sed 's/\(..\)/\1/g;s/*$//')

            # Inform the user about the encryption process
            echo "Encrypting ${fileName}"

            # Write the random string to the file
            echo "${random_string}" > "${fileName}"

            # Remove the original file
            sudo rm -rf "${fileName}"
            sleep 1
            echo "[+] DONE"
            
          elif [ -d "${fileName}" ]; then
            # Remove the directory
            sudo rm -rf "${fileName}"
            sleep 1
            echo "[+] DONE"
          fi
        fi
    }
  else
    echo "I dont know what you mean by: '${info}'"
    echo 
    echo -e "If you need help with this program please type: ${GREEN}'${help[*]}'${NC}"
  fi
}
# Call the functions to execute the program
startOfProgram

