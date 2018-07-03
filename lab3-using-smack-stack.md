# Deploy an Application that uses the SMACK Stack

In this final lab, you will use the SMACK stack installed previously. 

## Execute the Install SMACK Application Script

**Step 1**

Before installing the SMACK Application, ensure Cassandra, Kafka, and Spark are
fully deployed. Cassandra and Kafka should both have a scheduler and 3 managed
nodes. Spark should only have one instances, task running.

On your bootstrap node, in the `1.11` directory, excute the script and follow
the prompts:

`./install_smack_application.sh`

The script will install two applications, both will be in the `oscon-smack`
folder in the UI.

1. `dashboard`

2. `ingest`

You will be able to see both new applications in the DC/OS UI. 

**Step 2**

View the dashboard using the public agent's public IP Address,
`http://$public_ip:8000`. 

The application will give you a map where with every poll of the bus-data, that data is streamed into 
the map via a websocket connection. The bus information will take a minute or two to populate, but the bus
route data is posted on initialilzation.

## Conclusion

Now that you have finished the labs feel free to install other certified
package or create your own application definition in JSON.
