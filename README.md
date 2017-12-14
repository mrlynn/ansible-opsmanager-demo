## Synopsis

This directory contains details and instructions to help you get set up to run the ansible-demo.

## Prerequisites

1. Ansible

 - On Mac OS - simply type *brew install ansible*

 - ![Brew Install ansible](/images/brew_install_ansible.png "Brew Install Ansible")

2. AWS SSH Keys

 - You need to have your working AWS Keys.  These will be used to enable you to deploy ec2 instances from ansible.
 - If you do not have working keys, visit this link for instructions: [AWS: Creating a Key Pair](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html)
 - Place this key in the filesystem on your laptop - most likely in ~/.ssh
  - e.g. /Users/mlynn/.ssh/michael.lynn.pem
 - Modify the ansible.cfg file in the top level directory of this repo with the location of your key file.
  - private_key_file = /Users/mlynn/.ssh/michael.lynn.pem

3. BOTO

This solution leverages the boto library for python for the creation of the ansible-hosts file from the AWS inventory.  To install boto - use the following command:

```pip install boto3```

4. Put your AWS Keys in place - ~/.aws/credentials:

```sh
[default]
aws_access_key_id = IOEPXX2LODTX4PGGZNJQ
aws_secret_access_key = $DAKS)f94la00s901eBLbAh+7KjFoVZ
```

5. Create your ansible.cfg file (from the example):

```sh
cp ansible.cfg.example ansible.cfg
```

6. Replace the name of your AWS Key in the ansible.cfg file:
```
[defaults]
host_key_checking = False
nocows=1
private_key_file = /Users/mlynn/.ssh/michael.lynn.pem <----Location of your key
log_path=logs/ansible.log

[ssh_connection]
control_path = %(directory)s/%%C
```

## Getting Setup

Once you have the prereqs squared away, you're ready to begin either getting your nodes deployed for demo, or if you already have nodes deployed, you can skip this next section.

### Node Deployment

Ansible automates the process of package deployment, configuration as well as node deployment.  In this section, we're going to leverage Ansible's ability to connect directly to AWS/EC2 to deploy new instances for our demo.

To speed things up - I'll leave you to work out those details as we'll not have time to leverage the EC2 Automation for this demo.

So - You'll want to deploy one M3.xlarge for your Ops Manager machine and 3 t2.small's.  Here's our architecture:

```
+----------------+                               +---------------+
|                |                               | (t2.small)    |
|  OPS MANAGER   |                               |    PRIMARY    |
|                |                               +---------------+
| (m3.xlarge)    |       +-----------------------+ OM AGENT      |
|                |       |                       +-------+-------+
+---------+------+       |                               |
          |              |                  +------------+-----------+
          |              |                  |                        |
          |              |          +-------v-------+        +-------v-------+
          |              |          | (t2.small)    |        | (t2.small)    |
          |              |          |   SECONDARY   |        |   SECONDARY   |
          |              |          +---------------+        +---------------+
          +--------------+          | OM AGENT      |        | OM AGENT      |
          |                         +-------+-------+        +-------+-------+
          |                                 |                        |
          |                                 |                        |
          |                                 |                        |
          |                                 |                        |
          +---------------------------------+------------------------+

```

### Deploying Nodes to AWS/EC2

The first thing we'll need to accomplish is getting our Ops Manager node deployed.  Since the application requirements are pretty decent, we'll leverage an M3 Instance.  Here's what that looks like in terms of resource:



### Ansible Hosts File

Once you have your hosts that you want to demonstrate connectivity and automation with **Ansible**, you need to create your ```ansible-hosts``` file.  Here's and example:

```
[opsManager]
ec2-54-162-176-239.compute-1.amazonaws.com ansible_user=ec2-user

[ReplicaSet]
ec2-54-173-174-232.compute-1.amazonaws.com ansible_user=ec2-user
ec2-54-173-133-164.compute-1.amazonaws.com ansible_user=ec2-user
ec2-54-159-152-50.compute-1.amazonaws.com ansible_user=ec2-user

[ReplicaSet:vars]
opsmanagerurl=http://ec2-54-162-176-239.compute-1.amazonaws.com:8080
opsmanager=ec2-54-162-176-239.compute-1.amazonaws.com
```
Notice that there's One OpsManager host and Three ReplicaSet hosts.  You'll need to put the FQDN's of your OpsManager and ReplicaSet members instead of mine. 
