#!/bin/bash                                                                                              

function sample {
    local sample_set_name=$1
    local solr_endpoint=$2

    for qualified_ead_id in $( cat list.txt ); do
        repository=$( echo $qualified_ead_id | sed 's@/.*$@@' )
        ead_id=$( echo $qualified_ead_id | sed 's@^.*/@@' )
        directory=$sample_set_name/$repository
        mkdir -p $directory
        curl -s "${solr_endpoint}?q=ead_ssi:${ead_id}&wt=json&indent=true&rows=999999&sort=id+asc" > $directory/${ead_id}.json
    done
}

sample local 'http://localhost:8983/solr/findingaids/select'
sample prod 'http://44.218.37.122:8080/solr/findingaids/select'


