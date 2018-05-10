#! /bin/bash

ansible-playbook -i hosts --private-key ~/.ssh/mesosphere.pem main.yaml
