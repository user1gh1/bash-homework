#!/bin/bash

function read_file {
echo -n "Enter the full path to file "
read file
}

function paste_file {
echo -n "Enter the full path to copy "
read copy
}

#create a hard link and after delete original file 
function hard_link_copy {
ln $file $copy
if [ $? -eq 0 ]; then
	delete_file
fi
}

function delete_file {
rm $file
}

function main {
read_file
paste_file
hard_link_copy
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then    
	#--help
    if [[ $1 == "--help" ]]; then
		echo "for example"
		echo -e "first input \n /home/youruser/Desktop/yourfile.txt"
		echo -e "second input \n /home/youruser/Documents/"
	else
        main "$@" 
    fi

fi

