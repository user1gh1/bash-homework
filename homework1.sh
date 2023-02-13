#!/bin/bash
      
echo -e "Currently logged users: $(whoami)\n"

echo -e "Shell directory: $SHELL\n"

echo -e "Home directory: $HOME\n"

echo -e "OS $(lsb_release -d)\n"

echo -e "Current working directory: $(pwd)\n"

echo -e "Number of users logged in: $(who | wc -l)\n"

echo -e "Available shells in system:\n$(cat /etc/shells)\n"

echo -e "Hard disk information:\n $(df -h) \n"

echo -e "CPU information:\n$(lscpu | grep -v 'Flags' | grep -v 'Vulnerability')\n"

echo -e "Memory information:\n$(free -h)\n"

echo -e "File system information:\n$(lsblk | grep "sd")"

echo -e "\nCurrently running processes:"
ps -a

