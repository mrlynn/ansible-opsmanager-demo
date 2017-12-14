#!/bin/bash
source functions.sh
inventory="ansible-hosts"
echo `clear`
title "9 - Onboard Replica Set Members for Ops Manager Management"
echo "Setting up a ${green}MongoDB${reset} cluster with ${green}Ops Manager${reset}"
echo "The hosts you intend to use for your cluster should already be up and running."
echo "The replica set instances must be in group [ReplicaSet]"
echo "ensure you are using the right private keyfile in ansible.cfg"

echo
title "Step 2 - Install the ${green}Ops Manager${reset} Prerequisite Packages on the Replicaset Members"

ansible-playbook -i ${inventory} playbooks/playbook-replicaset-prerequisites.yml
echo
title "Step 3 - Install the ${green}Ops Manager${reset} Automation Agent on your target replica set members"
ansible-playbook -i ${inventory} playbooks/playbook-automation-agent.yml
title "Step 4 - Now open your ${green}Ops Manager${reset} console in a browser.  Click on Server View and you will see your newly onboarded hosts."
