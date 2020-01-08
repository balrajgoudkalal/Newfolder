#!/bin/bash
##tonprint something on the screen we use printf command or echo command
##echo command we use most

echo hello

## if we want to print mutiple lines

echo Hello\nBye

#\n is an escape esquence which prints new line

##\n when we use escape sequence we need to use -e to echo command

echo -e Hello\nBye

##when you enable escape sequences in echo command always provide input in quotes(single or double)

echo -e "Hello\nBye"
## to print tab space we have \t escape sequence

echo -e "hello\t\\t\t\t\tt\t\Bye"

## to show some colors

##\e to enable color
##colors are of two types 
##fore ground
##back ground
#syntax of color enabling echo -e "\e[colmHello"  >> COL is one of the Number shown below
# color       background    foreground
# red            31             41

# green           32             42

# yellow          33             43

# blue            34             44
# magenta         35             45
# cyan            36             46

echo -e "\e[31mRed color"
echo  -e "\e[33mYellow color"
echo -e "\e[44mBlue background color"

#color always follows, bcz you enabled color and not disabled the same , to disable use 0 (zero) in place ofcolor code
echo -e "\e[44mBlue background color\e[0m"\