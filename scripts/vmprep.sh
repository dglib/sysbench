#! /bin/bash

# This script should prepare the mysql database for sysbench, it should be run after vmreset.sh.
# ... this process takes awhile, grab some coffee.

for i in 10 11 12 13 14 15 16 17 18 19
 
do

ssh -t shaker@10.10.$i.118 "sysbench /usr/share/sysbench/tests/include/oltp_legacy/oltp.lua  --oltp-tables-count=20 --oltp-table-size=2000000 --mysql-db=sysbench --mysql-user=root prepare"


done

