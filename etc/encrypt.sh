figlet "| Encrypter |"
help=("help" "HELP" "What happens" "what do you do")
echo
ls -a 
read -p "input a file name: " fileName
read -p "input a new file name: " NewFileName

function start() {
  #encrypts the file
  zip -er "$NewFileName" "$fileName"
}

function delete_file() {
  #asks the user if they are done and want to delete the old file
  read -p "Are you done? (yes or no): " confirm

  #this will remove the old file from the computer
  if [[ $confirm == "yes" ]]; then
    sudo rm -rf "$fileName"

  #this will tell the user what will happen when they say yes or no for the prompt
  elif [[ " ${help[*]} " == *" $confirm "* ]]; then
    echo "The prompt will delete the old file and keep the encrypted file"
    delete_file
  else
    start
  fi
}
start
delete_file