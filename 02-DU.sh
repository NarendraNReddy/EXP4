#!/bin/bash

DISK_USAGE=$(df -hT | grep xfs)
THRESHOLD=6

while IFS= read -r line
do 
    DISK_USAGE_LIMIT=$(echo $DISK_USAGE)
    echo "$DISK_USAGE_LIMIT \n"
done <<<$DISK_USAGE
