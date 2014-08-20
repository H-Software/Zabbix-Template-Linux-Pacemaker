#!/bin/bash

# nagios returncodes:
STATE_OK=0
STATE_WARNING=1
STATE_CRITICAL=2
STATE_UNKNOWN=3

while getopts “i:” OPTION; do
  case $OPTION in
    i)
      item=$OPTARG
      ;;
    ?)
      echo "UNKNOWN: Unknown argument: $1"
      exit $ST_UK
      ;;
  esac
done

# MANDATORY args
if [ -z "$item" ]; then
  echo "UNKNOWN: missing argument -i"
  exit $ST_UK
fi

# check for info and set $STATUS
out=$(crm_mon --one-shot --as-xml 2>/dev/null)
STATUS=$?

p_import="import xml.etree.cElementTree as et,sys,io;tree=et.ElementTree();"
p_tree="tree.parse(io.BytesIO(b'''$out'''));"

if [ ${STATUS} -eq 0 ]
then
    if [ "$item" == "last_update" ]; then
        p_item="obj=tree.getroot(); print obj[0][0].get('time');"
    elif [ "$item" == "nodes_configured" ]; then
        p_item="obj=tree.getroot(); print obj[0][4].get('number');"
    elif [ "$item" == "resources_configured" ]; then
        p_item="obj=tree.getroot(); print obj[0][5].get('number'); "
    elif [ "$item" == "nodes_online" ]; then
#       p_item="obj=tree.getroot(); print obj[1][0].get('online'); print obj[1][1].get('online'); print(\"\",obj[1][2].get('online')); "
        p_item="obj=tree.getroot(); print ' '.join([f.get('online') for f in obj.findall('nodes/node')])"
    elif [ "$item" == "nodes_resources_running" ]; then
        p_item="obj=tree.getroot(); print ' '.join([f.get('resources_running') for f in obj.findall('nodes/node')])"
    else
        echo "UNKNOWN: wrong item: $item"
        exit ${STATE_UNKNOWN}
    fi

    p_out=$(python -c "$p_import $p_tree $p_item") # 2>/dev/null)

    if [ $? -eq 0 ]
    then
        echo "$p_out"
    else
        echo "UNKNOWN: python returncode $?"
        exit ${STATE_UNKNOWN}
    fi
else
    echo "UNKNOWN: returncode ${STATUS}"
    exit ${STATE_UNKNOWN}
fi


