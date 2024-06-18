#!/bin/bash

function sample {
    local sample_set_name=$1
    local solr_endpoint=$2

    for qualified_ead_id in $( cat list.txt ); do
        repository=$( echo $qualified_ead_id | sed 's@/.*$@@' )
        ead_id=$( echo $qualified_ead_id | sed 's@^.*/@@' )
        directory=$sample_set_name/$repository
        mkdir -p $directory
        url="${solr_endpoint}?q=ead_ssi:${ead_id}&wt=json&indent=true&rows=999999&sort=id+asc&facet.field=repository_sim&facet.field=dao_sim&facet.field=creator_sim&facet.field=date_range_sim&facet.field=subject_sim&facet.field=name_sim&facet.field=place_sim&facet.field=language_sim&facet.field=collection_sim&facet.field=format_sim&&&&&facet.mincount=1&fl=*&qf=unittitle_teim%5E145.0+parent_unittitles_teim+collection_teim+unitid_teim%5E60+collection_unitid_teim%5E40+language_ssm+unitdate_start_teim+unitdate_end_teim+unitdate_teim+name_teim+subject_teim%5E60.0+abstract_teim%5E55.0+creator_teim%5E60.0+scopecontent_teim%5E60.0+bioghist_teim%5E55.0+title_teim+material_type_teim+place_teim+dao_teim+chronlist_teim+appraisal_teim+custodhist_teim%5E15+acqinfo_teim%5E20.0+address_teim+note_teim%5E30.0+phystech_teim%5E30.0+author_teim%5E10.0&pf=unittitle_teim%5E145.0+parent_unittitles_teim+collection_teim+unitid_teim%5E60+collection_unitid_teim%5E40+language_ssm+unitdate_start_teim+unitdate_end_teim+unitdate_teim+name_teim+subject_teim%5E60.0+abstract_teim%5E55.0+creator_teim%5E60.0+scopecontent_teim%5E60.0+bioghist_teim%5E55.0+title_teim+material_type_teim+place_teim+dao_teim+chronlist_teim+appraisal_teim+custodhist_teim%5E15+acqinfo_teim%5E20.0+address_teim+note_teim%5E30.0+phystech_teim%5E30.0+author_teim%5E10.0&bq=format_sim%3A%22Archival+Collection%22%5E250&bq=level_sim%3Aseries%5E150&bq=level_sim%3Asubseries%5E50&bq=level_sim%3Afile%5E20&bq=level_sim%3Aitem&facet=true&ps=50&defType=edismax&timeAllowed=-1&f.repository_sim.facet.limit=-1&f.dao_sim.facet.limit=-1&f.creator_sim.facet.limit=-1&f.date_range_sim.facet.limit=-1&f.subject_sim.facet.limit=-1&f.name_sim.facet.limit=-1&f.place_sim.facet.limit=-1&f.language_sim.facet.limit=-1&f.collection_sim.facet.limit=-1&f.format_sim.facet.limit=-1"
        echo $url
        curl -s $url > $directory/${ead_id}.json

    done
}

sample local 'http://localhost:8983/solr/findingaids/select'
# This is actually the dev Solr server, not prod, but we need to do the
# comparison on the FABified Solr index, which currently only exists in dev.
#sample prod 'http://44.216.225.190:8080/solr/findingaids/select'
# sample prod 'http://44.218.37.122:8080/solr/findingaids/select'
