from sys import platform
import os

if platform == "linux" or platform == "linux2":
    os.system("sudo rm -rf mac")
    os.system("sudo rm -rf setup.py")
    print("Done")

elif platform == "darwin":
    os.system("sudo rm -rf linux")
    os.system("sudo rm -rf setup.py")
    print("Done")
    
else:
    print('Your system is not supported')