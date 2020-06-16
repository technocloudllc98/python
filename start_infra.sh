#!/bin/bash


for service in  InMemoryData MessageProce
do

if pgrep $service >/dev/null 2>&1
        then
            echo $service is running.....
                        process_id1=`/bin/ps -fu $USER | grep "$service" | grep -v "grep" | awk '{print $2}'`
                        kill -9 $process_id1
                        echo Stopping $service.....
                        echo -e "\n"
        else
                        echo All ok...
fi

done


printf "Starting InMemoryData\n\n"

VMA_SPEC=latency LD_PRELOAD=libvma.so nice -n -19 ./InMemoryData > ./logs/IMD_MRL_$(date +%d-%h-%y_%H-%M-%S).txt 2>&1 & disown
sleep 3
if pgrep InMemoryData >/dev/null 2>&1

                        then
                                echo InMemoryData started...
                        else
                                echo InMemoryData did not started.
                                echo Plese check if file exist
                                exit 0
                        fi


sleep 2

printf "Starting MessageProcessor\n\n"

./MessageProcessor > ./logs/MPlog_$(date +%d-%h-%y_%H-%M-%S).txt 2>&1  & disown
sleep 1
if pgrep MessageProce >/dev/null 2>&1

                        then
                                echo MessageProcessor started...
                        else
                                echo MessageProcessor did not started.
                                echo Plese check if file exist
                                exit 0
                        fi

sleep 1

printf "\nLog written in logs directory\n\n"

exit 0
