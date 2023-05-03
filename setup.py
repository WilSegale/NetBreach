from sys import *
from colorama import *
import os

GREEN = Fore.GREEN
RED = Fore.RED
RESET = Fore.RESET

if platform == "linux" or platform == "linux2":
    os.system("sudo rm -rf mac")
    os.system("sudo rm -rf setup.py")
    print(f"{GREEN}Done{RESET}")

elif platform == "darwin":
    os.system("sudo rm -rf linux")
    os.system("sudo rm -rf setup.py")
    print(f"{GREEN}Done{RESET}")

else:
    print(f'{RED}Your system is not supported{RESET}')