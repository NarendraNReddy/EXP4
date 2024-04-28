#!/bin/bash

DISK_USAGE=$(df -hT | grep tmpfs)
THRESHOLD=0

while IFS= read -r line
do 
    DISK_USAGE_LIMIT=$(echo $line | awk -F " " '{print $6F}' | cut -d "%" -f1)
    FOLDER=$(echo $line | awk -F " " '{print $NF}')
    
    if [ $DISK_USAGE_LIMIT -ge $THRESHOLD ];
    then
        echo "Disk usage for $FOLDER is exceeds $THRESHOLD,current usage:$DISK_USAGE_LIMIT"
    fi
done <<<$DISK_USAGE

#echo "This is a test mail & Date $(date)" | mail -s "message" narendra.h1b@com
echo "$FOLDER exceeds the $THRESHOLD, current usage:$DISK_USAGE_LIMIT" | mail -s "disk usage" narendra.h1b@com