#!/bin/bash

diff -X exclude-list.txt -r prod/ local/ | gegrep -E -v -- '---|        "_version_":|         "timestamp":"|^[0-9,c]+$|    "QTime":|^diff -r |^<         "Translation missing: en.ead_indexer.fields.dao",|^>         "Online Access",'

