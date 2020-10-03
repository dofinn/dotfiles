#!/bin/bash

# TODO
# get env info
# execute in ocm-container
# add mouse click buttons to delete/extend expiry

OCM=/home/dofinn/go/bin/ocm

$HOME/.local/bin/ocm-stg-login &> /dev/null

CLUSTER_INFO=$($OCM list cluster --managed | grep dofinn | awk '{print $1,$2, $4, $8}')

CLUSTER_ID=$(echo $CLUSTER_INFO | awk '{print $1}')
CLUSTER_NAME=$(echo $CLUSTER_INFO | awk '{print $2}')
CLUSTER_VERSION=$(echo $CLUSTER_INFO | awk '{print $3}')
CLUSTER_STATE=$(echo $CLUSTER_INFO | awk '{print $4}')


if [ "$CLUSTER_INFO" == "" ]
then
		echo '{"text":"0 Clusters"}' | jq --unbuffered --compact-output
else
		CLUSTER_EXPIRY=$($OCM get https://api.stage.openshift.com/api/clusters_mgmt/v1/clusters/$CLUSTER_ID | jq -r '.expiration_timestamp' | xargs -I{} date +"%Y-%m-%d %H:%M:%S %Z" -d '{}')
		echo '{"text":"'"$CLUSTER_STATE@$CLUSTER_VERSION exp:$CLUSTER_EXPIRY"'"}' | jq --unbuffered --compact-output
fi
