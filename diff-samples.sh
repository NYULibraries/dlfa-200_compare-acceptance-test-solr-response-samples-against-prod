#!/bin/bash

diff --exclude-from=exclude-list.txt --recursive prod/ local/ | gegrep --extended-regexp --invert-match -- '---|        "_version_":|         "timestamp":"|^[0-9,c]+$|    "QTime":|^diff -r |^<         "Translation missing: en.ead_indexer.fields.dao",|^>         "Online Access",'

