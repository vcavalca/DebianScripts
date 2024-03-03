#!/bin/bash

# Script: gnome_minimal.sh
# Description: Installs the minimal GNOME desktop environment on Debian.

# Function to wait for user input.
press_enter_to_continue() {
    echo "Press Enter to continue..."
    read -r
}

# Function to clear the screen.
clear_screen() {
    sleep 3
    clear
}

# Display a message indicating that the system is being updated.
clear_screen
echo "Updating the package list and upgrading existing packages..."
sleep 1
# Update the package list and upgrade existing packages.
sudo apt update && sudo apt upgrade -y

# Display a message indicating that gnome-session is being installed.
clear_screen
echo "Installing the GNOME desktop environment..."
sleep 1
# Install the gnome-session package.
sudo apt install -y gnome-session nautilus gnome-terminal

# Display a message indicating successful installation.
clear_screen
echo "GNOME minimal installation complete."
press_enter_to_continue
