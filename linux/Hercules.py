from asyncio import *
from colorama import *
from tqdm import tqdm
from sys import platform
import time
import os
import urllib.request
import logging

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
	if platform == "linux":
		if os.geteuid() == root:
			for i in tqdm (range (0,100),ascii=False,  colour="green", desc="Loading Hercules"):
				time.sleep(0.1)
				pass
			os.system(f"bash .script.sh")
		else:
			logging.error('Please run as root.')
			print(f"{RED}Please run as root.")
	else:
		logging.warn('Wrong OS please use the correct OS.')
		print(f"{RED}Wrong OS please use the correct OS.")
else:
	logging.error('You are offline please connect to the internet.')
	print(f"{RED}You are offline please connect to the internet.")