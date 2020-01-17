#!/bin/bash
git add -A  
read -p "commit automatically: " commit
git commit -m $commit 
git push origin master 