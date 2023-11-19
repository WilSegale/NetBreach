read -p "Input the usersname for the file transfer: " username
read -p "Input the IP address for the file transfer: " ipaddress
read -p "Input the file you want to transfer: " file
read -p "Input the destination for the file to goto: " destination
scp $username@$ipaddress:$file $destination
