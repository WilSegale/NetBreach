from asyncio import *
from colorama import *
from tqdm import tqdm
from sys import platform
import platform
import datetime
import time
import os
import urllib.request
import logging
# Get the current time
current_time = datetime.datetime.now().time()

# Format the time with AM/PM
formatted_time = current_time.strftime("%H:%M:%S %p")
os = platform.system()
# Print the formatted time
logging.basicConfig(filename='ERROR.LOG', level=logging.INFO)
RED = Fore.RED
root = 0;
def connect(host="https://google.com/"):
	try:
		urllib.request.urlopen(host)
		return True
	except:
		return False
	
if connect() == True:
	if platform == "linux" and platform == "linux2":
		if os.geteuid() == root:
			for i in tqdm (range (0,100),ascii=False, colour="green", desc="Loading Hercules"):
				time.sleep(0.1)
				pass
			os.system(f"bash script.sh")
		else:
			logging.error(f'{formatted_time} Please run as root.')
			print(f"{RED}{formatted_time} Please run as root.")
	else:
		logging.warning(f'{formatted_time} Wrong OS please use the correct OS. The OS you are using is {os}')
		print(f"{RED}{formatted_time} Wrong OS please use the correct OS. The OS you are using is {os}")
else:
	logging.error(f'{formatted_time} You are offline please connect to the internet.')
	print(f"{RED}{formatted_time} You are offline please connect to the internet.")