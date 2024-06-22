# Import necessary modules
from pathlib import Path
import datetime
import os
import platform
import subprocess
import sys
import time
import urllib.request

# gets the CLI arguments like --global etc
argument = sys.argv

# var for the os.sysetm command
terminalCommand = os.system

# easy way to read the root user function
ROOT = 0

# list of the files to remove
RemoveFile = ["ERROR.log","ERROR.LOG"]

#the asscie art var
lineArt = subprocess.run

#name of the os
OS = "Linux"

name = "Linux"

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
HELP = ["--HELP", "--Help", "--help", "-h", "-H"]
GUI = ["--GUI", "--Gui", "--gui"]
GLOBAL = ["--GLOBAL", "--Global", "--global"]
LOCAL = ["--LOCAL", "--Local", "--local"]
GuiLocal = ["--GUI-LOCAL", "--Gui-local", "--gui-local"]
GlobalManualArgument = ["--MANUAL-GLOBAL", "--Manual-Global", "--manual-global"]
LocalManualArgument = ["--MANUAL-LOCAL", "--Manual-Local", "--manual-local"]
installRequirement = ["--INSTALL", "--install"]
uninstallRequirement = ["--UNINSTALL", "--uninstall"]
listPackages = ["--Installed", "--installeds"]
conenctRDP = ["--xfreerdp"]
FIX = ["--FIX", "--fix"]

# Define list of scripts to run
GuiScript = ["bash", "GuiScript.sh"]
GlobalScript = ["bash", "GlobalScript.sh"]  # runs the script in global mode
LocalScript = ["bash", "localScript.sh"]  # runs the script in global mode
GuiLocalScript = ["bash", "GuiLocal.sh"]  # the script to run after loading
GlobalManual = ["bash", "ManualGlobalScript.sh"]
LocalManual = ["bash", "ManualLocalScript.sh"]
RDPconnect = ["bash", "xfreerdp.sh"]
packages = ["bash", "InstalledPackages"]