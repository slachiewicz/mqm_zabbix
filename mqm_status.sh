#!/bin/bash

TMP_FILE=/tmp/check_mqm_$1

anywait(){

    for pid in "$@"; do
        while kill -0 "$pid" 2>/dev/null; do
            sleep 0.5
        done
    done
}

rm -f $TMP_FILE
screen -m -d -t check_mqm_$1 bash -c "/root/zabbix/scripts/check_mqm.sh $1 > $TMP_FILE;"
SC_PID=`ps -aef | grep "check_mqm_$1" | grep -v "grep" | awk '{print $2}'`
anywait $SC_PID
cat $TMP_FILE
rm $TMP_FILE