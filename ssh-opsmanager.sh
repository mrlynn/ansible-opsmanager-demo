#!/bin/sh
export om=`cat ansible-hosts | grep opsmanager\= | cut -d \= -f2`
echo "$om"
ssh ec2-user@$om
