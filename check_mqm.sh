#!/bin/bash

MQ_USER=mqm
MQ_DIR=/opt/mqm
MQ_QM=LOYT

MQSC=$MQ_DIR/bin/runmqsc

function is_integer() {
    printf "%d" $1 > /dev/null 2>&1
    return $?
}

function execute_command() {
	COMMAND=$1
	REGEXP=$2
	RESULT=$(/usr/bin/sudo -u $MQ_USER $MQSC $MQ_QM <<EOF
$COMMAND
EOF)
	VARA=$(echo $RESULT | gawk "{print gensub(/(.*)$REGEXP(.*)/,\"\\\2\", \"\")}")
	echo $VARA 
}

function queue_depth() {
	QUEUE=$1
	execute_command "dis ql($1) CURDEPTH" "CURDEPTH\(([0-9]*)\)"
}


function process_queue_depth() {
	QUEUE_NAME=$1
	QUEUE_DEPTH=$(queue_depth "$QUEUE_NAME")
	if is_integer $QUEUE_DEPTH; then
	   echo "$QUEUE_DEPTH"
	else
	   echo "-1" 
	fi
}

RES=$(process_queue_depth "$1")
echo $RES
exit 0


