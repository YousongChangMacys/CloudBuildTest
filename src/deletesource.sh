#!/bin/bash
function jsonval {
    temp=`echo $json | sed 's/\\\\\//\//g' | sed 's/[{}]//g' | awk -v k="text" '{n=split($0,a,","); for (i=1; i<=n; i++) print a[i]}' | sed 's/\"\:\"/\|/g' | sed 's/[\,]/ /g' | sed 's/\"//g' | grep -w $prop`
    echo ${temp##*|}
}
json="$(curl -X GET 'http://11.120.187.23:2999/v1.1/entity/id.json?entity_name=QA_LTY_ORCL_CICDTEST&entity_type=source&auth_token=AU66mMKxL9fEwHEUe9cMnlK9RTDNLkIfp7vcYdT9cSs=')"
prop='$value'
picurl=`jsonval`
entityid=${picurl:7}
url -X POST 'http://11.120.187.23:2999/v1.1/entity/delete.json?entity_id=${entityid}&entity_type=source&auth_token=AU66mMKxL9fEwHEUe9cMnlK9RTDNLkIfp7vcYdT9cSs='