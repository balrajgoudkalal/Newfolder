#!/bin/bash
 

 # upto now we taken inuts iether from script or from CLI , buthefre we going to take inputs from other sources , putting them in variable and access it
 read -p 'enter the username to add: ' user_name
 read -p 'enter the group to add: ' group_name

 #useradd -g $group_name  $user_name

 echo following command to be executed =>  useradd -g $group_name  $user_name