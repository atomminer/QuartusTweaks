#!/usr/bin/env bash
#title           :usbblaster.sh
#description     :This script will add Quartus folder to environment PATH and create udev rules for Altera USB Blaster.
#author          :www.atomminer.com
#version         :0.1

# kill jtagd
echo "Stopping JTAG daemon..."
killall jtagd

# add Quartus bin folder to PATH
echo "Addind Quartus to environment PATH..."
if [ -d "$HOME/altera_lite/15.0/quartus/bin" ] ; then
    echo "   Using Quartus 15.0"
    echo "PATH=\"$PATH:$HOME/altera_lite/15.0/quartus/bin\"" >> ~/.bashrc
    PATH="$PATH:$HOME/altera_lite/15.0/quartus/bin"
fi
if [ -d "$HOME/altera_lite/15.1/quartus/bin" ] ; then
    echo "   Using Quartus 15.1"
    echo "PATH=\"$PATH:$HOME/altera_lite/15.1/quartus/bin\"" >> ~/.bashrc
    PATH="$PATH:$HOME/altera_lite/15.1/quartus/bin"
fi
if [ -d "$HOME/altera_lite/16.0/quartus/bin" ] ; then
    echo "   Using Quartus 16.0"
    echo "PATH=\"$PATH:$HOME/altera_lite/16.0/quartus/bin\"" >> ~/.bashrc
    PATH="$PATH:$HOME/altera_lite/16.0/quartus/bin"
fi
if [ -d "$HOME/altera_lite/16.1/quartus/bin" ] ; then
    echo "   Using Quartus 16.1"
    echo "PATH=\"$PATH:$HOME/altera_lite/16.1/quartus/bin\"" >> ~/.bashrc
    PATH="$PATH:$HOME/altera_lite/16.1/quartus/bin"
fi
if [ -d "$HOME/altera_lite/17.0/quartus/bin" ] ; then
    echo "   Using Quartus 17.0"
    echo "PATH=\"$PATH:$HOME/altera_lite/17.0/quartus/bin\"" >> ~/.bashrc
    PATH="$PATH:$HOME/altera_lite/17.0/quartus/bin"
fi

source ~/.bashrc

# libudev was not found on my machine at suggested path. 
# Find it on your machine with "sudo find / -name libudev*"
echo "Ensuring libudev is found"
sudo ln -s /lib/x86_64-linux-gnu/libudev.so.1 /lib/x86_64-linux-gnu/libudev.so.0

# add USB Blaster rules to udev
echo "Setting up USB Blaster rules..."
sudo touch /etc/udev/rules.d/51-usbblaster.rules
echo "SUBSYSTEM==\"usb\", ATTR{idVendor}==\"09fb\", ATTR{idProduct}==\"6001\", MODE=\"0666\"" | sudo tee /etc/udev/rules.d/51-usbblaster.rules -a
echo "SUBSYSTEM==\"usb\", ATTR{idVendor}==\"09fb\", ATTR{idProduct}==\"6002\", MODE=\"0666\"" | sudo tee /etc/udev/rules.d/51-usbblaster.rules -a
echo "SUBSYSTEM==\"usb\", ATTR{idVendor}==\"09fb\", ATTR{idProduct}==\"6003\", MODE=\"0666\"" | sudo tee /etc/udev/rules.d/51-usbblaster.rules -a
echo "SUBSYSTEM==\"usb\", ATTR{idVendor}==\"09fb\", ATTR{idProduct}==\"6010\", MODE=\"0666\"" | sudo tee /etc/udev/rules.d/51-usbblaster.rules -a
echo "SUBSYSTEM==\"usb\", ATTR{idVendor}==\"09fb\", ATTR{idProduct}==\"6810\", MODE=\"0666\"" | sudo tee /etc/udev/rules.d/51-usbblaster.rules -a

echo "Reloading libudev rules..."
sudo udevadm control --reload

echo "Quartus Prime Lite should be all set. Script created by http://www.atomminer.com"
echo "Test functionality by running jtagd then jtagconfig"
echo "Script modified by tumbleshack@github."

