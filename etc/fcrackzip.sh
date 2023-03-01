package="fcrackzip"
if brew list | grep -q "^${package}$"; then
  clear
else
  brew install fcrackzip
  clear
  break
fi

figlet -f slant "fcrackzip"
ls -a
read -p "input the file name: " FileName
fcrackzip -u -D -p rockyou.txt $FileName

if [[ "$FileName" == "exit" ]] 
  then
    clear
    exit
fi
unzip $FileName