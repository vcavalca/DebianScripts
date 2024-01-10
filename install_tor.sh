#!/bin/bash

# Script: install_tor.sh
# Description: Installs the Tor Browser on Debian.

# Function to wait for user input.
press_enter_to_continue() {
    echo "Press Enter to continue..."
    read -r
}

# Function to clear the screen with a 3-second pause.
clear_screen() {
    sleep 3
    clear
}

# Function to display a colored message based on success or failure.
display_message() {
    if [ "$1" -eq 0 ]; then
        sleep 1
        echo -e "\e[32m$2\e[0m"  # Success message in green
    else
        sleep 1
        echo -e "\e[31m$3\e[0m"  # Failure message in red
        exit 1
    fi
}

# Update package list.
echo "Updating the package list..."
sleep 1
sudo apt update
display_message $? "Updated successfully" "Failed to update the package list. Exiting..."

# Install Tor Browser.
echo "Installing Tor Browser..."
sleep 1
sudo apt install -y tor torbrowser-launcher
display_message $? "Installed successfully" "Failed to install. Exiting..."

# Display a message indicating successful installation.
clear_screen
echo -e "\e[32mTor Browser installation complete.\e[0m"  # Success message in green
press_enter_to_continue
