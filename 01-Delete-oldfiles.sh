#!/bin/bash


SOURCE_DIRECTORY=/tmp/app-logs

if [ -d $SOURCE_DIRECTORY ];
then
    echo "Folder exists"
else
    echo "Folder does not exists"
    exit 1
fi        

FILES=$(find $SOURCE_DIRECTORY -name "*.log" -mtime +14)

while IFS= read -r line
do
  echo "Deleting $line"
  rm -rf $line
done <<<$FILES