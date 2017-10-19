#! /bin/bash

# This is for Docker images, not VM's.
# For loop to create docker mysql & sysbench images on their own networks
# and declaring mysql as the hostname for the database since sysbench will look 
# for that via swarm dns.

for i in 1 2 3 4 5 6 7 8 9 10
 
do
ssh -t shaker@10.10.1.115 "docker network create --attachable dbnet$i"

ssh -t shaker@10.10.1.115 "docker run -d --rm --network-alias=mysql --network=dbnet$i -p :3306 --env MYSQL_ALLOW_EMPTY_PASSWORD=yes --env MYSQL_DATABASE=sysbench --env MYSQL_BUFFERSIZE=2G --env MYSQL_LOGSIZE=256M --env MYSQL_FLUSHLOG=1 --env MYSQL_FLUSHMETHOD=O_DIRECT mysql:5.7"

sleep 10

ssh -t shaker@10.10.1.115  "docker run -d --rm --network=dbnet$i shaker242/sysbench:latest"

done

