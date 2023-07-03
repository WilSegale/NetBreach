from tqdm import tqdm
from colorama import *
import datetime
import platform
import datetime
import time
import os
import urllib.request
import logging

RED = Fore.RED
current_time = datetime.datetime.now().time()
formatted_time = current_time.strftime("%I:%M:%S %p")
from datetime import datetime

# Get the current date
current_date = datetime.now().strftime("%m/%d/%Y")

# Print the current date

root = 0

def connect(host="https://google.com/"):
    try:
         urllib.request.urlopen(host)
         return True
    except:
         return False

if connect():
    if platform.system() == "Darwin":
        if os.geteuid() == root:
            for i in tqdm(range(0, 100), ascii=False, colour="green", desc="Loading Hercules"):
                time.sleep(0.1)
                pass
            os.system("bash script.sh")
        else:
            logging.error(f"{formatted_time} Please run as root. DATE:{current_date}")
    else:
        logging.warning(f"{formatted_time} Wrong OS. Please use the correct OS. DATE:{current_date}")
else:
    logging.error(f"{formatted_time} You are offline. Please connect to the internet. DATE:{current_date}")
