import socket
import os
import uuid

def get_mac_address():
    try:
        mac = uuid.UUID(int=uuid.getnode()).hex[-12:]
        mac_address = ':'.join(mac[i:i+2] for i in range(0, 12, 2))
        return mac_address
    except Exception as e:
        return str(e)

os.system('clear')
hostname = socket.gethostname()
IPAddr = socket.gethostbyname(hostname)
mac_address = get_mac_address()

print("Your Computer Name is: " + hostname)
print("Your Computer IP Address is: " + IPAddr)
print("Your MAC address is: " + mac_address)
