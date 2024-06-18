#!/bin/bash

ROOT=$( cd "$(dirname "$0")" ; pwd -P )

LOCAL=$ROOT/local
PROD=$ROOT/prod
DIFFS=$ROOT/diffs

rm -fr $DIFFS

for prod_file in $( find $PROD -type f | grep -v -f $ROOT/exclude-list.txt | sort ); do
    qualified_filename=$( echo $prod_file | sed "s@$PROD/@@" )
    local_file=$LOCAL/$qualified_filename
    diff_output=$( diff $prod_file $local_file | gegrep --extended-regexp --invert-match -- '---|        "_version_":|         "timestamp":"|^[0-9,c]+$|    "QTime":|^diff -r |^<         "Translation missing: en.ead_indexer.fields.dao",|^>         "Online Access",' )
    if [ ! -z "$diff_output" ]; then
        diff_file=$DIFFS/$( echo $qualified_filename | sed 's/\.json$/.txt/' )
        echo "Writing diff file $diff_file"

        diff_dir=$( dirname $diff_file )
        mkdir -p $diff_dir

        echo "$diff_output" > $diff_file
    fi
done
