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
