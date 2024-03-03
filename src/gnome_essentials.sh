#!/usr/bin/env bash

# Install packages after installing base Debian with no GUI and Gnome Minimal

# Update and Upgrade System
sudo apt update && sudo apt upgrade -y

# Extension Manager Gnome
sudo apt install gnome-shell-extension-manager -y

# Gnome Tweaks
sudo apt install gnome-tweaks -y

# Gnome Disks
sudo apt install gnome-disk-utility -y

# Text Editor
sudo apt install gnome-text-editor -y
