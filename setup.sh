#!/bin/bash

sudo apt update -y
sudo apt install apache2 bind9 dnsutils -y

sudo systemctl start apache2
sudo systemctl enable apache2

sudo systemctl start bind9
sudo systemctl enable bind9

echo "Setup Completed"
