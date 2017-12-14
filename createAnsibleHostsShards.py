#!/usr/bin/env python2.7

from datetime import datetime, timedelta

import boto.ec2
conn = boto.ec2.connect_to_region("us-east-1")

keyname = "michael.lynn"
project = "Ops Manager Ansible"

opsmanager = ""
replica_set = []
shard_set = []

for r in conn.get_all_reservations(filters={"tag:project" : project}):
  for instance in r.instances:
    print instance.public_dns_name + " " + instance.state + " " + instance.key_name + " " + instance.instance_type + " " + instance.tags['Name']
    if instance.key_name == keyname and instance.state == "running":
      if instance.instance_type == "m3.xlarge":
      	  opsmanager = instance.public_dns_name
      else:
	if instance.instance_type == 't2.small':
          replica_set.append(instance.public_dns_name)
        else:
	  shard_set.append(instance.public_dns_name)

f = open('./ansible-hosts-shards', 'w')
f.write('[opsManager]\n')
f.write(opsmanager + " ansible_user=ec2-user\n")
f.write("\n")
f.write("[ReplicaSet]\n")
for machine in replica_set:
  f.write(machine + " ansible_user=ec2-user\n")
f.write("\n")
f.write("[ReplicaSet:vars]\n")
f.write("opsmanagerurl=http://" + opsmanager + ":8080\n")
f.write("opsmanager=" + opsmanager + "\n")
f.write("[Shards]\n")
for machine in shard_set:
  f.write(machine + " ansible_user=ec2-user\n")
f.write("\n")
f.write("[Shards:vars]\n")
f.write("opsmanagerurl=http://" + opsmanager + ":8080\n")
f.write("opsmanager=" + opsmanager + "\n")
f.close()

print 'Written ./ansible-hosts'




f = open('./ansible-hosts', 'w')
f.write('[opsManager]\n')
f.write(opsmanager + " ansible_user=ec2-user\n")
f.write("\n")
f.write("[ReplicaSet]\n")
for machine in replica_set:
  f.write(machine + " ansible_user=ec2-user\n")
f.write("\n")
f.write("[ReplicaSet:vars]\n")
f.write("opsmanagerurl=http://" + opsmanager + ":8080\n")
f.write("opsmanager=" + opsmanager + "\n")
f.close()
