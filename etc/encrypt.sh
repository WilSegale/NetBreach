#Logo of the project
figlet "| Encrypter |"

#Array of help commands for if the user gets confused about what to do 
help=("help" "HELP" "What happens" "what do you do")

#A space in the Logo and the list files command
echo

#lists the all the files in the directory even the hidden ones
ls -a 

# ask for the user to input the file name they want to encrypt
read -p "input a file name: " fileName

#ask the user to input a new file that will overwrite the existing file
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
    # Define the length of the random string
    length=10000

    # Generate the random string
    random_string=$(openssl rand -hex "$length" | sed 's/\(..\)/\1/g;s/*$//')
    
    #tells the user that the file is being encrypted
    echo "Encrypting ${fileName}"

    # a for loop that randomly generates 1000 diffrent string of numbers and letters 
    for ((i=1; i<=1000; i++))
    do
      #Encrypts the file so its harder to see whats inside the file if someone revoers it
      echo $random_string > $fileName
      
      sleep 1
    done
    
    #remvoes the file
    sudo rm -rf $fileName
    sleep 1
    echo "[+] DONE"
  
  #this will tell the user what will happen when they say yes or no for the prompt
  elif [[ " ${help[*]} " == *" $confirm "* ]]; then
    #tell the user how it works and what they can expect to happen when they say yes in the confirm prompt
    echo "The prompt will first encrypt the plain text file." 
    echo "So if it gets recovered it will be a random string of letters and numbers"
    echo "then it will delete the old file and keep the encrypted file"
    delete_file
 
  else
    # this returns to the start of the program if the user doenst input anything in the confirm prompt
    start
  fi
}

# this calls the functions so it can work properly
start
delete_file