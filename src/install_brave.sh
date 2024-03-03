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
        sleep 1
        echo -e "\e[32m$2\e[0m"  # Success message in green
    else
        sleep 1
        echo -e "\e[31m$3\e[0m"  # Failure message in red
        exit 1
    fi
}

# Check if curl is installed.
if ! command -v curl &> /dev/null; then
    clear_screen
    echo "Installing the curl package..."
    sleep 1
    sudo apt install -y curl
    display_message $? "Installed successfully" "Failed to install curl. Exiting..."
fi

# Download and add the Brave Browser keyring.
clear_screen
echo "Downloading and adding Brave Browser keyring..."
sleep 1
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
display_message $? "Added successfully" "Failed to download and add Brave Browser keyring. Exiting..."

# Add Brave Browser repository.
echo "Adding Brave Browser repository..."
sleep 1
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
display_message $? "Added successfully" "Failed to add Brave Browser repository. Exiting..."

# Update package list.
echo "Updating the package list..."
sleep 1
sudo apt update
display_message $? "Updated successfully" "Failed to update the package list. Exiting..."

# Install Brave Browser.
echo "Installing Brave Browser..."
sleep 1
sudo apt install -y brave-browser
display_message $? "Installed successfully" "Failed to install Brave Browser. Exiting..."

# Display a message indicating successful installation.
clear_screen
echo -e "\e[32mBrave Browser installation complete.\e[0m"  # Success message in green
sleep 1
echo -e "\e[32mScript completed successfully.\e[0m"
press_enter_to_continue
