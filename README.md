# SysBench for Docker Containers (17.06+)
My version of a MySQL driven Docker container benchmarking tool. I looked at a few repo's and started to build their versions for my own testing; however, I found that the build were too old or just simply no longer supported. Therefore, I'm pulling in data from a couple of the repos and trying to rebuild a better sysbench utility for my testing. I am sure there going to be issues, so this repo was created for testing 1 specific environment.
## Repo's of interest:
bretfisher/sysbench-docker-hpe < good baseline
https://hub.docker.com/r/bretfisher/sysbench-docker-hpe/
MySQL 5.7 Github repo: https://github.com/docker-library/mysql/blob/0590e4efd2b31ec794383f084d419dea9bc752c4/5.7/Dockerfile

# Running Sysbench
This version of sysbench runs as two containers that must be joined by a private network, or rather, a network that isolates these two containers. This allows you to run multiple instances for loading. However, the Dockerfile specifies that test will run for 1800 seconds (30min); if you want it to run longer you'll need to edit it.  For this reason, the compose.yml file does work; however, 1 to 1 bindings do not as replicas. It will spin up 10 databases and attempt to spin up 10 sysbench instances and it did load my system - but it's just not clean.  If you're skilled, I'll take any advice how to make this possible.

### Networking is important

To run the instances manually, you must first create a network "docker network create --attachable $net" and then join each runtime container to this network along with specifing the mysql hostname. 

Database =  "docker run -tid -h mysql --name mysql --network=$net -p 3306:3306 --env-file MyENV mysql:5.7" 
Sysbench =  "docker run -tid --name sysbench --network=$net shaker242/sysbench:latest"

