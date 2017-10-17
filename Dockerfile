FROM ubuntu:16.04

LABEL maintainer="shaker242@gmail.com"

RUN apt-get update \
        && apt-get upgrade \
        && apt-get install -y wget libmysqlclient20 --no-install-recommends

RUN wget http://repo.percona.com/apt/pool/main/s/sysbench/sysbench_1.0.9-1.xenial_amd64.deb \
        && dpkg -i sysbench_1.0.9-1.xenial_amd64.deb \
        && rm -rf /var/lib/apt/lists/*

ENV SYSBENCH_DB_HOST=mysql \
    SYSBENCH_DB=sysbench \
    SYSBENCH_TABLE_SIZE=2000000 \
    SYSBENCH_TABLE_COUNT=10 \
    SYSBENCH_THREADS=10 \
    SYSBENCH_TIME=1200 \
    SYSBENCH_EVENTS=1000000

RUN echo 'sysbench /usr/share/sysbench/tests/include/oltp_legacy/oltp.lua  --oltp-tables-count=${SYSBENCH_TABLE_COUNT} \
        --oltp-table-size=${SYSBENCH_TABLE_SIZE} --mysql-host=mysql --mysql-db=${SYSBENCH_DB} --mysql-user=root prepare' > /sysbenchprep.sh \
        && chmod +x /sysbenchprep.sh

RUN echo 'sysbench /usr/share/sysbench/tests/include/oltp_legacy/oltp.lua  --oltp-tables-count=${SYSBENCH_TABLE_COUNT} \
        --oltp-table-size=${SYSBENCH_TABLE_SIZE} --oltp-test-mode=complex --threads=${SYSBENCH_THREADS} --time=${SYSBENCH_TIME} \
        --events=${SYSBENCH_EVENTS} --mysql-host=mysql --mysql-db=${SYSBENCH_DB} --mysql-user=root run' > /sysbenchgo.sh \
        && chmod +x /sysbenchgo.sh

CMD /sysbenchprep.sh && /sysbenchgo.sh
