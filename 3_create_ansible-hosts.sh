#!/bin/sh
source ../functions.sh
echo `clear`
title "Create ansible-hosts file from EC2 Instances with matching tags"
echo "Examining EC2 instances for ansible-opsmgr tags"
python createAnsibleHosts.py 

