#!bin/bash

# purpose: setup student application with web+app+ DB components
## project: student app monolithic
##author: Balraj
## Description: this script installs and configures all web components and web components and complete application
#    taken care by this scripts

#Global variables
LOG=/tmp/student.log #(to see any o/p)
rm -f $LOG
G="\e[32m"
R="\e[31m"
N="\e[0m"
FUSERNAME=student
TOMCAT_VERSION=8.5.50
TOMCAT_URL=http://apachemirror.wuchna.com/tomcat/tomcat-8/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz
TOMCAT_HOME=/home/$FUSERNAME/apache-tomcat-${TOMCAT_VERSION}

#use functions here
Head() {
  echo -e "\t\t\t\t\n\e[1;4;35m $1 \e[0m\n" #(here 1 is for bold, 4 is for underline)
}
print() {
  echo -e "\n\n#--------- $1 ---------#" >>$LOG
  echo -e -n "  $1\t\t\t "

}
STAT_CHECK() {
  if [ $1 -eq 0 ]; then
    echo -e " - ${G}-SUCCESS${N}"
  else
    echo -e " - ${R}-FAILURE${N}"
    echo -e "Refer Log :: $LOG for more info"
    exit 1
  fi
}
#main program
USER_ID=$(id -u)
if [ $USER_ID -ne 0 ]; then
  echo -e "you should be root user to proceed !!"
  exit 1
fi

Head "WEB SERVER SETUP"
print "install web server\t" # (here -n facilitates success message against the command, we can replace echo -n with print)
yum install nginx -y &>>$LOG #(&>>$LOG --if you dont want to see logs )
STAT_CHECK $?

print "clean old index files\t"
rm -rf /usr/share/nginx/html/* &>>$LOG
STAT_CHECK $?

cd /usr/share/nginx/html/

print "Download index files\t"
curl -s https://studentapi-cit.s3-us-west-2.amazonaws.com/studentapp-frontend.tar.gz | tar -xz
STAT_CHECK $?

print "Update nginx proxy config"
LINE_NO=$(cat -n /etc/nginx/nginx.conf | grep 'error_page 404' | grep -v '#' | awk '{print $1}')
sed -i -e "/^#STARTPROXYCONFIG/,/^#STOPPROXYCONFIG/ d" /etc/nginx/nginx.conf
sed -i -e "$LINE_NO i #STARTPROXYCONFIG\n\tlocation /student {\n\t\tproxy_pass http://localhost:8080/student;\n\t}\n#STOPPROXYCONFIG" /etc/nginx/nginx.conf
STAT_CHECK $?

print "Starting Nginx Service"
systemctl enable nginx &>>$LOG
systemctl restart nginx &>>$LOG
STAT_CHECK $?

Head "APPLICATION SERVER SETUP"
print "Adding functional user"
id $FUSERNAME &>>$LOG
if [ $? -eq 0 ]; then
  STAT_CHECK 0
else
  useradd $FUSERNAME &>>$LOG
  STAT_CHECK $?
fi

print "install java\t\t"
yum install java -y &>>$LOG
STAT_CHECK $?

print "Download Tomcat\t"
cd /home/$FUSERNAME
curl -s $TOMCAT_URL | tar -xz
STAT_CHECK $? 
print "Download Student Application"
cd $TOMCAT_HOME
curl -s https://s3-us-west-2.amazonaws.com/studentapi-cit/student.war -o webapps/student.war
STAT_CHECK $?

print "Download JDBC Driver\t"
cd $TOMCAT_HOME
curl -s https://s3-us-west-2.amazonaws.com/studentapi-cit/mysql-connector.jar -o lib/mysql-connector.jar
STAT_CHECK $?

print "Update JDBC parameters"
cd $TOMCAT_HOME
sed -i -e '/TestDB/ d' -e '$ i <Resource name="jdbc/TestDB" auth="Container" type="javax.sql.DataSource" maxTotal="100" maxIdle="30" maxWaitMillis="10000" username="student" password="student@1" driverClassName="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3306/studentapp"/>' conf/context.xml 
STAT_CHECK $?

chown $FUSERNAME:$FUSERNAME /home/$FUSERNAME -R

print "Download Tomcat init script"
curl -s https://s3-us-west-2.amazonaws.com/studentapi-cit/tomcat-init -o /etc/init.d/tomcat
STAT_CHECK $?

print "load Tomcat script to systemd"
chmod +x /etc/init.d/tomcat
systemctl daemon-reload &>>$LOG
STAT_CHECK $?

print "Start Tomcat Service\t "
systemctl enable tomcat &>>$LOG
systemctl restart tomcat &>>$LOG
STAT_CHECK $?

Head "DataBase Server Setup"
print "Install MariaDB server"
yum install mariadb-server -y &>>$LOG
STAT_CHECK $?

print "Start MariaDB Service"
systemctl enable mariadb &>>$LOG
systemctl start mariadb &>>$LOG
STAT_CHECK $?

print "load schema \t\t"
curl -s https://s3-us-west-2.amazonaws.com/studentapi-cit/studentapp-ui-proj1.sql -O /tmp/Studentapp.sql 
mysql  </tmp/schema.sql
STAT_CHECK $?

