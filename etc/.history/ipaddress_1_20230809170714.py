import socket
import os
import uuid

os.system('clear') 
hostname = socket.gethostname()
IPAddr = socket.gethostbyname(hostname)   
print("Your Computer Name is:" + hostname)   
print("Your Computer IP Address is: " + IPAddr) 
print("Your MAC address is: " + hex(uuid.getnode()))
