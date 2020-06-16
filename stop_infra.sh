
#!/bin/bash

for service in  InMemoryData MessageProce
do

if pgrep $service >/dev/null 2>&1
    then

                echo -e "\n"
                        echo Want to close $service.
                        echo Yes [Y] or No [N]
                        read ans
                                if [ "$ans" == "y" ]
                                        then
                                        kill -9 $process_id1
                                        echo $service stopped.....
                                        echo -e "\n"
                                else
                                        echo $service will be continued..
                                fi
    else
                        echo $service is not running.....
fi

done

exit 0
