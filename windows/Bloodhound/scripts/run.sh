#!/usr/bin/env bash

service neo4j start
echo "Starting ..."
if [[ ! -e /opt/.ready ]]
then 
	touch /opt/.ready
    echo "First run takes some time"
    sleep 5
until $(curl -s -H "Content-Type: application/json" -X POST -d {\"password\":\"blood\"} --fail -u neo4j:neo4j http://127.0.0.1:7474/user/neo4j/password)
do sleep 4;
done; 
fi
cp -n /opt/BloodHound-linux-x64/resources/app/Ingestors/SharpHound.* /data
echo "\e[92m*** Log in with bolt://127.0.0.1:7687 (neo4j:blood) ***\e[0m"
sleep 7
/opt/BloodHound-linux-x64/BloodHound 2>/dev/null
