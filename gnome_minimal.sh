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

# Check if sudo is installed.
if ! command -v sudo &> /dev/null; then
    clear_screen
    echo "The 'sudo' package is not installed. Installing..."
    press_enter_to_continue
    su -c "apt update && apt install -y sudo && usermod -aG sudo $(whoami)"
    echo "It will be necessary to reboot the system to apply the group changes.".
    press_enter_to_continue
    echo "Please re-run the script after logging out and logging back in to apply group changes."
    press_enter_to_continue
    reboot
fi

# Ensure the script is being run as sudoer.
if [ "$(id -u)" != "0" ]; then
    clear_screen
    echo "This script must be run as a superuser. Use 'sudo ./gnome_minimal.sh'" 1>&2
    press_enter_to_continue
    exit 1
fi

# Display a message indicating that the system is being updated.
clear_screen
echo "Updating the package list and upgrading existing packages..."
press_enter_to_continue
# Update the package list and upgrade existing packages.
sudo apt update && sudo apt upgrade -y

# Display a message indicating that gnome-session is being installed.
clear_screen
echo "Installing the GNOME desktop environment..."
press_enter_to_continue
# Install the gnome-session package.
sudo apt install -y gnome-session

# Display a menu for additional packages.
clear_screen
echo "Do you want to install additional components?"
press_enter_to_continue
select yn in "Yes" "No"; do
    case $yn in
        Yes )
            # Install additional packages.
            sudo apt install -y nautilus gnome-terminal
            break;;
        No )
            echo "No additional components will be installed."
            press_enter_to_continue
            break;;
    esac
done

# Display a message indicating successful installation.
clear_screen
echo "GNOME minimal installation complete."
press_enter_to_continue
