#!/bin/bash

start(){
  selected_items=$(zenity --list --text "Select Version" --column "Version" \
    "Gui with temrinal(1)" \
    "Terminal only(2)")
  # Check if the selected item contains "22"
  
  if [[ "${selected_items}" == *"1"* ]]; then
    sudo bash GuiScript.sh

  elif [[ "${selected_items}" == *"2"* ]]; then
    sudo bash GlobalScript.sh
  fi
}
start