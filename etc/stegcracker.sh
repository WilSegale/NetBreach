package="stegcracker"
pip show "$package_name" > /dev/null 2>&1

if [ $? -eq 0 ]; then
  echo "$package_name is installed."
else
  echo "$package_name is not installed."
fi


figlet -f slant "stegcracker"
ls -a
read -p "input the img name: " $img_filename
stegcracker $img_filename wordlist.txt

if [[ "$FileName" == "exit" ]]; then
   clear
   exit
fi