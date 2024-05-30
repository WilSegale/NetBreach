source DontEdit.sh
clear
#get to the xfreerdp connection
ConnectXfreerdp(){

    FILE="connections.conf"
    figlet -f slant "xfreerdp"

    # Check if file exists
    if [ -e "${FILE}" ]; then
        source $FILE
        xfreerdp $@
    else
        sudo nmap -sS 192.168.1.1/24 -Pn -oN scan.txt --open
        echo
        read -p "Input username: " username
        read -p "Input IP: " ip
        read -s -p "Input password: " password
        read -p "Do you want to save this connection? (y/n) " save
        if [ $save == "y" ]; then
            echo "/u:${username}" >> connections.conf
            echo "/v:${ip}" >> connections.conf
            echo "/p:${password}" >> connections.conf
            
            echo "Loading xfreerdp server..."
            sleep 1
            xfreerdp /u:"${username}" /v:"${ip}" /p:"${password}"

        else
            # Put the
            echo
            echo "Loading xfreerdp server..."
            sleep 1
            xfreerdp /u:"${username}" /v:"${ip}" /p:"${password}"
            exit
        fi
    fi
}
ConnectXfreerdp