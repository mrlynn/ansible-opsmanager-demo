#!/bin/sh
export om=`cat ansible-hosts | grep http|cut -d \= -f2`
echo "$om"
open $om
