#!/bin/bash


#echo "Enter password:"
#read DB_SERVER_PASSWORD
#ExpenseApp@1




dnf install nginx -y &>>$LOGFILE
VALIDATE $? "Install nginx"

systemctl enable nginx &>>$LOGFILE
VALIDATE $? "enable nginx"

systemctl start nginx &>>$LOGFILE
VALIDATE $? "start nginx"

rm -rf /usr/share/nginx/html/* &>>$LOGFILE
VALIDATE $? "remove html" 

curl -o /tmp/frontend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-frontend-v2.zip &>>$LOGFILE
VALIDATE $? "fronent code in /tmp folder"

cd /usr/share/nginx/html &>>$LOGFILE
VALIDATE $? "moved into hmtl folder"

unzip /tmp/frontend.zip &>>$LOGFILE
VALIDATE $? "unzip frontend code to html folder"

cp -rf /home/ec2-user/EXP4/expense.conf  /etc/nginx/default.d/expense.conf  &>>$LOGFILE
VALIDATE $? "Copy expense conf file"



systemctl restart nginx &>>$LOGFILE
VALIDATE $? "restart nginx"



