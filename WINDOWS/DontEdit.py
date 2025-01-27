import os
import sys
import logging
import socket
import platform
import asyncio
from paramiko import SSHClient, AutoAddPolicy
from concurrent.futures import ThreadPoolExecutor, as_completed
from aiohttp import ClientSession, ClientTimeout
import re


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
