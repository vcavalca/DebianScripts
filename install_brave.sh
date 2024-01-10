#!/bin/bash

# Script: install_brave.sh
# Description: Installs the Brave Browser on Debian.

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
    echo "This script must be run as a superuser. Use 'sudo ./install_brave.sh'" 1>&2
    press_enter_to_continue
    exit 1
fi

# Install required packages.
clear_screen
echo "Installing 'curl'..."
press_enter_to_continue
sudo apt install -y curl

# Download and add the Brave Browser keyring.
clear_screen
echo "Downloading and adding Brave Browser keyring..."
press_enter_to_continue
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

# Add Brave Browser repository.
clear_screen
echo "Adding Brave Browser repository..."
press_enter_to_continue
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list

# Update package list.
clear_screen
echo "Updating the package list..."
press_enter_to_continue
sudo apt update

# Install Brave Browser.
clear_screen
echo "Installing Brave Browser..."
press_enter_to_continue
sudo apt install -y brave-browser

# Display a message indicating successful installation.
clear_screen
echo "Brave Browser installation complete."
press_enter_to_continue
