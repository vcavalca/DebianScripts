#!/bin/bash

# Script: gnome_minimal.sh
# Description: Installs the minimal GNOME desktop environment on Debian.

# Check if sudo is installed.
if ! command -v sudo &> /dev/null; then
    echo "The 'sudo' package is not installed. Installing..."
    su -c "apt update && apt install -y sudo && usermod -aG sudo $(whoami)"
    echo "Please re-run the script after logging out and logging back in to apply group changes."
    exit 0
fi

# Ensure the script is being run as sudoer.
if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as sudoer. Use 'sudo ./gnome_minimal.sh'" 1>&2
    exit 1
fi

# Display a message indicating that the system is being updated.
echo "Updating the package list and upgrading existing packages..."
# Update the package list and upgrade existing packages.
sudo apt update && sudo apt upgrade -y

# Display a message indicating that gnome-session is being installed.
echo "Installing gnome-session..."
# Install the gnome-session package.
sudo apt install -y gnome-session

# Display a menu for additional packages.
echo "Do you want to install additional packages?"
select yn in "Yes" "No"; do
    case $yn in
        Yes )
            # Install additional packages.
            sudo apt install -y nautilus gnome-terminal
            break;;
        No )
            echo "No additional packages will be installed."
            break;;
    esac
done

# Display a message indicating successful installation.
echo "GNOME minimal installation complete."
