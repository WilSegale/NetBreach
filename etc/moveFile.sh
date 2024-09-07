read -p "Input the username for the file transfer: " username
read -p "Input the IP address for the file transfer: " ipaddress
read -p "Input the folder you want to transfer: " folder
read -p "Input the destination for the file to go to: " destination

# Use quotes around variables to handle paths with spaces
scp -r "${folder}" "${username}"@"${ipaddress}":"${destination}"
