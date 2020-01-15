#!/bin/bash

# Two conditional statements are available in bash shell 1.IF 2.CASE

ACTION=$1
SERVICE_NAME=DEMO

START_FUNC(){
    echo "starting $SERVICE_NAME service"

}

STOP_FUNC(){
    echo "stopiing $SERVICE_NAME service"
}
USAGE(){
    echo -e "\n\e[33musage: $0 action(start|stop|restart)"
 exit 1
}
case $ACTION in 
start)
  START_FUNC
  ;;
stop)
  STOP_FUNC
  ;;
restart)
  STOP_FUNC
START_FUNC
  ;;
*)
 echo -e "\n\e[33musage: $0 action(start|stop|restart)"
 exit 1
 ;;
esac 


#IF statement has three forms 
#1. Simple IF
# If [expression]; then
# execute commands
#fi
#2. If-Else
# If [experession]; then
# commands
#else 
#commands
#fi
#3. Else-If
#If[expression1]; then
#commands
#elif[expression2]; then 
#commands
#fi
##expressions are categorized into three again,
#1. string expressions; operators are =, !=, -z
#2.Numerical expressions; operators are -eq, -ne,-gt ,-le, -le
#3.File expressions; refer internet

if [ "$ACTION" = "start" ]; then
 START_FUNC
elif [ "$ACTION" = "stop" ]; then
 STOP_FUNC
elif [ "$ACTION" = "restart" ]; then
 STOP_FUNC
 START-FUNC
else
 USAGE
fi