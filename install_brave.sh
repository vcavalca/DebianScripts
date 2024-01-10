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

# Function to install package if not already installed.
install_package_if_not_installed() {
    package_name=$1
    package_command=$2
    clear_screen
    echo "The '$package_name' package is not installed. Do you want to install it? (Y/n)"
    read -r choice
    if [ "$choice" = "Y" ] || [ "$choice" = "y" ] || [ -z "$choice" ]; then
        if [ "$package_name" = "sudo" ]; then
            echo "To install the 'sudo' package you will need root access"
            sleep 1
            echo "Note: To install 'sudo' package, it is necessary to restart your system after installation."
            sleep 1
            echo "Do you want to continue with the script? (Y/n)"
            read -r continue_choice
            if [ "$continue_choice" = "Y" ] || [ "$continue_choice" = "y" ]; then
                $package_command
                display_message 0 "Installed successfully" "Failed to install '$package_name'. Exiting..."
            else
                echo "Exiting the script."
                exit 1
            fi
        else
            $package_command
            display_message 0 "Installed successfully" "Failed to install '$package_name'. Exiting..."
        fi
    else
        display_message 1 "Failed to install '$package_name'. Exiting..." "Failed to install '$package_name'. Exiting..."
    fi
}

# Check if sudo is installed.
if ! command -v sudo &> /dev/null; then
    install_package_if_not_installed "sudo" "su -c 'apt update && apt install -y sudo && usermod -aG sudo $(whoami)'"
    clear_screen
    echo "Rebooting the system is recommended to apply the group changes."
    sleep 1
    echo "Please re-run the script after restarting to apply the group changes."
    press_enter_to_continue
    reboot
    exit 0
fi

# Check if curl is installed.
if ! command -v curl &> /dev/null; then
    install_package_if_not_installed "curl" "sudo apt install -y curl"
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
