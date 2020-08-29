#!/bin/bash

VPN=$(nmcli con show --active | grep vpn | awk '{print $2}')
echo '{"VPN":"'$(echo $VPN)'"}' | jq --unbuffered --compact-output
