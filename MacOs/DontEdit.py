# Import necessary modules
from pathlib import Path
import datetime
import os
import platform
import subprocess
import sys
import time
import urllib.request
import socket
import ipaddress
import json
# gets the current time and formats it HH:MM:SS
current_time = datetime.datetime.now().time()

#get the current time and formats it in the 12 hour format
formatted_time = current_time.strftime("%I:%M:%S %p")

# Get the current date
current_date = datetime.datetime.now().strftime("%m/%d/%Y")

# holds the error file to read from
ERROR = open("ERROR.log", "a")

# name of program and software name
ProgramName = "NetBreachX"
SoftwareName = "NetBreachX.py"  

# holds the argument of the --globla function
argument = sys.argv

#terminalcommand for the os.system funciton
terminalCommand = os.system

# easy way to read the root user function
ROOT = 0

# list of the files to remove
RemoveFile = ["ERROR.log","ERROR.LOG"]

#the asscie art var
lineArt = subprocess.run

#name of the os
OS = "Darwin"
name = "Mac"

# Define color codes for console output
BRIGHT = '\033[1m'
GREEN = "\033[92m"
RED = "\033[91m"
BLUE = "\033[34m"
YELLOW = "\033[33m"
ORANGE_Start = "\033[38;2;255;165;0m"
GRAY_TEXT = "\033[90m"
CYAN_TEXT = "\033[36m"
RESET = "\033[0m"


# Define constants for command-line arguments
HELP = {"--HELP", "--Help", "--help", "-h", "-H"}
GUI = {"--GUI", "--Gui", "--gui", "-GU","-Gu"}
GLOBAL = {"--GLOBAL", "--Global", "--global", "-G", "-g"}
LOCAL = {"--LOCAL", "--Local", "--local", "-l", "-L"}
GuiLocal = {"--GUI-LOCAL", "--Gui-local", "--gui-local", "--g-l", "--G-l", "--G-L"}
GlobalManualArgument = {"--MANUAL-GLOBAL", "--Manual-Global", "--manual-global", "--m-g", "--M-g", "--M-G"}
LocalManualArgument = {"--MANUAL-LOCAL", "--Manual-Local", "--manual-local", "--m-l", "--M-l", "--M-L"}
installRequirement = {"--INSTALL", "--install", "--in"}
uninstallRequirement = {"--UNINSTALL", "--uninstall", "--un"}
conenctRDP = {"--xfreerdp", "--XFREERDP", "--XFREE", "--xfree"}
pipForce = {"--pipForce","--pip-force","--PIP-FORCE", "--pipforce"}
autoConnect = {"--autoConnect", "--autoconnect", "--auto", "--AUTO"}
skipGlobal = {"--SKIPGLOBAL", "--skip-Global", "--skip-global", "--Skip-Global", "--Skip-global"}
skipLocal = {"--skip-Local", "--SKIP-LOCAL", "--skip-local", "--Skip-Local", "--Skip-local"}
skipManG = {"--skip-manual-global", "--SKIP-MANUAL-GLOBAL", "--skip-manual-global", "--Skip-Manual-Global", "--Skip-manual-global"}
skipManL = {"--skip-manual-local", "--SKIP-MANUAL-LOCAL", "--skip-manual-local", "--Skip-Manual-Local", "--Skip-manual-local"}
GlobalHelp = {"--GlobalHelp", "--globalHelp", "--GLOBALHELP", "--global-help", "--Global-help", "--GLOBAL-HELP"}
LocalHelp = {"--LocalHelp", "--localHelp", "--LOCALHELP", "--local-help", "--Local-help", "--LOCAL-HELP"}
FIX = {"--FIX", "--fix", "-f", "-F"}


# Define list of scripts to run
GuiScript = ["bash", "GuiGlobal.sh"]
GlobalScript = ["bash", "GlobalScript.sh"]  # runs the script in Global mode
LocalScript = ["bash", "localScript.sh"]  # runs the script in Local mode
GuiLocalScript = ["bash", "GuiLocal.sh"]  # runs the script that uses GUI mode with local mode
GlobalManual = ["bash", "ManualGlobalScript.sh"]
LocalManual = ["bash", "ManualLocalScript.sh"]
RDPconnect = ["bash", "xfreerdp.sh"]