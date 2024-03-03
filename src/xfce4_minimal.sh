#!/bin/bash

# Script: xfce4_minimal.sh
# Description: Installs the minimal XFCE4 desktop environment on Debian.

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

# Display a message indicating that the system is being updated.
clear_screen
echo "Updating the package list and upgrading existing packages..."
sleep 1
# Update the package list and upgrade existing packages.
sudo apt update && sudo apt upgrade -y

# Display a message indicating that XFCE4 is being installed.
clear_screen
echo "Installing the XFCE4 desktop environment..."
sleep 1
# Install the XFCE4 packages.
sudo apt install -y libxfce4ui-utils thunar xfce4-appfinder xfce4-panel xfce4-session xfce4-settings xfce4-terminal xfconf xfdesktop4 xfwm4

# Display a message indicating successful installation.
clear_screen
echo "XFCE4 minimal installation complete."
press_enter_to_continue
