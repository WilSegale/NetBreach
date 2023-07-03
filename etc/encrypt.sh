figlet -f slant "Encrypter"

help=("help" "HELP" "What happens" "what do you do" "Y")

ls -a 
read -p "input a file name: " fileName
read -p "input a new file name: " NewFileName

function start() {
  #encrypts the file
  zip -er $NewFileName $fileName
  delate_file
}

function delate_file() {
  #asks the user if they are done and want to delate the old file
  read -p "Are you done yes or no: " confirm

  if [[ $confirm == "yes" ]]; then
    sudo rm -rf $fileName

  else if [[ " ${help[*]} " == *" $confirm "* ]]; then
    echo "The prompt will Delate the old file and keep the encrypted file"
  
  else
    start
  fi
}