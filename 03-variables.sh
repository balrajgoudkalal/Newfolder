#!/bin/bash


#to declare variable we use VAR=DATA
a=10 

#in shell there is not default datatype
##a=10, 10 is not a number for interpreter and it is just a string
## a=true not a boolean, it is string
# a=abc , not a character but a string
# when your data having some spcial characters use quotes..doube is preferred

#to access a variable we need to prefix a $ character to variable
echo a= $a

# when your data having some spcial characters use quotes..doube is preferred
b="balraj kalal"  #here space is special character
echo B= $b
b=*.sh
echo B= $b
##
DATE=01-08-2020
echo hello , good morning today date is $DATE

# above statement is true for inly one day
#date is the only value making that statement is wrong
#to get date dynamically when the script is executed then, we need to use command substitution
#syntax , VAR=$command or VAR='command' 
DATE=$(date +%F)
echo hello , good morning today date is $DATE
