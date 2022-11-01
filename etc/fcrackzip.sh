brew install fcrackzip
figlet -f slant "fcrackzip"
ls -a
read -p "input the file name: " FileName
fcrackzip -u -D -p rockyou.txt $FileName
unzip $FileName