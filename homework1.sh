#!/bin/bash
function current_user {     
echo -e "Currently logged users: $(whoami)\n"
}
function shell_dir {
echo -e "Shell directory: $SHELL\n"
}
function home_dir {
echo -e "Home directory: $HOME\n"
}
function os {
echo -e "OS $(lsb_release -d)\n"
}
function current_pwd {
echo -e "Current working directory: $(pwd)\n"
}
function num_logged_users {
echo -e "Number of users logged in: $(who | wc -l)\n"
}
function avail_shells {
echo -e "Available shells in system:\n$(cat /etc/shells)\n"
}
function hard_disk {
echo -e "Hard disk information:\n $(df -h) \n"
}
function cpu_info {
echo -e "CPU info:\n$(lscpu | grep -v 'Flags' | grep -v 'Vulnerability')\n"
}
function memory_info {
echo -e "Memory information:\n$(free -h)\n"
}
function file_sys_info {
echo -e "File system information:\n$(lsblk | grep "sd")"
}
function current_run_procs {
echo -e "\nCurrently running processes:"
ps -a
}

function main {
	current_user
	shell_dir
	home_dir
	os
	current_pwd
	num_logged_users
	avail_shells
	hard_disk
	cpu_info
	memory_info
	file_sys_info
	current_run_procs
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi

