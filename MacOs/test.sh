read -p "input hostname: " hostname=
read -p "input ip address: " ip

xfreerdp /v:$ip /u:Administrator /f /cert-ignore /audio /video /drive /printer /smartcard /clipboard /microphone /cam /webcam /portable-collection:auto /T:"$hostname" &