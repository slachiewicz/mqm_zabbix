#!/bin/bash

QUEUE_DEPTH=20

function generate_template() {
	 for QUEUE in "$@"; do
		ITEMS="$ITEMS $(generate_item $QUEUE)"
		TRIGERS="$TRIGERS $(generate_triggers $QUEUE)"
		GRAPHS="$GRAPHS $(graph_element $QUEUE)"
	 done

	cat template_1.xml
	echo $TRIGERS
	cat template_2.xml
	echo $ITEMS
	cat template_3.xml
	echo $GRAPHS
	cat template_4.xml
}

function generate_item() {
	QUEUE=$1
	cat item.xml|sed -e s/\$QUEUE/$QUEUE/g
}

function generate_triggers() {
	QUEUE=$1
	DEPTH=$QUEUE_DEPTH
	cat triggers.xml|sed -e s/\$QUEUE/$QUEUE/g|sed -e s/\$DEPTH/$DEPTH/g
}

function graph_element() {
	QUEUE=$1
	cat graph_element.xml|sed -e s/\$QUEUE/$QUEUE/g
}

echo -n "Enter queue name: "
while read QUEUE 
do
	echo -n "Enter queue name (leave it empty to exit): "
	if test -z "$QUEUE" 
	then 
		break;
	fi
	QUEUES="$QUEUES $QUEUE"
done

echo
echo "Generating config for $QUEUES"
generate_template $QUEUES > !generated_template.xml
echo File !generated_template.xml created