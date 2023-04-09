from asyncio import format_helpers
from tqdm import tqdm
from sys import platform
import time
import os
import urllib.request

root = 0;
def connect(host="https://google.com/"):
	try:
		urllib.request.urlopen(host)
		return True
	except:
		return False
	
if connect() == True:
	if platform == "darwin":
		if os.geteuid() == root:
			for i in tqdm (range (0,100),ascii=False,  colour="green", desc="Loading Hercules"):
				time.sleep(0.1)
				pass
			os.system(f"bash .script.sh")
		else:
			print(f"Please run as root.")
	else:
		print(f"Wrong OS please use the correct OS.")
else:
	print(f"You are offline please connect to the internet.")