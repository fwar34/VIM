#!/bin/bash
# https://www.cnblogs.com/klb561/articles/9080151.html

# Inter-|   Receive                                                |  Transmit
#  face |bytes    packets errs drop fifo frame compressed multicast|bytes    packets errs drop fifo colls carrier compressed
#     lo:       0       0    0    0    0     0          0         0        0       0    0    0    0     0       0          0
#   eth0: 751746167 1194789    0    0    0     0          0       0 169193604  707575    0    0    0     0       0          0


ethn=$1

while true
do
    RX_pre=$(cat /proc/net/dev | grep $ethn | sed 's/:/ /g' | awk '{print $2}')
    TX_pre=$(cat /proc/net/dev | grep $ethn | sed 's/:/ /g' | awk '{print $10}')
    sleep 1
    RX_next=$(cat /proc/net/dev | grep $ethn | sed 's/:/ /g' | awk '{print $2}')
    TX_next=$(cat /proc/net/dev | grep $ethn | sed 's/:/ /g' | awk '{print $10}')

    clear
    echo -e "\t RX `date +%k:%M:%S` TX"

    RX=$((${RX_next}-${RX_pre}))
    TX=$((${TX_next}-${TX_pre}))

    if [[ $RX -lt 1024 ]];then
        RX="${RX}B/s"
    elif [[ $RX -gt 1048576 ]];then
        RX=$(echo $RX | awk '{print $1/1048576 "MB/s"}')
    else
        RX=$(echo $RX | awk '{print $1/1024 "KB/s"}')
    fi

    if [[ $TX -lt 1024 ]];then
        TX="${TX}B/s"
    elif [[ $TX -gt 1048576 ]];then
        TX=$(echo $TX | awk '{print $1/1048576 "MB/s"}')
    else
        TX=$(echo $TX | awk '{print $1/1024 "KB/s"}')
    fi

    echo -e "$ethn \t $RX $TX "

done
