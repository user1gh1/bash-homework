#!/bin/bash
function free_func() {
	#Take all Information what we need
    memTotal=$(grep MemTotal /proc/meminfo | awk '{print $2}')
    memAvailable=$(grep MemAvailable /proc/meminfo | awk '{print $2}')
    memShared=$(grep Shmem /proc/meminfo | awk '$1=="Shmem:" {print $2}')
    memFree=$( grep MemFree /proc/meminfo | awk '{print $2}' )

    buff=$(grep Buffers /proc/meminfo | awk '{print $2}')
    cache=$(grep Cached /proc/meminfo | awk '$1=="Cached:" {print $2}')
	sReclaimable=$(grep SReclaimable /proc/meminfo | awk '{print $2}')
	buff_cache=$(( $buff + $cache + $sReclaimable ))

    memUsed=$(( $memTotal - $memFree - $buff_cache))

	swapTotal=$(grep SwapTotal /proc/meminfo | awk '{print $2}')
	swapFree=$(grep SwapFree /proc/meminfo | awk '{print $2}')
	swapUsed=$(( $swapTotal - $swapFree ))
	#This vars need for swap Kb to Mb or Gb then option -h 
	kgbyte="Kb"
	kmbyte="Kb"
	kbbyte="Kb"

	#Convert then option -h
	if [[ $1 == "-h" ]];
	then

	memTotal=$(echo "scale=1; $memTotal / 1048576" | bc)
    memAvailable=$(echo "scale=1; $memAvailable / 1048576" | bc)
    memShared=$(echo "scale=0; $memShared / 1024" | bc)
    memFree=$(echo "scale=1; $memFree / 1048576" | bc)
    memUsed=$(echo "scale=1; $memUsed / 1048576" | bc)
	buff_cache=$(echo "scale=1; $buff_cache / 1048576" | bc)
	swapTotal=$(echo "scale=1; $swapTotal / 1048576" | bc)
    swapFree=$(echo "scale=1; $swapFree / 1048576" | bc)
    swapUsed=$(echo "scale=1; $swapUsed / 1048576" | bc)

	kgbyte="Gi"
	kmbyte="Mi"

	if [[ $swapUsed -le 1024 ]]; then
		kbbyte="B"
	elif [[ $swapUsed -gt 1024 && $swapUsed -lt 1048576 ]]; then
		kbbyte="Mi"
	fi

	fi
	#Print All Info
    echo "Mem Total:  $memTotal $kgbyte"
    echo "Mem Used:  $memUsed $kgbyte"
    echo "Mem Free:  $memFree $kgbyte"
    echo "Mem Shared:  $memShared $kmbyte"
    echo "Mem buff/cache: $buff_cache $kgbyte"
    echo "Mem available: $memAvailable $kgbyte"
    echo "Swap Total: $swapTotal $kgbyte"
    echo "Swap Used: $swapUsed $kbbyte"
    echo "Swap Free: $swapFree $kgbyte"
}
#if __name__ == '__main__'
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    #--help
    if [[ $1 == "--help" ]]; then
        echo -e "\nFor turn on human readable format append option -h\n"
	#checking for valid input
	elif [ "$1" != "-h" ] && [ "$1" ]; then
		echo "invalid option $1"
		exit 1
    else
		free_func "$@" | column -t
    fi
fi

