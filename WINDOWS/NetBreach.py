import os
import sys
import logging
import socket
import platform
from paramiko import SSHClient, AutoAddPolicy
import re

# Constants
LOG_FILE = "netbreach.log"
TIMEOUT = 5

# Setup logging
logging.basicConfig(filename=LOG_FILE, level=logging.INFO, format="%(asctime)s - %(message)s")

# Validate subnet input
def validate_subnet(subnet):
    pattern = r"^\d{1,3}\.\d{1,3}\.\d{1,3}$"
    return re.match(pattern, subnet)

def get_valid_subnet():
    while True:
        subnet = input("Enter subnet (e.g., 192.168.1): ")
        if validate_subnet(subnet):
            return subnet
        else:
            print("Invalid subnet format. Please try again.")

# Scan for active hosts
def network_scan(subnet):
    active_hosts = []
    for i in range(1, 255):
        ip = f"{subnet}.{i}"
        try:
            with socket.create_connection((ip, 22), timeout=TIMEOUT):
                active_hosts.append(ip)
        except (socket.error, socket.timeout):
            pass
    if not active_hosts:
        print("No active hosts found.")
    return active_hosts

# Connect to SSH
def ssh_connect(host, username, password):
    try:
        client = SSHClient()
        client.set_missing_host_key_policy(AutoAddPolicy())
        client.connect(host, username=username, password=password)
        logging.info(f"Connected to {host}")
        print(f"Connected to {host}")
        return client
    except Exception as e:
        logging.error(f"Failed to connect to {host}: {e}")
        print(f"Failed to connect to {host}: {e}")
        return None

# Disconnect from SSH
def ssh_disconnect(client):
    try:
        client.close()
        logging.info("SSH session closed.")
        print("SSH session closed.")
    except Exception as e:
        logging.error(f"Error disconnecting: {e}")

# Check for weak passwords
def check_weak_passwords(host, username, password_list):
    for password in password_list:
        client = ssh_connect(host, username, password)
        if client:
            print(f"Success! {host} - {username}:{password}")
            ssh_disconnect(client)
            return
    print(f"No weak passwords found for {host}.")

# Terminate SSH session
def terminate_ssh_session(ip):
    try:
        if platform.system() == "Windows":
            os.system(f"taskkill /F /FI \"WINDOWTITLE eq {ip}\"")
        else:
            os.system(f"pkill -f {ip}")
        logging.info(f"Terminated SSH session for {ip}.")
        print(f"Terminated SSH session for {ip}.")
    except Exception as e:
        logging.error(f"Failed to terminate session for {ip}: {e}")
        print(f"Failed to terminate session for {ip}: {e}")

# Main menu
def main():
    try:
        while True:
            print("\nNetBreach - Network Security Tool")
            print("1. Scan Network")
            print("2. Manage SSH Sessions")
            print("3. Check for Weak Passwords")
            print("4. Terminate SSH Session")
            print("5. Exit")
            
            choice = input("Enter your choice: ")
            
            if choice == "1":
                subnet = input("Enter subnet to scan (e.g., 192.168.1): ")
                print("Scanning network...")
                active_hosts = network_scan(subnet)
                print(f"Active hosts found: {active_hosts}")
            elif choice == "2":
                host = input("Enter SSH host: ")
                username = input("Enter username: ")
                password = input("Enter password: ")
                client = ssh_connect(host, username, password)
                if client:
                    ssh_disconnect(client)
            elif choice == "3":
                host = input("Enter SSH host: ")
                username = input("Enter username: ")
                passwords = ["admin", "password", "123456"]
                check_weak_passwords(host, username, passwords)
            elif choice == "4":
                ip = input("Enter IP of session to terminate: ")
                terminate_ssh_session(ip)
            elif choice == "5":
                print("Exiting NetBreach.")
                sys.exit()
            else:
                print("Invalid choice.")
    except KeyboardInterrupt:
        print("\nExiting NetBreach.")
        sys.exit()

if __name__ == "__main__":
    main()