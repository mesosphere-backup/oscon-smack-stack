#! /bin/bash
dcos node ssh --option StrictHostKeyChecking=no --option LogLevel=quiet --master-proxy --mesos-id=$(dcos node --json | jq --raw-output '.[] | select(.attributes.public_ip == "true") | .id') 'curl -s ifconfig.co'

