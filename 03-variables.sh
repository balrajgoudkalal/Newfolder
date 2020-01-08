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



