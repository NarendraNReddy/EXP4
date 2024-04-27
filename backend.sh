
#!/bin/bash
source ./common.sh
checkroot

echo "Enter password:"
read DB_SERVER_PASSWORD
#ExpenseApp@1



dnf module disable nodejs -y &>>$LOGFILE
VALIDATE $? "nodejs module disable"

dnf module enable nodejs:20 -y &>>$LOGFILE
VALIDATE $? "enable nodejs:20 module"

dnf install nodejs -y &>>$LOGFILE
VALIDATE $? "install nodejs"

id expense &>>$LOGFILE
if [ $? -ne 0 ];
then 
    useradd expense &>>$LOGFILE
    VALIDATE $? "user expense added"
else 
    echo -e "user expense already present..$Y SKIPPING $N"    
fi


mkdir -p /app &>>$LOGFILE
VALIDATE $? "app dir created"

curl -o /tmp/backend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-backend-v2.zip  &>>$LOGFILE
VALIDATE $? "backend code in /tmp directory"

rm -rf /app/* &>>$LOGFILE
VALIDATE $? "Remove everything in app"

cd /app &>>$LOGFILE
VALIDATE $? "Enter into app"

unzip /tmp/backend.zip &>>$LOGFILE
VALIDATE $? "Unzip the backend code in app"

npm install &>>$LOGFILE
VALIDATE $? "Instllating the npm"

cp -rf /home/ec2-user/EXP4/backend.service  /etc/systemd/system/backend.service &>>$LOGFILE
VALIDATE $? "Backend.service is copied"


systemctl daemon-reload &>>$LOGFILE
VALIDATE $? "daemon-reload"


systemctl start backend &>>$LOGFILE
VALIDATE $? "start backend"

systemctl enable backend &>>$LOGFILE
VALIDATE $? "enable backend"


dnf install mysql -y &>>$LOGFILE
VALIDATE $? "install mysql client "


mysql -h  db.daws78s-nnr.online -uroot -p${DB_SERVER_PASSWORD} < /app/schema/backend.sql &>>$LOGFILE
VALIDATE $? "DB to backend connection"

systemctl restart backend &>>$LOGFILE
VALIDATE $? "Restart backend"


