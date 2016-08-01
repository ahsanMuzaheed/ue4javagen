#!/bin/sh

process() {
	#echo $*
	#jdeps $*

	for f in $(jar tf $*)
	do
		# Find clasess defined JAR files
		#
		if [[ $f =~ ".class" ]]
		then
			echo $f
		fi
	done
}

export -f process

find "$1" -name *jar -exec bash -c 'process "$0"' {} \;
