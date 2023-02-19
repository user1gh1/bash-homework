#!/bin/bash
function free_mem() {
    memTotal=$(grep MemTotal /proc/meminfo | awk '{print $2}')
    memAvailable=$(grep MemAvailable /proc/meminfo | awk '{print $2}')
    memShared=$(grep Shmem /proc/meminfo | awk '$1=="Shmem:" {print $2}')
    buff=$(grep Buffers /proc/meminfo | awk '{print $2}')
    cache=$(grep Cached /proc/meminfo | awk '$1=="Cached:" {print $2}')
	sReclaimable=$(grep SReclaimable /proc/meminfo | awk '{print $2}')

	buff_cache=$(( $buff + $cache + $sReclaimable ))
    memFree=$( grep MemFree /proc/meminfo | awk '{print $2}' )
	
    memUsed=$(( $memTotal - $memFree - $buff_cache))
	
	swapTotal=$(grep SwapTotal /proc/meminfo | awk '{print $2}')
	swapFree=$(grep SwapFree /proc/meminfo | awk '{print $2}')
	swapUsed=$(( $swapTotal - $swapFree ))

    echo "Mem Total:  $memTotal kB"
    echo "Mem Used:  $memUsed kB"
    echo "Mem Free:  $memFree kB"
    echo "Mem Shared:  $memShared kB"
    echo "Mem buff/cache: $buff_cache kB"
    echo "Mem available: $memAvailable kB"
    echo "Swap Total: $swapTotal kB"
    echo "Swap Used: $swapUsed kB"
    echo "Swap Free: $swapFree kB"
}

free_mem | column -t
