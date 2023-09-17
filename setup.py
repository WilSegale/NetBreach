from sys import *
from colorama import *
import logging
import datetime
import os

current_time = datetime.datetime.now().time()

# Format the time with AM/PM
formatted_time = current_time.strftime("%H:%M:%S %p")
logging.basicConfig(filename='ERROR.LOG', level=logging.INFO)

GREEN = Fore.GREEN
RED = Fore.RED

RESET = Fore.RESET
BRIGHT = Fore.BRIGHT

if platform == "linux" or platform == "linux2":
    os.system("sudo rm -rf mac")
    os.system("sudo rm -rf setup.py")
    print(f"{GREEN}[+] Done{RESET}")

elif platform == "darwin":
    os.system("sudo rm -rf linux")
    os.system("sudo rm -rf setup.py")
    print(f"{GREEN}[+] Done{RESET}")

else:
    logging.error(f'{formatted_time} Your system is not supported.')
    print(f'{BRIGHT}{RED}[-]Your system is not supported{RESET}')
