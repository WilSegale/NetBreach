#!/bin/bash
source DontEdit.sh
# Decrypt a file using a password list and verify its integrity
decrypt_file() {
    input_file="$1"
    output_file="$2"
    password="$3"

    # Attempt decryption
    openssl enc -d -aes-256-cbc -in "${input_file}" -out "${output_file}" -pass pass:"${password}" 2>/dev/null
}

# Check if the decrypted file is valid (for text files, check if it's readable text)
validate_decryption() {
    output_file="$1"
    
    # Check if the file contains valid readable content
    if file "${output_file}" | grep -q "text"; then
        return 0
    else
        return 1
    fi
}

input_file="encrypted.enc"
output_file="decrypted.txt"
password_file="rockyou.txt"

# Loop through each password in the password file
while IFS= read -r password; do
    decrypt_file "${input_file}" "${output_file}" "${password}"

    # Validate if the decrypted file is readable
    if validate_decryption "${output_file}"; then
        echo -e "File decrypted successfully with password: ${GREEN}${password}${NC}"
        exit 0
    else
        echo -e "Incorrect password: ${RED}${password}${NC}" >&2
    fi
done < "${password_file}"

echo -e "Decryption failed. No valid password found in ${RED}${password_file}${NC}"
