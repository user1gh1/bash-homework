#!/bin/bash

function tree() {
	#start tree location if $1 = path /home/.../.../example 
	local tabb="${2:-|_}"
	local tabbb="_"
    if [ $# -eq 0 ]; then
        location="."
    else
        location="$1"
    fi

    for file in "$location"/*; do
        if [ -d "$file" ]; then
            echo -e "$tabb\033[34m $(basename "$file")\033[0m" # color text blue if dir 
			tree "$file" "$tabb$tabbb"

		elif [ "$(basename "$file")" == '*' ]; then #empty dir continue 
            continue        
		elif [ -x "$file" ]; then
            echo -e "$tabb\033[32m $(basename "$file")\033[0m" # color text green if executable file
		elif [ -h "$file" ]; then
            echo -e "$tabb\033[36m$(basename "$file")\033[0m" # color light blue if symbolic link
        else
            echo -e "$tabb $(basename "$file")"  
			
        fi
    done

}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
	#--help
	if [[ $1 == "--help" ]]; then
		echo -e "\nfor example to show tree from Desktop\n ./tree.sh /home/yourusername/Desktop\n"
		echo -e "if run ./tree.sh without argument show tree from ./"
	else 
		tree "$@"
	fi
fi
