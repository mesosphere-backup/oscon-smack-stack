# Lab 1: Build Your DC/OS Cluster

In this lab you will install and configure 7 AWS instances to be a DC/OS
cluster. Installing and configuring the DC/OS Cluster will be a 3 step process:

1. Clone the Ansible scripts on the boostrap node.
2. Add the server's private IPadresses to the playbooks, then run Ansible.
3. Install the DC/OS CLI.

Finally, if you have extra time you can explore the DC/OS UI and CLI.

For this lab you will need your server assigments and ssh password or pem file. The server assignments will include both the private and public IPAdresses of all 7 nodes. 

## Use Ansible to Install DC/OS

First clone the following repo:

`git clone https://bitbucket.org/pumphouse_p/dcos-ansible.git`

Next update the host files with your server's private IPs.

`vim dcos-ansible/hosts`

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

## Explore the Cluster

Now that the Cluster is ready for the remainder of the workshop, take some time
to check out the DC/OS UI. Particularly, notice overview page, nodes page, and
services page. 

The overview page is a great place to get quick data on the cluster. You can
see the number of agent nodes in the cluster. You can also see the component
health. Finally, you can notice the services overview where you could see which
services are running and their health status. 

The nodes page will provide more detailed information about the nodes
including; region, health, and tasks running.

The services page will show you all running servies with a quick view of their
resource utilization. 

After exploring the DC/OS UI, check out the DC/OS CLI. Learn the available commands with dcos --help. A few things to try are:

1. `dcos node`. This will list all the nodes in the cluster including masters.
2. `dcos marathon app list`. This will show you all the running applications in the cluster. You can issue other marathon commands to mangae your applications including; adding new applications, deleting applications, monitoring deployments.
3. `dcos`. 

## Lab Conclusion

When you have time, continue to explore the DC/OS UI and CLI. Some possible things to do: 

1. Install a package from the Catalog.
2. Explore the component health for a node.


