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

# Function to display a colored message based on success or failure.
display_message() {
    if [ "$1" -eq 0 ]; then
        echo -e "\e[32m$2\e[0m"  # Success message in green
    else
        echo -e "\e[31m$3\e[0m"  # Failure message in red
        exit 1
    fi
}

# Check if sudo is installed.
if ! command -v sudo &> /dev/null; then
    clear_screen
    echo "The 'sudo' package is not installed. Installing..."
    press_enter_to_continue
    su -c "apt update && apt install -y sudo && usermod -aG sudo $(whoami)"
    clear_screen
    echo "It will be necessary to reboot the system to apply the group changes."
    press_enter_to_continue
    echo "Please re-run the script after restarting to apply the group changes."
    press_enter_to_continue
    exit 0
fi

# Check if curl is installed.
if ! command -v curl &> /dev/null; then
    clear_screen
    echo "The 'curl' package is not installed. Installing..."
    press_enter_to_continue
    sudo apt install -y curl
    display_message $? "Successfully installed" "Failed to install 'curl'. Exiting..."
fi

# Ensure the script is being run as sudoer.
if [ "$(id -u)" != "0" ]; then
    clear_screen
    echo "This script must be run as a superuser. Use 'sudo ./install_brave.sh'" 1>&2
    press_enter_to_continue
    exit 1
fi

# Download and add the Brave Browser keyring.
clear_screen
echo "Downloading and adding Brave Browser keyring..."
press_enter_to_continue
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
display_message $? "Successfully installed" "Failed to download and add Brave Browser keyring. Exiting..."

# Add Brave Browser repository.
clear_screen
echo "Adding Brave Browser repository..."
press_enter_to_continue
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
display_message $? "Successfully installed" "Failed to add Brave Browser repository. Exiting..."

# Update package list.
clear_screen
echo "Updating the package list..."
press_enter_to_continue
sudo apt update
display_message $? "Successfully installed" "Failed to update the package list. Exiting..."

# Install Brave Browser.
clear_screen
echo "Installing Brave Browser..."
press_enter_to_continue
sudo apt install -y brave-browser
display_message $? "Successfully installed" "Failed to install Brave Browser. Exiting..."

# Display a message indicating successful installation.
clear_screen
echo -e "\e[32mBrave Browser installation complete.\e[0m"  # Success message in green
press_enter_to_continue
