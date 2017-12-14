#!/bin/bash

inventory="ansible-hosts"
export ANSIBLE_CONFIG=./ansible.cfg
export ANSIBLE_HOSTS=./ansible-hosts

source ../functions.sh

title "Deploy an EC2 Instance for Ops Manager"
echo "Ensure you are using the right private keyfile in ansible.cfg"

#ansible-playbook -i ${inventory} playbooks/playbook-ec2-opsmgr.yml

title "Deploy an EC2 Instances for MongoDB Replica Set"
echo "Ensure you are using the right private keyfile in ansible.cfg"

ansible-playbook -i ${inventory} playbooks/playbook-ec2-replset.yml

title "Create ansible-hosts file from EC2 Instances with matching tags"
echo "Examining EC2 instances for ansible-opsmgr tags"
python createAnsibleHosts.py

echo "Setting up a mongodb cluster with ops manager"
echo "An ansible inventory in ./ansible-hosts is expected"
echo "The ops manager instance must be in group [opsManager]"
echo "The replica set instances must be in group [ReplicaSet]"
echo "ensure you are using the right private keyfile in ansible.cfg"

echo "Pinging"
ansible -i ${inventory} all -m ping

echo "Updating RPMs, disabling hugepage support, adding XFS volume"
ansible-playbook -i ${inventory} playbooks/playbook-updates.yml
ansible-playbook -i ${inventory} playbooks/playbook-hugepage.yml
ansible-playbook -i ${inventory} playbooks/playbook-dataXfs.yml

echo "Installing ops manager"
ansible-playbook -i ${inventory} playbooks/playbook-opsmanager-prerequisites.yml
ansible-playbook -i ${inventory} playbooks/playbook-opsmanager-mongods.yml
ansible-playbook -i ${inventory} playbooks/playbook-opsmanager-package.yml
ansible-playbook -i ${inventory} playbooks/playbook-opsmanager-create-head.yml

cat ansible-hosts | grep 8080

echo "Now setup your ops manager instance via the http interface"
echo -n "hit return when done"
read nothing

ansible-playbook -i ${inventory} playbooks/playbook-automation-agent.yml
