#!/bin/bash

read -p "Do you want to run 

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

   # Set the desired length of the random string
   length=10

   # Generate a random string of alphanumeric characters
   random_string=$(openssl rand -base64 32 | tr -dc 'a-zA-Z0-9' | head -c "$length")

   # Create a folder with the random string as its name
   folder_name="folder_$random_string"

   mkdir "$folder_name"

   echo "Created folder: $folder_name"

}