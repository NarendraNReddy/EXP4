
#!/bin/bash

source ./common.sh
checkroot


echo "Enter password:"
read DB_SERVER_PASSWORD
#ExpenseApp@1


dnf install mysql-serverrr -y &>>$LOGFILE
#VALIDATE $? "mysql server installation"

systemctl enable mysqld &>>$LOGFILE
VALIDATE $? "enable mysql server"

systemctl start mysqld &>>$LOGFILE
VALIDATE $? "start mysql server"

#idempotency  
mysql -h db.daws78s-nnr.online -uroot -p${DB_SERVER_PASSWORD} -e 'show databases' &>>$LOGFILE
if [ $? -ne 0 ];
then 
    mysql_secure_installation --set-root-pass ${DB_SERVER_PASSWORD} &>>$LOGFILE
    VALIDATE $? "set password for mysql server"
else 
    echo -e "Password is already set...$Y SKIPPING $N"    

fi


