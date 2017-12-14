#!/bin/bash

source ./functions.sh
inventory="ansible-hosts"

title "Deploy an EC2 Instance for Ops Manager"
echo "Ensure you are using the right private keyfile in ansible.cfg"

ansible-playbook -i ${inventory} playbooks/playbook-ec2-opsmgr.yml
python createAnsibleHosts.py
ansible-playbook -i ${inventory} playbooks/playbook-opsmanager-dataXfs.yml

