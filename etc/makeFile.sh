function makeFilesystem(){
   echo "Creating filesystem..."
   sleep 3
   clear
   echo "Filesystem made"
   read -p "Make file name: " MakeFile
   read -p "Input text for the file to hold: " InputText
   echo $InputText > $MakeFile 
}
makeFilesystem;