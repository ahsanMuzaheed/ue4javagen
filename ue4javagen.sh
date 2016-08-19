#!/bin/sh

process() {
	echo "Searching JAR $*..." 

	for f in $(jar tf $*)
	do
		# Find clasess defined JAR files
		#
		if [[ $f =~ ".class" ]]
		then
			javap -s -p -classpath "$*" $(echo $f | tr / . | sed s/.class//g) | egrep 'Compiled from|descriptor|public|private|\(|\)'
		fi
	done
}

export -f process

find "$1" -name *jar -exec bash -c 'process "$0"' {} \;

