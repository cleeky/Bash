#!/bin/sh

# Check if the screen command is installed
if ! [ -x "$(command -v screen)" ]; then
  echo 'Error: screen is not installed.' >&2
  exit 1
fi

menu() {
    # Display menu options
    echo "Screen Control Menu:"
    echo "1. Create Screen Session
    case $selection in
        1)
            # Prompt the user to make a selection
            read -p "Enter your selection: " selection
            SessionExists(selection)
            ;;
        2)
            # Perform action for option 2
            ;;
        3)
            # Perform action for option 3
            ;;
        4)
            # Quit the program
            exit 0
            ;;
        *)
            # Invalid selection
            echo "Invalid selection"
            menu
            ;;
    esac
}

SessionExists() {
    if screen -ls ~= '%1' 
}



# Create a new screen session
screen -S session_name

# Detach from the current screen session
screen -d

# List all available screen sessions
screen -ls

# Attach to an existing screen session
screen -r session_name

# Kill a screen session
screen -X -S session_name quit
