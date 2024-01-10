#!/bin/bash

# Script: install_sudo.sh
# Description: Installs the Sudo Package and configure on Debian.

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
                su -c "apt update && apt install -y sudo && usermod -aG sudo $(whoami)"
                display_message 0 "Installed successfully" "Failed to install '$package_name'. Exiting..."
            else
                echo -e "\e[31mExiting the script.\e[0m"
                exit 1
           fi
        fi
    fi
}

# Check if sudo is installed.
if ! command -v sudo &> /dev/null; then
    install_package_if_not_installed "sudo"
    clear_screen
    echo "Rebooting the system is recommended to apply the group changes."
    sleep 1
    echo -e "\e[32mScript completed successfully.\e[0m"
    press_enter_to_continue
    exit 1
fi
