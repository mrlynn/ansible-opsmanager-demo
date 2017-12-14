#!/bin/bash

inventory="ansible-hosts"

echo "Setting up a mongodb cluster with ops manager and SSL"
echo "An ansible inventory in ./ansible-hosts is expected"
echo "The ops manager instance must be in group [opsManager]"
echo "The replica set instances must be in group [ReplicaSet]"
echo "ensure you are using the right private keyfile in ansible.cfg"
echo "The certificate authority key, cert and pem files need to be in the files directory"

echo "Pinging"
ansible -i ${inventory} all -m ping

echo "Setting up SSL"
ansible-playbook -i ${inventory} playbooks/playbook-ssl.yml

echo "Updating RPMs, disabling hugepage support, adding XFS volume"
ansible-playbook -i ${inventory} playbooks/playbook-updates.yml
ansible-playbook -i ${inventory} playbooks/playbook-hugepage.yml
ansible-playbook -i ${inventory} playbooks/playbook-dataXfs.yml

echo "Installing ops manager"
ansible-playbook -i ${inventory} playbooks/playbook-opsmanager-prerequisites.yml
ansible-playbook -i ${inventory} playbooks/playbook-opsmanager-mongods.yml
ansible-playbook -i ${inventory} playbooks/playbook-opsmanager-package.yml

echo "Now setup your ops manager instance via the http interface"
echo -n "hit return when done"
read nothing

ansible-playbook -i ${inventory} playbooks/playbook-restartOM.yml
ansible-playbook -i ${inventory} playbooks/playbook-automation-agent.yml
