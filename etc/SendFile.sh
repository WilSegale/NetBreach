#!/bin/bash

# Define the remote server details
ls
read -p "Remote Server: " remote_user
read -p "remote_server_address" remote_server

remote_path="~/destination_folder/"

# List of files to send
files_to_send=("file1.txt" "file2.txt" "file3.txt")

# Loop through the files and send them
for file in "${files_to_send[@]}"; do
    scp "$file" "${remote_user}@${remote_server}:${remote_path}"
done

echo "Files sent successfully!"

