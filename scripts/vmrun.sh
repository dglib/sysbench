#! /bin/bash

# This script runs sysbench on the vm's, the database should already be created
# and loaded. This should be run after vmprep.sh.

for i in 10 11 12 13 14 15 16 17 18 19
 
do

#ssh -t shaker@10.10.$i.118 "service mysql status | grep Active"

ssh -t shaker@10.10.$i.118 "sysbench /usr/share/sysbench/tests/include/oltp_legacy/oltp.lua  --oltp-tables-count=10 --oltp-table-size=2000000 --oltp-test-mode=complex --threads=10 --time=1800 --events=1000000 --mysql-db=sysbench --mysql-user=root run &"

done
