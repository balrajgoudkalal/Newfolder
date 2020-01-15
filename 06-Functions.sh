 #!/bin/bash

##define a function

 #function func_name(){}  (this is one way)

 #func_name(){} (thi is second way)

SAMPLE() {

    echo  this is a sample function
}
  
 
  SAMPLE1(){
      echo first argument=$1
  }

  SAMPLE2(){
      A=100
      local a=100
  }
   #access the function m main program
    SAMPLE
    SAMPLE1 abc 
    SAMPLE2
    echo "A= $A, a= $a"
    

    #you define varuable in main progra and access them in function and vice-versa
    #your main program variables can be overwritten by function and vice-versa 
    ## some cases we want to define variable inside function and should not accessed outside the function 
    #such cases we choose to use local command to define variable 
   
   ##  local VAR=DATA

  #function is a type of command
  #there are four types of command 1.binaries , 2.shell built in commands ,3.alias 4.Function
  