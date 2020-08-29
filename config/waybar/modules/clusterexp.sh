#!/bin/bash

# TODO
# get env info
# execute in ocm-container
# add mouse click buttons to delete/extend expiry

OCM=/home/dofinn/go/bin/ocm

/usr/local/bin/ocm-stg-login &> /dev/null

CLUSTER_INFO=$($OCM list cluster --managed | grep dofinn | awk '{print $1,$2}')

CLUSTER_ID=$(echo $CLUSTER_INFO | awk '{print $1}')
CLUSTER_NAME=$(echo $CLUSTER_INFO | awk '{print $2}')

CLUSTER_EXPIRY=$($OCM get https://api.stage.openshift.com/api/clusters_mgmt/v1/clusters/$CLUSTER_ID | jq -r '.expiration_timestamp' | xargs -I{} date +"%Y-%m-%d %H:%M:%S %Z" -d '{}')

echo '{"text":"'"$CLUSTER_NAME EXP:$CLUSTER_EXPIRY"'"}' | jq --unbuffered --compact-output > /tmp/clusterexp.json

exit 0

