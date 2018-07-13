#! /bin/bash
clear
echo
echo "In our first lab we connected to a DCOS Cluster. Now we are going to make sure we are connected to the"
echo "the right cluster, and understand the composition of our cluster before our installation."
echo
echo "First, lets list our clusters and make sure we are connected to the cluster we want to install our"
echo "SMACK Stack.  We will enter:"
echo
echo "                              dcos cluster list"
echo
echo "Here is a sample of 2 clusters, which cluster is the active cluster?"
echo
echo "         NAME                       CLUSTER ID                  STATUS    VERSION           URL"
echo " jdohoney-link-master  65d34ce5-ca98-4e0e-ba0c-63019059e614    AVAILABLE    N/A    https://34.211.147.63"
echo " linked-cluster*       78ee062e-4a16-45a7-a784-eddcdd2b7a3b    AVAILABLE    N/A    https://34.215.143.202"
echo
read -r -p "Hit any key and <return> to contine " response
clear
echo "Now for your actual cluster..."
echo
dcos cluster list
echo
echo "Note, the active cluster has an '*', all comands will be processed against this cluster--even if there"
echo "is just one cluster.  Next, we will take a look at the nodes in the cluster and the roles they play."
echo "We will enter:"
echo
echo "                             dcos node"
echo
dcos node
echo
echo "The 'dcos node' command will get a lot of use in cluster operations.  It is important to note that none of"
echo "these commands would have worked if we did not have a valid JWT token ( core.dcos_acs_token) in our DC/OS configuration."
echo "Take a quick look at the CLI configuration:"
echo
echo "                             dcos config show"
dcos config show
echo
echo
echo
echo "Now we will begin the actual SMACK Stack installation..."
echo
read -r -p "Hit any key and <return> to contine" response
clear
echo
echo "Spark Installation"
echo
echo "The remainder of this shell script will set up your DCOS Environment with the basic SMACK Stack components"
echo
echo "Now that we are logged into the DC/OS Cluster and successfully  authenticated, the script will"
echo "drive the installation of the Framework components under DC/OS that will support the application"
echo
echo "Begin Spark Installation...."
echo "We will being the SMACK stack installation with the installation of Spark from the DC/OS Universe (catalog) using"
echo "the DC/OS CLI package install commands"
echo
echo "To install spark using the package manager we enter: dcos package install spark --yes"
echo
dcos package install spark --yes
echo
read -r -p "Hit any key and <return> to contine" response
clear
echo "Apache Cassandra Installation"
echo
echo "Many times when installing DC/OS Frameworks, requirements may dictate that we install a specific"
echo "version.  The DC/OS package manager allows us to both query and install specific versions of a framework"
echo
echo "first, we will query the package manager to obtain the Cassandra versions available with the following.."
echo
echo "           dcos package describe --package-versions cassandra"
echo
dcos package describe --package-versions cassandra
echo
echo "Note all the versions available from the DC/OS Universe, and make specific note of the version that meets"
echo "your developers requirememts.  One word about DC/OS Versions. There are 2 main parts of the version string"
echo
echo "                        <framework version>-<component version>"
echo
echo "The general rule on framework versions is the higher the better.  There are cases the community or DCOS"
echo " support may suggest a specific framework version.  The component version is what you are familiar with"
echo "for any given system.  Now we will install a specific package versioni for Apache Cassandra: 1.0.25-3.0.10"
echo
echo "            dcos package install cassandra --package-version=2.1.0-3.0.16 --yes"
echo
read -r -p "Hit any key to install Cassandra and <return> to contine" response
clear
echo
dcos package install cassandra --package-version=2.1.0-3.0.16 --yes
sleep 10
echo
read -r -p "Hit any key and <return> to contine" response
clear
echo "Now that cassandra is installed, the package adds new commands to the CLI.  These can listed by entering..."
echo
echo "            dcos cassandra --help"
echo 
dcos cassandra --help
echo "Take a second and scroll up to view the new commands that support Framework operations on Cassandra"
echo
read -r -p "Hit any key and <return> to contine" response
clear
echo
echo "DC/OS is like any other Container management system, in that it can run Containers and Pods, However, what sets it apart"
echo "is its ability to run Frameworks.  Frameworks are an interface that is inherited by a software tool.  The benefit of this is it"
echo "provides a common operational interface.  This simplifies Run Books and allows implimentation of internal private frameworks."
echo
echo "Lets query the Cassandra framework to see the status of the deployment.  Make note of this command and run in by hand after this"
echo "installtion script has completed to note the differences in completion.  All DC/OS Frameworks are asychronus."
echo
echo "                    dcos cassandra plan show deploy"
dcos cassandra plan show deploy
echo
echo "Now, we will select the connection option to validate that our database is running.."
echo
read -r -p "Hit any key and <return> to contine" response
clear
echo
echo "Now lets view the conections we have to the database"
echo
echo "            dcos cassandra endpoints native-client"
dcos cassandra endpoints native-client
echo
echo "We are going to wait 30 seconds and repeat to see the progress of the installation"
sleep 30
dcos cassandra plan show deploy
echo
read -r -p "Hit any key and <return> to contine" response
clear
echo "Apache Kafka"
echo
echo "The final Framwork to install is Apache Kafka.  We will take the latest version of Kafka for"
echo "our stack, this will be done by entering:"
echo
echo "              dcos package install kafka --yes"
echo
dcos package install kafka --yes
sleep 30
echo
echo
read -r -p "Hit any key and <return> to contine" response
clear
echo
echo "Finally, we will use the CLI extensions installed in support of kafka to validate the framwork was"
echo "properly installed.  But first, we will take a brief look at the framework suuport for Kafka"
echo
echo "            dcos kafka --help"
dcos kafka --help
echo
echo "Take a second and scroll up to view the new commands that support Framework operations on Kafka"
echo
read -r -p "Hit any key and <return> to contine" response
clear
echo
echo "Now lets use the following command to validate that our framework has network endpoints established"
echo
echo "            dcos kafka endpoints broker"
echo
dcos kafka endpoints broker
echo "We will revisit this when we install the application, but note list of hosts and ports as well as the"
echo "VIP - connection string, that looks like:"
echo 
echo '        \"vip\": \"broker.kafka.l4lb.thisdcos.directory:9092\"'
echo
read -r -p "Hit any key and <return> to contine" response
clear
echo
echo "The basic SMACK Stack is now installed on DC/OS"
echo
echo "We can observe the installation with many commands, but in this example, we will use the Marathon task list command"
echo
echo "             dcos marathon task list"
echo
dcos marathon task list
echo
echo "The task IDs are most helpful from an operations context.  You can also look at installed packages using the package list command"
echo
echo "             dcos package list"
echo
dcos package list
echo
echo "This provides running version information"
echo
echo "This portion of the installation is complete..."
echo
exit
