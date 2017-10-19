#! /bin/bash

# Start or stop vm mysql services

for i in 10 11 12 13 14 15 16 17 18 19
 
do

ssh -t shaker@10.10.$i.118 "sudo service mysql start" 


done
