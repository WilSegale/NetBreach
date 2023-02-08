figlet -f slant "Encrypter"

function start(){
  ls -a 
  read -p "input a file name: " fileName
  read -p "input a new file name: " NewFileName

  zip -er $NewFileName $fileName

  read -p "are you done yes or no: " confirm

  if [[ $confirm == "yes" ]] 
    then
      sudo rm -rf $fileName
    else
      start
  fi
}
start