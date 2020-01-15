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
