# Deploy an Application that uses the SMACK Stack

In this final lab, you will use the SMACK stack installed previously. The
application that you will be deploying, will use the certified packages default paramaters
including VIPs and load balancers.

## Execute the Install SMACK Application Script

**Step 1**

On your bootstrap node, in the `1.11` directory, excute the script and follow
the prompts:

`./install_smack_application.sh`

The script actually installs two applications. 

1. `dashboard`: This application

2. `ingest`:

You will be able to see both new applications in the DC/OS UI. 

**Step 2**

View the dashboard using the public agent's public IP Address,
`http://$public_ip:8000`. 

## Conclusion

Now that you have finished the labs...
