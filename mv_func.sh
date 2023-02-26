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
    #check file exist 
    if [ ! -e "$file" ]; then
    echo "Error: source file $file does not exist"
    exit 1
    fi
    #check if we copy paste in same path give error and exit
    if [ "$(basename "$(dirname "$file")")" = "$(basename "$copy")" ]; then
        echo "Error: source path and destination path are in the same directory" 
        exit 2
    fi
    #if dir (cp dir recursive, all permissions are saves)
    if [ -d "$file" ]; then
        cp -al $file $copy
            if [ $? -eq 0 ]; then
            delete_dir
            fi
    else #if file (hardlink)
        ln $file $copy
            if [ $? -eq 0 ]; then
            delete_file
            fi
    fi
}

function delete_file {
rm $file
}

function delete_dir {
rm -r $file
}

function main {
read_file
paste_file
hard_link_copy
exit 0
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then

