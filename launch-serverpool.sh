#!/bin/bash

source ../functions.sh
inventory="ansible-hosts-serverpool"
export ANSIBLE_CONFIG=./ansible.cfg
export ANSIBLE_HOSTS=./ansible-hosts-serverpool

title "Deploy an EC2 Instance for Ops Manager Server Pool"
echo "Ensure you are using the right private keyfile in ansible.cfg"

ansible-playbook -i ${inventory} playbooks/playbook-ec2-serverpool.yml

title "Create ansible-hosts file from EC2 Instances with matching tags"
echo "Examining EC2 instances for ansible-opsmgr tags"
python createAnsibleHostsServerPool.py

echo "Setting up a mongodb cluster with ops manager"
echo "Updating RPMs, disabling hugepage support, adding XFS volume"
ansible-playbook -i ${inventory} playbooks/playbook-updates.yml -l ServerPool
ansible-playbook -i ${inventory} playbooks/playbook-hugepage.yml -l ServerPool
ansible-playbook -i ${inventory} playbooks/playbook-dataXfs.yml -l ServerPool

ansible-playbook -i ${inventory} playbooks/playbook-server-pool-key.yml -l ServerPool
