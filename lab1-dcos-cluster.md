# Lab 1: Build Your DC/OS Cluster

In this lab you will install and configure 7 AWS instances as your DC/OS
cluster. Installing and configuring the DC/OS Cluster will be a 3 step process:

1. Clone the Ansible scripts onto the boostrap node.
2. Add the server's private IPadresses to the playbooks, then run Ansible.
3. Install the DC/OS CLI on the bootstrap node.

Finally, if you have extra time you can explore the DC/OS UI, try out the DC/OS
CLI, and installing a couple of Catalog packages.

For this lab you will need your server assigments and ssh password or pem file. The server assignments will include both the private and public IPAdresses of all 7 nodes. 

## Use Ansible to Install DC/OS

First, ssh to your bootstrap node and then clone the following repo:

`git clone https://bitbucket.org/pumphouse_p/dcos-ansible.git`

Change into the `dcos-ansible` directory:

`cd dcos-ansible`

If you have time feel free to explore the `dcos-ansible` directory. It will
contain the playbooks,....

Next, update the host files with your server's private IPs.

`vim hosts`

Since we have not connected to these servers perviously, we will want to
disable the host key checking:

`export ANSIBLE_HOST_KEY_CHECKING=False`

Finally, run the playbook with:

`ansible-playbook -i hosts --private-key <path_to_ssh_key> main.yaml`

This process will take between 5 - 10 minutes. You will know the installastion
is complete when you are able to access the DC/OS UI with the master's public
IP `http://master.public.ip`. You will need to create a log in. 

The Ansible playbooks that you used were created by the Education team at Mesosphere and are open source.

## Configure the Cluster

Now that you can access the DC/OS UI, you can use the copy & paste instructions
to install the DC/OS CLI on the bootstrap node. 

In the upper left corner of the UI, click on the drop-down menu. Then select
the "Install DC/OS CLI".

In the pop-up window, toggle to the "Linux" instructions. Finally, copy and
paste the instructions to the bootstrap node. After the CLI has been installed,
you will be prompted for log in credentials. 

## Optional: Explore the Cluster

Now that the Cluster is ready for the remainder of the workshop, take some time
to check out the DC/OS UI. Particularly, notice overview page, nodes page, and
services page. 

The overview page is a great place to get quick data on the cluster. You can
see the number of agent nodes in the cluster. You can also see the component
health. Finally, notice the services overview where you could see which
services are running and their health status. 

The nodes page will provide more detailed information about the nodes
including; region, health, and tasks running.

The services page will show you all running servies with a quick view of their
resource utilization. 

After exploring the DC/OS UI, check out the DC/OS CLI. Learn the available commands with dcos --help. A few things to try are:

1. `dcos node`. This will list all the nodes in the cluster including masters.
2. `dcos marathon app list`. This will show you all the running applications in the cluster. You can issue other marathon commands to mangae your applications including; adding new applications, deleting applications, monitoring deployments.
3. `dcos`. 

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



