#!/bin/bash

source ./functions.sh
inventory="ansible-hosts"

echo `clear`
title "Install Ops Manager Software"
echo "Ensure you are using the right private keyfile in ansible.cfg"
ansible-playbook -i ${inventory} playbooks/playbook-opsmanager-prerequisites.yml
title "Now we can install the needed MongoDB Server Daemons on the Ops Manager Host"
ansible-playbook -i ${inventory} playbooks/playbook-opsmanager-mongods.yml
title "Now we can install the opsmanager package"
ansible-playbook -i ${inventory} playbooks/playbook-opsmanager-package.yml

