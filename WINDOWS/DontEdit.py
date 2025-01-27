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