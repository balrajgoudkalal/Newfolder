#!bin/bash

# purpose: setup student application with web+app+ DB components
##project: student app monolithic
##author: Balraj
## Description: this script installs and configures all web components and web components and complete application
#    taken care by this scripts

#Global variables
LOG=/tmp/student.log #(to see any o/p)
rm -f $LOG
#use functions here
Head (){
  echo -e "\t\t\t\t\n\e[1;4;35m $1 \e[0m\n"  #(here 1 is for bold, 4 is for underline)
}
print(){
  echo -e "  $1\t\t\t "
}
#main program 
Head "WEB SERVER SETUP"
echo -n "install web server" # (here -n facilitates success message against the command, we can replace echo -n with print)
yum install nginx -y &>>$LOG  #(&>>$LOG --if you dont want to see logs )
if [ $? -eq 0 ]; then 
  echo " -SUCCESS"
else 
  echo " -FAILURE"
  exit 1
fi  