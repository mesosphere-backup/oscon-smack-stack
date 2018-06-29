# Lab 2: Install SMACK Technologies

In this lab you will initiate a script that installs three of the SMACK Stack technoloiges, which are
certified packages in the DC/OS catalog: 

1. Cassandra
2. Kafka
3. Spark

## Download the Install Scripts

1. On the bootstrap node, clone the OSCON SMACK Stack tutorial

`git clone https://github.com/mesosphere/oscon-smack-stack.git`

The folder will contain the scripts that automate the install of the SMACK
stack and an application that uses the stack. In this lab, we will only be
using the installing script.

Before continuing, make sure that the cluster does not have any packages
installed. If you have Cassandra, Kafka, or Spark installed, the script will
fail.

To remove any packages, simply navigate to the `services` page in the DC/OS UI
and select `delete` from the menu on the right of each service name.

## Excute the SMACK Script

**Step 1**

First, change into the `1.11` folder:

`cd oscon-smack-stack/1.11`


**Step 2**

Next execute the script and follow the prompts:

`./install-smack.sh`

This process will take several minutes.

The script will install Cassandra, Kafka, and Spark. Through the prompts you
will also get familiar with the DC/OS CLI.

## Conclusion

Monitor the installation in the DC/OS UI. All the services should be running
and in a healthy state. Please notifiy an instructor if you have any concerns.

Continue to [Lab 3](https://github.com/mesosphere/oscon-smack-stack/blob/master/lab3-using-smack-stack.md)
