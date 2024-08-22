#!/bin/bash

# Define the remote server details
cd ~/Desktop
ls
read -p "Remote username: " remote_user
read -p "Remote Server Address: " remote_server
read -p "Destination: " remote_path

# List of files to send
read -ep "Input the File: " files_to_send

# Loop through the files and send them
for file in "${files_to_send[@]}"; do
    scp -r "${file}" "${remote_user}@${remote_server}:${remote_path}"
done

echo "[+] All files sent successfully!"
