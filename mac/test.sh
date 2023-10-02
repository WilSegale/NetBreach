#!/bin/bash

# Calculate the width of the text in characters
text="This is some centered text"
text_length="${#text}"

# Calculate the width of the dialog box
dialog_width=40

# Calculate the number of spaces to add before the text to center it
spaces_before=$(( (dialog_width - text_length) / 2 ))

# Create a string of spaces to add before the text
padding=""
for ((i = 0; i < spaces_before; i++)); do
  padding+=" "
done

# Combine the padding and text
centered_text="${padding}${text}"

# Display the centered text in a Zenity dialog
zenity --info --text="$centered_text"

