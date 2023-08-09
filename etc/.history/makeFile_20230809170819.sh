function makeFilesystem(){
   # tells the user that the filesystem is being made
   echo "Creating filesystem..."
   
   sleep 3
   
   #clears the terminal before doing anything
   clear
   
   # tells the user that the filesystem is created
   echo "Filesystem made"

   #tells the user to input text that will be put in a file to be saved
   read -p "Input text for the file to hold: " InputText
   
   #asks the user to tell them the name of the file that want to create
   read -p "Make file name: " MakeFile
   
   #puts the user input in a file that they created
   echo $InputText > $MakeFile 
}
#makes the program work
makeFilesystem;