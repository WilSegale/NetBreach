#!/bin/bash

# Decrypt a file
decrypt_file() {
    input_file="$1"
    output_file="$2"
    password="$3"

    openssl enc -d -aes-256-cbc -in "$input_file" -out "$output_file" -pass pass:"$password"
}

# Usage example
input_file="encrypted.enc"
output_file="decrypted.txt"
read -p "Input the password: " password

decrypt_file "$input_file" "$output_file" "$password"
echo "File decrypted to $output_file"
