 #!/bin/bash

##define a function

 #function func_name(){}  (this is one way)

 #func_name(){} (thi is second way)

SAMPLE() {

    echo  this is a sample function
}
  
  #access the function
  SAMPLE1(){
      echo first argument=$1
  }
    SAMPLE1 abc 
    
  #function is a type of command
  #ther are four types of command 1.binaries , 2.shell built in commands ,3.alias 4.Function
  