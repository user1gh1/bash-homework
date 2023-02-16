#!/bin/bash

function tree() {
	#start tree location if $1 = path /home/.../.../example 
    if [ $# -eq 0 ]; then
        location="."
    else
        location="$1"
    fi

    for file in "$location"/*; do
        if [ -d "$file" ]; then
            echo -e "\033[34m $(basename "$file")\033[0m" # color text blue 
            tree "$file" 
        else
            echo -e "\033[32m $(basename "$file")\033[0m" # color text green 
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
