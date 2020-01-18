#!/bin/bsh
# for loop, while loop
for var in val1 val2 val3 ; do 
 echo $var
 sleep 1
done


## same process can be done by following way 

VALUES="val1 val2 val3"
 for var in $VALUES ; do
 echo $var
sleep 1
done

i=60 

while [ $i -gt 0 ]; do
   date
   sleep 2
   i=$(($i-2))

done