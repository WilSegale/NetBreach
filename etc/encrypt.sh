#!/bin/bash

# Logo of the project
figlet "| Encrypter |"

# Array of help commands for if the user gets confused about what to do 
help=("help" "HELP" "What happens" "what do you do")

# A space in the Logo and the list files command
echo

# Lists all the files in the directory, including hidden ones
ls -a

# Asks the user to input the file name they want to encrypt
read -p "Input a file name: " fileName

# Asks the user to input a new file name that will overwrite the existing file
read -p "Input a new file name: " NewFileName

function start() {
  # Encrypts the file
  zip -er "$NewFileName" "$fileName"
}

function delete_file() {
  # Asks the user if they are done and want to delete the old file
  read -p "Are you done? (yes or no) or type 'help' to know what's going to happen: " confirm
  # if the user is encrypting on text file or mp4 file or not a file that is a folder
  if [ -f "$fileName" ]; then
    # This will remove the old file from the computer
    if [[ $confirm == "yes" ]]; then
      # Define the length of the random string
      length=10000

      # Generate the random string
      random_string=$(openssl rand -hex "$length" | sed 's/\(..\)/\1/g;s/*$//')

      # Tells the user that the file is being encrypted
      echo "Encrypting $fileName"

      # Write the random string to the file
      echo "$random_string" > "$fileName"

      # Removes the file
      sudo rm -rf $fileName
      sleep 1
      echo "[+] DONE"
    fi

  elif [ -d "$fileName" ]; then
    sudo rm -rf $fileName
    sleep 1
    echo -e "[+] DONE"

  elif [[ " ${help[*]} " == *" $confirm "* ]]; then
    # Tell the user how it works and what they can expect to happen when they say yes in the confirm prompt
    figlet "? Help ?"
    echo ""
    echo "The prompt will first encrypt the plain text file."
    echo "So if it gets recovered, it will be a random string of letters and numbers."
    echo "Then it will delete the old file and keep the encrypted file."
    echo ""
    delete_file
  else
    # This returns to the start of the program if the user doesn't input anything in the confirm prompt
    start
  fi
}

# This calls the functions so it can work properly
start
delete_file
