
### Global Variables
LOG=/tmp/student.log 
rm -f $LOG 
G="\e[32m"
R="\e[31m"
N="\e[0m"
FUSERNAME=student
TOMCAT_VERSION=8.5.47
TOMCAT_URL=http://apachemirror.wuchna.com/tomcat/tomcat-8/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz
TOMCAT_HOME=/home/$FUSERNAME/apache-tomcat-${TOMCAT_VERSION}

### Functions
Head() {
  echo -e "\n\t\t\t\e[1;4;35m $1 \e[0m\n"
}

Print() {
  echo -e "\n\n#--------- $1 ---------#" >>$LOG 
  echo -e -n "  $1\t\t "
}

STAT_CHECK() {
  if [ $1 -eq 0 ]; then 
    echo -e " - ${G}SUCCESS${N}" 
  else 
    echo -e " - ${R}FAILURE${N}"
    echo -e "Refer Log :: $LOG for more info"
    exit 1 
  fi 
}


## Main Program 

USER_ID=$(id -u)
if [ $USER_ID -ne 0 ]; then 
  echo -e "You should be root user to proceed!!"
  exit 1
fi 

Head "WEB SERVER SETUP"
Print "Install Web Server\t"
yum install nginx -y &>>$LOG 
STAT_CHECK $?

Print "Clean old Index files\t"
rm -rf /usr/share/nginx/html/* &>>$LOG 
STAT_CHECK $? 

cd /usr/share/nginx/html/

Print "Download Index files\t"
curl -s https://studentapi-cit.s3-us-west-2.amazonaws.com/studentapp-frontend.tar.gz | tar -xz 
STAT_CHECK $? 

Print "Update nginx proxy config"
LINE_NO=$(cat -n /etc/nginx/nginx.conf | grep 'error_page 404' | grep -v '#' |awk '{print $1}')
sed -i -e "/^#STARTPROXYCONFIG/,/^#STOPPROXYCONFIG/ d" /etc/nginx/nginx.conf
sed -i  -e "$LINE_NO i #STARTPROXYCONFIG\n\tlocation /student {\n\t\tproxy_pass http://localhost:8080/student;\n\t}\n#STOPPROXYCONFIG" /etc/nginx/nginx.conf
STAT_CHECK $? 

Print "Starting Nginx Service"
systemctl enable nginx &>>$LOG 
systemctl restart nginx &>>$LOG 
STAT_CHECK $? 

