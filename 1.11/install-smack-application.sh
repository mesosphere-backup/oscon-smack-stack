#! /bin/bash

clear
echo "The setup of the required cassandra schema is done via a DC/OS (./1.11/gui/jobs/) job."
echo "With the jobs frontend you're able to use the following JSON configuration which will pull down"
echo "a simple Docker Hub image from johndohoney/load-bus-schema repository and use the"
echo "bus-demo/import_data.sh script to load Cassandra."
echo
cat ./configuration/cassandra-schema.json
echo
echo "Another way of installing is by using the dcos job cli. "
echo "For this use the [cassandra-schema.json](configuration/cassandra-schema.json) file."
echo
echo "Use the following commands to add and run the database load..." 
echo
echo "           dcos job add configuration/cassandra-schema.json "
echo "           dcos job run init-cassandra-schema-job "
echo
dcos job add configuration/cassandra-schema.json
echo
echo "           dcos job list"
echo
dcos job list
echo
echo "Now we run the job... dcos job run init-cassandra-schema-job"
echo
dcos job run init-cassandra-schema-job
echo
echo "Now lets see the how the job completed.."
echo
read -r -p "Enter <return> to continue" jobid
dcos job list
echo
read -r -p "Hit any key and <return> to continue" response
clear
echo "Install Injestion Tasks"
echo
echo "Next, we will start with the ingestion part of the setup.  With DC/OS there are two ways of installing any"
echo "application - with the DC/OS UI, or by using the DC/OS CLI."
echo
echo "Using the UI the ingestion will get installed. To do this, copy and paste the JSON into the DC/OS UI JSON editor"
echo "in the DC/OS Web UI.  Follow your instuctor, on how to do this aspect of the installation"
echo
echo "Copy the following JSON that we will run in the UI to start the injestion task ..."
echo
echo ' {                                                                      '
echo '   "id": "/oscon-smack/ingest",                                         '
echo '   "cpus": 0.1,                                                         '
echo '   "mem": 2048,                                                         '
echo '   "disk": 0,                                                           ' 
echo '   "instances": 1,                                                      '
echo '   "container": {                                                       '
echo '    "type": "DOCKER",                                                   '
echo '    "volumes": [],                                                      '
echo '    "docker": {                                                         '
echo '      "image": "johndohoney/akka-ingest",                               '
echo '      "network": "HOST",                                                '
echo '      "privileged": false,                                              '
echo '      "parameters": [],                                                 '
echo '      "forcePullImage": true                                            '
echo '    }                                                                   '
echo '  },                                                                    ' 
echo '  "env": {                                                              '
echo '    "CASSANDRA_CONNECT": "node-0-server.cassandra.autoip.dcos.thisdcos.directory:9042", '
echo '    "KAFKA_CONNECT": "broker.kafka.l4lb.thisdcos.directory:9092"        '
echo '  }                                                                     '
echo '}                                                                       '
echo
echo
read -r -p "Hit any key and <return> to continue" response
clear
echo
echo "Now we want to query the Kafka Framework on the operational endoints"
echo
echo "                   dcos kafka endpoints broker"
dcos kafka endpoints broker
echo
echo "You'll receive a list of hosts and ports, at this point make sure to use the **vip** connection string."
echo "For example:" 
echo '              "vip": "broker.kafka.l4lb.thisdcos.directory:9092". '
echo
echo " We will Use this connection string to connect to the kafka brokers. This is an internal VIP to the DC/OS cluster"
echo " The VIP uses an internal Load Balancer (Minuteman) and round robins to each broker."
echo " The same approach applies for the connection of the cassandra nodes. "
echo
echo "                         dcos cassandra endpoints native-client"
dcos cassandra endpoints native-client
echo
read -r -p "Hit any key and <return> to continue" response
clear
echo
echo "The client command will use the dcos cli command to launch the configuration configuration/akka-ingest.json file.  "
echo "Use the following command:" 
echo
echo "             dcos marathon app add configuration/akka-ingest.json"
echo
echo "Marathon will not allow us to add this, as we already launched this in the UI..."
echo
dcos marathon app add configuration/akka-ingest.json
echo
echo
echo "Lets check that our /oscon-smack/ingest task is healthy and operational using ..."
echo
echo "              dcos marathon task list"
echo
dcos marathon task list
echo
echo
read -r -p "Hit any key and <return> to continue" response
clear
echo
echo "All interfacing clients to Kafka and Cassandra will use the VIP for connection"
echo "Make sure you have the proper connection string for Kafka and Cassandra."
echo "These connection strings (VIP) are used by Spark Streaming to connect to Kafka and Cassandra."
echo
echo "        dcos kafka endpoints broker | jq .vip  "
echo
dcos kafka endpoints broker | jq .vip  
echo
echo "This will produce a connection with host and port like the following: _broker.kafka.l4lb.thisdcos.directory:9092_"
echo
echo "The same has to be applied for cassandra, except we will use a single node: "
echo
echo "        dcos cassandra endpoint native-client | jq .dns  "
dcos cassandra endpoint native-client | jq .dns
echo
echo
echo "VIPS inside the cluster make microservice to microservice fast and efficient.  The Minuteman LB also respects the "
echo "health check, so you can always know a request is always going to a healthy endpoint in your cluster."
echo
read -r -p "Hit any key and <return> to continue to Spark Processing" response
clear
echo
echo "The digestional part of the application is done via Spark jobs. To run those jobs you'll need to use the
dcos cli.  " 
echo
echo "We will launch the Sprk job with the following CLI command..."
echo
echo "dcos spark run --submit-args='--driver-cores 0.1 --driver-memory 1024M --total-executor-cores 4 --class de.nierbeck.floating.data.stream.spark.KafkaToCassandraSparkApp https://oss.sonatype.org/content/repositories/snapshots/de/nierbeck/floating/data/spark-digest_2.11/0.2.1-SNAPSHOT/spark-digest_2.11-0.2.1-SNAPSHOT-assembly.jar METRO-Vehicles node-1-server.cassandra.autoip.dcos.thisdcos.directory:9042 broker.kafka.l4lb.thisdcos.directory:9092' "
echo
dcos spark run --submit-args='--driver-cores 0.1 --driver-memory 1024M --total-executor-cores 4 --class de.nierbeck.floating.data.stream.spark.KafkaToCassandraSparkApp https://oss.sonatype.org/content/repositories/snapshots/de/nierbeck/floating/data/spark-digest_2.11/0.2.1-SNAPSHOT/spark-digest_2.11-0.2.1-SNAPSHOT-assembly.jar METRO-Vehicles node-1-server.cassandra.autoip.dcos.thisdcos.directory:9042 broker.kafka.l4lb.thisdcos.directory:9092'
echo
echo "It is best to go to the WebUI and examine the Status of the running job.  To do this enter:"
echo "                dcos spark webui"
echo
dcos spark webui
echo
echo "Use this URL to access the Spark Job Screen"
echo
echo
echo
read -r -p "Hit any key and <return> to continue to the Demo Dashboard" response
clear
echo
echo "We will install this from the DC/OS CLI, the listing of the Dashboard follows for deployment to Marathon..."
echo
DASHBOARD=$(cat <<EOS
{
  "id": "/oscon-smack/dashboard",
  "container": {
    "type": "DOCKER",
    "docker": {
      "image": "johndohoney/akka-server",
      "network": "HOST",
      "forcePullImage": true
    }
  },
  "acceptedResourceRoles": [
    "slave_public"
  ],
  "env": {
      "CASSANDRA_CONNECT": "node-0-server.cassandra.autoip.dcos.thisdcos.directory:9042",
      "KAFKA_CONNECT": "broker.kafka.l4lb.thisdcos.directory:9092"
  },
  "dependencies": ["/oscon-smack/ingest"],
  "healthChecks": [
    {
      "path": "/",
      "protocol": "HTTP",
      "gracePeriodSeconds": 300,
      "intervalSeconds": 60,
      "timeoutSeconds": 20,
      "maxConsecutiveFailures": 3,
      "ignoreHttp1xx": false,
      "port": 8000
    }
  ],
  "cpus": 0.1,
  "mem": 2048.0,
  "ports": [
    8000, 8001
  ],
  "requirePorts" : true
}
EOS)
echo $DASHBOARD | jq .
echo
dcos marathon app add configuration/dashboard.json
echo
echo
echo "Lets see what is running.."
echo
dcos marathon task list
echo
echo
echo " This will show the list of applications involved in this SMACK demo"
echo
read -r -p "Hit any key and <return> to continue" response
clear
echo "Now that we successfully installed the application, let's take a look at the dashboard application."
echo
echo "For this we just need to navigate to: http://$PUBLICIP:8000"
echo "The application will give you a map where with every poll of the bus-data, that data is streamed into "
echo "the map via a websocket connection. The bus information will take a minute or two to populate, but the bus"
echo "route data is posted on initialilzation."
echo "Besides the real-time data streamed into the map, it's possible to request the data from the last 15 Minutes, "
echo "taken from the cassandra. "
echo
exit
