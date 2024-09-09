#!/usr/bin/env python3
from DontEdit import *
import subprocess
import chardet

# Function to decrypt a file using OpenSSL with a password
try:
    def decrypt_file(input_file, output_file, password):
        """Attempt to decrypt a file using OpenSSL with the given password."""
        try:
            # Run OpenSSL decryption
            result = subprocess.run(
                ['openssl', 'enc', '-d', '-aes-256-cbc', '-in', input_file, '-out', output_file, '-pass', f'pass:{password}'],
                stderr=subprocess.DEVNULL
            )
            return result.returncode == 0
        except subprocess.SubprocessError as e:
            print(f"Error during decryption: {e}")
            return False

    def validate_decryption(output_file):
        """Check if the decrypted file contains valid readable content using chardet."""
        try:
            with open(output_file, 'rb') as f:
                raw_data = f.read()
                result = chardet.detect(raw_data)  # Detect the encoding of the file
                encoding = result['encoding']
                # If the file is detected as text (likely with an encoding like UTF-8)
                return encoding is not None and 'UTF' in encoding.upper()
        except Exception as e:
            print(f"Error during file validation: {e}")
            return False

    def main():
        # Get input from user
        input_file = input("Enter the path to the encrypted file: ")
        output_file = "decrypted.txt"
        password_file = "rockyou.txt"

        # Check if input file and password file exist
        try:
            with open(input_file, 'rb'), open(password_file, 'r', encoding='utf-8'):
                pass
        except FileNotFoundError:
            print(f"Error: {input_file} or {password_file} does not exist.")
            return

        # Read each password from the password file
        with open(password_file, 'r', encoding='utf-8') as file:
            for password in file:
                password = password.strip()
                if decrypt_file(input_file, output_file, password):
                    if validate_decryption(output_file):
                        print(f"File decrypted successfully with password: {RED}{password}{RESET}")
                        with open('password.txt', 'a') as pw_file:
                            pw_file.write(f"Password to {input_file} is: {password}\n")
                        return
                    else:
                        print(f"Incorrect password: {RED}{password}{RESET}")
                else:
                    print(f"Failed to decrypt with password: {RED}{password}{RESET}")

        print(f"Decryption failed. No valid password found in {password_file}")

    if __name__ == "__main__":
        main()
except KeyboardInterrupt:
    print("\nProgram interrupted by user.")