help=("help" "HELP" "What happens" "what do you do" "Y")

ls -a 
read -p "input a file name: " fileName
read -p "input a new file name: " NewFileName

function start() {
  #encrypts the file
  zip -er "$NewFileName" "$fileName"
  delete_file
}

function delete_file() {
  #asks the user if they are done and want to delete the old file
  read -p "Are you done? (yes or no): " confirm

  if [[ $confirm == "yes" ]]; then
    sudo rm -rf "$fileName"
  elif [[ " ${help[*]} " == *" $confirm "* ]]; then
    echo "The prompt will delete the old file and keep the encrypted file"
  else
    start
  fi
}