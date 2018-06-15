# Lab 2: Install SMACK Technologies

In this lab you will install three certified packages from the DC/OS catalog that will be part of your SMACK Stack: 

1. Cassandra
2. Kafka
3. Spark

## Download the Install Scripts

On the bootstrap node, download the `1.11` folder from the OSCON SMACK Stack
github repo.

The folder will contain the scripts that automate the install of the SMACK
stack and an application that uses the stack. In this lab, we will only be
using the installing script.

Before continuing, make sure that the cluster does not have any packages
installed. If you have Cassandra, Kafka, or Spark installed, the script will
fail.

To remove any packages, simply navigate to the `services` page in the DC/OS UI
and select `remove` from the menu.

## Excute the SMACK Script

First, change into the `1.11` folder:

`cd 1.11`

Next execute the script and follow the prompts:

`./install-smack.sh`

This process will take several minutes.

## Conclusion

Monitor the installation in the DC/OS UI. All the services should be running
and in a healthy state. Please notifiy an instructor if you have any concerns.



