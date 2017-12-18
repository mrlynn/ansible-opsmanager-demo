#!/bin/bash

source ./functions.sh
inventory="ansible-hosts"

title "Deploy an EC2 Instances for MongoDB Replica Set"
echo "Ensure you are using the right private keyfile in ansible.cfg"
ansible-playbook -i ${inventory} playbooks/playbook-ec2-replset.yml
pause
echo "Updating ANSIBLE_HOSTS with newly provisioned Replicaset members..."
python createAnsibleHosts.py
echo "Fixing up data drive on replcaset members..."
ansible-playbook -i ${inventory} playbooks/playbook-replicaset-dataXfs.yml


