#!/bin/bash

# Set the desired length of the random string
read -p "Input the length of the random string of numbers and letters: " length
read -p "Input the file you want to shread: " filename
# Generate a random string of alphanumeric characters
random_string=$(openssl rand -base64 225 | tr -dc 'a-zA-Z0-9' | head -c "$length")

echo "Random string: $random_string"
