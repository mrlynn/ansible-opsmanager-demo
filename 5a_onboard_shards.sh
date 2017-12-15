#!/bin/bash
source functions.sh
inventory="./setup/ansible-hosts-shards"
echo `clear`
title "9 - Onboard Sharded Replica Set Members for Ops Manager Management"
echo "Setting up a ${green}MongoDB${reset} cluster with ${green}Ops Manager${reset}"
echo "The hosts you intend to use for your cluster should already be up and running."
echo "The replica set instances must be in group [Shards]"
echo "ensure you are using the right private keyfile in ansible.cfg"

title "Step 2 - Install the ${green}Ops Manager${reset} Prerequisite Packages on the Shard Members"
pause
typeit "ansible-playbook -i ${inventory} playbooks/playbook-shard-prerequisites.yml"
ansible-playbook -i ${inventory} playbooks/playbook-shard-prerequisites.yml
echo
title "Step 3 - Install the ${green}Ops Manager${reset} Automation Agent on your target replica set members"
pause
typeit "ansible-playbook -i ${inventory} playbooks/playbook-automation-agent-shards.yml"
ansible-playbook -i ${inventory} playbooks/playbook-automation-agent-shards.yml
title "Step 4 - Now open your ${green}Ops Manager${reset} console in a browser.  Click on Server View and you will see your newly onboarded hosts."
