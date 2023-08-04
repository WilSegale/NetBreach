#!/bin/bash

# Set the desired length of the random string
read -p "Input the length of the random string of numbers and letters: " length

# Generate a random string of alphanumeric characters
random_string=$(openssl rand -base64  | tr -dc 'a-zA-Z0-9' | head -c "$length")

echo "Random string: $random_string"
