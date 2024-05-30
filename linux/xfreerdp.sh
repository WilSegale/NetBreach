source DontEdit.sh
clear
#get to the xfreerdp connection
ConnectXfreerdp(){
    figlet -f slant "xfreerdp"
    sudo nmap -sS 192.168.1.1/24 -Pn -oN scan.txt --open
    echo
    read -p "Input username: " username
    read -p "Input IP: " ip
    read -s -p "Input password: " password
    # Put the
    echo
    echo "Loading xfreerdp server..."
    sleep 1
    xfreerdp /u:"${username}" /v:"${ip}" /p:"${password}"
    exit
}
ConnectXfreerdp