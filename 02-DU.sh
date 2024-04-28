#!/bin/bash

DISK_USAGE=$(df -hT | grep xfs)
THRESHOLD=6

while IFS= read -r line
do 
    DISK_USAGE_LIMIT=$(echo DISK_USAGE | awk -F " " '{print $6F}' | cut -d "%" -f1)
    echo $DISK_USAGE_LIMIT
done <<<$DISK_USAGE
