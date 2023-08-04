#!/bin/bash
function ShreadFile() {
   # Set the desired length of the random string
   read -p "Input the length of the random string of numbers and letters: " length

   # tells the program about the folder they want to encrypt
   read -p "Input the file you want to shread: " filename

   # Generate a random string of alphanumeric characters
   random_string=$(openssl rand -base64 225 | tr -dc 'a-zA-Z0-9' | head -c "$length")

   # tells the program to generate a random string of alphanumeric characters
   echo "${random_string}" > "${filename}"
}
function ShreadFolder() {

   
}