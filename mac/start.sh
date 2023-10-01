start(){
  selected_items=$(zenity --list --text "Select Version" --column "Items" \
    "Gui with temrinal(1)" \
    "Terminal only(2)")
  # Check if the selected item contains "22"
  
  if [[ "${selected_items}" == *"1"* ]]; then
    echo "${selected_items}"

  elif [[ "${selected_items}" == *"2"* ]]; then
    sudo bash script.sh
  fi
  }
start