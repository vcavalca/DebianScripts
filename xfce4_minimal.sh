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

# Check if sudo is installed.
if ! command -v sudo &> /dev/null; then
    clear_screen
    echo "The 'sudo' package is not installed. Installing..."
    press_enter_to_continue
    su -c "apt update && apt install -y sudo && usermod -aG sudo $(whoami)"
    echo "It will be necessary to reboot the system to apply the group changes."
    press_enter_to_continue
    echo "Please re-run the script after logging out and logging back in to apply group changes."
    press_enter_to_continue
    reboot
fi

# Ensure the script is being run as sudoer.
if [ "$(id -u)" != "0" ]; then
    clear_screen
    echo "This script must be run as a superuser. Use 'sudo ./xfce4_minimal.sh'" 1>&2
    press_enter_to_continue
    exit 1
fi

# Display a message indicating that the system is being updated.
clear_screen
echo "Updating the package list and upgrading existing packages..."
press_enter_to_continue
# Update the package list and upgrade existing packages.
sudo apt update && sudo apt upgrade -y

# Display a message indicating that XFCE4 is being installed.
clear_screen
echo "Installing the XFCE4 desktop environment..."
press_enter_to_continue
# Install the XFCE4 packages.
sudo apt install -y libxfce4ui-utils thunar xfce4-appfinder xfce4-panel xfce4-session xfce4-settings xfce4-terminal xfconf xfdesktop4 xfwm4

# Display a message indicating successful installation.
clear_screen
echo "XFCE4 minimal installation complete."
press_enter_to_continue
