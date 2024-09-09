#!/bin/bash
ls
# Encrypt a file
encrypt_file() {
    input_file="$1"
    output_file="$2"
    password="$3"

    openssl enc -aes-256-cbc -salt -in "${input_file}" -out "${output_file}" -pass pass:"${password}"
}

# Usage example
read -e -p "Input file name to encrypt: " input_file
output_file="encrypted.enc"
read -sp "Input Password: " password

encrypt_file "${input_file}" "${output_file}" "${password}"
echo "File encrypted to ${output_file}"