#! /bin/bash

# This script log into each VM and remove the existing sysbench database from mysql
# and then creates a new database for sysbench to build into.

for i in 10 11 12 13 14 15 16 17 18 19
 
do

ssh -t shaker@10.10.$i.118 "mysqladmin -u root drop sysbench -f"

ssh -t shaker@10.10.$i.118 "mysqladmin -u root create sysbench"

done
