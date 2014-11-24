#!/bin/bash

STRUCTURE_DIR=$PWD/structures/
PAGES_DIR=pages/
OUTPUT_DIR=$PWD/out/
shopt -s nullglob
dir=`pwd`
mkdir -p $OUTPUT_DIR
for p in ${PAGES_DIR}*.htm; do
    cd $OUTPUT_DIR
    person=$(echo $p | cut -b 7-)
    person=${person%.htm}
    while read t; do
        r=$(echo $t | sed 's/\$FILE/'$person'/');
	if [[ $r =~ \($ ]]; then
	    r=${r%(}
	    mkdir -p $r
	    cd $r
	else
	    if [[ $r = ")" ]]; then
		cd ..
	    else
	    	cp $dir/$p $r
	    fi
	fi
    done <${STRUCTURE_DIR}${1}.strct
    cd $dir
done
