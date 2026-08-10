#!/bin/bash

case "$1" in

topProcess)

    if [ "$3" = "memory" ]; then
        ps -eo pid,user,%mem,%cpu,comm --sort=-%mem | head -n $(( $2 + 1))

    elif [ "$3" = "cpu" ]; then
        ps -eo pid,user,%cpu,%mem,comm --sort=-%cpu | head -n $(( $2 + 1))

    else
        echo "Use memory or cpu"
    fi
    ;;


killLeastPriorityProcess)

    pid=$(ps -eo pid,ni --sort=-ni | sed -n '2p' | awk '{print $1}')

    echo "Killing PID: $pid"

    kill "$pid"
    ;;


RunningDurationProcess)

    if [[ "$2" =~ ^[0-9]+$ ]]; then
        ps -p "$2" -o pid,comm,etime
    else
        ps -C "$2" -o pid,comm,etime
    fi
    ;;


listOrphanProcess)

    ps -eo pid,ppid,comm | awk '$2 == 1'
    ;;


listZoombieProcess)

    ps -eo pid,ppid,stat,comm | grep ' Z'
    ;;


killProcess)

    if [[ "$2" =~ ^[0-9]+$ ]]; then
        kill "$2"
    else
        pkill "$2"
    fi
    ;;


ListWaitingProcess)

    ps -eo pid,ppid,stat,comm | grep ' D'
    ;;


*)

    echo "Usage:"
    echo "./otProcessManager topProcess 5 memory"
    echo "./otProcessManager topProcess 10 cpu"
    echo "./otProcessManager killLeastPriorityProcess"
    echo "./otProcessManager RunningDurationProcess nginx"
    echo "./otProcessManager RunningDurationProcess 1234"
    echo "./otProcessManager listOrphanProcess"
    echo "./otProcessManager listZoombieProcess"
    echo "./otProcessManager killProcess nginx"
    echo "./otProcessManager killProcess 1234"
    echo "./otProcessManager ListWaitingProcess"

    ;;

esac
