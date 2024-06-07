#!/bin/bash

ROOT=$( cd "$(dirname "$0")" ; pwd -P )

DIFF_REPORT=$ROOT/diff-report.html

:>$DIFF_REPORT

for f in $( find $ROOT/diffs -type f | sed "s@$ROOT/diffs/@@" | sed 's/.json//' ); do
    echo -e "<h1>$f</h1>\n" >> $DIFF_REPORT

    echo "<p/><a href='https://raw.githubusercontent.com/NYULibraries/dlfa-200_compare-acceptance-test-solr-response-samples-against-prod/develop/local/$f.json'>$f: LOCAL</a>" >> $DIFF_REPORT
    echo "<p/><a href='https://raw.githubusercontent.com/NYULibraries/dlfa-200_compare-acceptance-test-solr-response-samples-against-prod/develop/prod/$f.json'>$f: PROD</a>" >> $DIFF_REPORT
    echo "<p/><a href='https://github.com/NYULibraries/dlfa-200_compare-acceptance-test-solr-response-samples-against-prod/blob/develop/diffs/$f.json'>$f: diff</a>" >> $DIFF_REPORT
    echo "<p/><a href='https://github.com/NYULibraries/findingaids_eads_v2/commits/master/$f.xml'>$f: EAD file commit history</a>" >> $DIFF_REPORT

    echo >> $DIFF_REPORT
done
