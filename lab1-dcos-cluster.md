# Lab 1: Build Your DC/OS Cluster

In this lab you will configure 7 AWS instances as your DC/OS
cluster. Installing and configuring the DC/OS Cluster will be a 3 step process:

1. Add the server's private IP Adresses to the playbooks.
2. Run Ansible.
3. Install the DC/OS CLI on the bootstrap node.

Finally, if you have extra time you can explore the DC/OS UI, try out the DC/OS
CLI, and installing a couple of Catalog packages.

For this lab you will need your server assigments and ssh password or pem file. The server assignments will include both the private and public IP Adresses of all 7 nodes. 

## Use Ansible to Install DC/OS

First, we will need to install our cluster with DC/OS 1.11.

Since we reviewed the manual advanced
installation, we have automated our installation with Ansible. This will allow you to quickly
and easily complete the install process from the bootstrap node. The bootstrap node aleardy has Ansible installed and the necessary scripts to install
DC/OS on the master and agent nodes. 

**Step 1**

`ssh` in to your bootstrap node with the ssh user and ssh password
credentials.

**Step 2**

Change into `/tools/dcos-ansible` directory.

`cd ~/tools/dcos-ansible`

Next, modify the `hosts` file
to include the private IP addresses for your nodes under their respective
sections in the document.

**Step 3**

Execute the following command to start the installation of DC/OS:

`ansible-playbook -i hosts --private-key student_* --extra-vars
"dcos_version=dcos-1.11" main.yaml`

This process will take less than 10 minutes. You will know the installastion
is complete when you are able to access the DC/OS UI with the master's public
IP `http://master.public.ip`. To login, enter the username `bootstrapuser` and password
`deleteme`. 


## Configure the Cluster

Now that you can access the DC/OS UI, you can use the copy & paste instructions
to install the DC/OS CLI on the bootstrap node. 

**Step 1**

In the upper left corner of the UI click on the drop-down menu. Select
the "Install DC/OS CLI", then toggle to the "Linux" instructions in the pop-up window. 

**Step 2** 
Copy and paste the instructions to the bootstrap node. After the CLI has been installed,
you will be prompted for log in credentials:

* username: `bootstrapuser`
* password: `deleteme` 

Once you have logged you will see a list of available commands:

```
Command line utility for the Mesosphere Datacenter Operating
System (DC/OS). The Mesosphere DC/OS is a distributed operating
system built around Apache Mesos. This utility provides tools
for easy management of a DC/OS installation.

Available DC/OS commands:

	auth           	Authenticate to DC/OS cluster
	cluster        	Manage your DC/OS clusters
	config         	Manage the DC/OS configuration file
	help           	Display help information about DC/OS
	job            	Deploy and manage jobs in DC/OS
	marathon       	Deploy and manage applications to DC/OS
	node           	View DC/OS node information
	package        	Install and manage DC/OS software packages
	service        	Manage DC/OS services
	task           	Manage DC/OS tasks

Get detailed command description with 'dcos <command> --help'.
```

## Optional: Explore the Cluster

Now that the Cluster is ready for the remainder of the workshop, take some time
to check out the DC/OS UI. Particularly, notice the "overview page", "nodes
page", and "services page". 

The overview page is a great place to get quick data on the cluster. You can
see the number of agent nodes in the cluster. You can also see the component
health. Finally, notice the services overview where you could see which
services are running and their health status. 

The nodes page will provide more detailed information about the nodes
including; region, health, and tasks running.

The services page will show you all running servies with a quick view of their
resource utilization. 

After exploring the DC/OS UI, check out the DC/OS CLI. Learn the available
commands with `dcos --help`. A few things to try are:

1. `dcos node`. This will list all the nodes in the cluster including masters.
2. `dcos marathon app list`. This will show you all the running applications in the cluster. You can issue other marathon commands to mangae your applications including; adding new applications, deleting applications, monitoring deployments.
3. `dcos cluster list`. This will return cluster information on all available
clusters.  

## Optional: Install a Couple Certified Packages

DC/OS provides two quick options for installing catalog packages; the DC/OS UI
and DC/OS CLI. 

DC/OS UI:

Navigate the the "Catalog" page and find the Cassandra package. Follow the
prompts to install the package with all the defaults. The package should only
take a couple minutes to install. 

You can view the the installation under the "Services" page. Once the package
is fully installed, you can view service details by clicking on "Cassandra".
Check out the "Endpoints" tab for connection information. The "Debug" tab will
have task infromation and resource offers. Finally, you can click on specific
task under the "Task" tab to view service files and logs. 

DC/OS CLI:

`dcos package install kafka`

When installing with the DC/OS CLI, the dcos cli subcommands for that package
area automatically installed. Try them out:

`dcos kafka --help`

We will learn more about the subcommands in the SMACK Stack Lab.

## Lab Conclusion

Since we will be automating the install of Cassandra and Kafka in the next lab,
go ahead and delete the services now. 

Continue to [Lab 2](https://github.com/mesosphere/oscon-smack-stack/blob/master/lab2-deploy-smack-technologies.md)

