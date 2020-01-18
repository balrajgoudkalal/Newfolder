#!bin/bash

# purpose: setup student application with web+app+ DB components
##project: student app monolithic
##author: Balraj
## Description: this script installs and configures all web components and web components and complete application
#    taken care by this scripts

LOG=/tmp/student.log #(to see any o/p)
rm -f $LOG
echo "WEB SERVER SETUP"
echo "install web server"
yum install nginx -y &>>$LOG  #(&>>$LOG --if you dont want to see logs )
if [ $? eq 0 ]; then 
  echo " -SUCCESS"
else 
  echo " -FAILURE"
  exit 1
fi  