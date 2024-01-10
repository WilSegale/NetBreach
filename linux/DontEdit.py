# Import necessary modules
import datetime
import platform
import time
import os
import urllib.request
import logging
import sys
import subprocess
import requests

lineArt = subprocess.run

#name of the os
OS = "Linux"

# Define color codes for console output
BRIGHT = '\033[1m'
GREEN = "\033[92m"
RED = "\033[91m"
RESET = "\033[0m"

# Define constants for command-line arguments
HELP = ["--HELP", "--Help", "--help", "-h", "-H"]
GUI = ["--GUI", "--Gui", "--gui"]
GLOBAL = ["--GLOBAL", "--Global", "--global"]
LOCAL = ["--LOCAL", "--Local", "--local"]
GuiLocal = ["--GUI-LOCAL", "--Gui-local", "--gui-local"]
installRequirement = ["--INSTALL", "--install"]
uninstallRequirement = ["--UNINSTALL", "--uninstall"]