### Lesson 3 - automating tasks with Ansible

1. Install Ansible
```
sudo apt-add-repository ppa:ansible/ansible
sudo apt update
sudo apt install ansible

```

3. Install sshpass to enable Ansible to ssh into network elements
```
apt-get install sshpass
```

4. Create Ansible files for inventory, vars, roles, configs, etc.
5. Create playbooks

### Playbooks used in Lesson-3:

### Day-1 ops:

#### Deploy playbook
1. starts logging
2. adds a message of the day to the topology host
3. executes containerlab deploy command to bring up the topology
4. calls the nested [frr-base-config playbook](ansible/lesson-3-frr-base-playbook.yml) 

#### FRR base playbook
1. applies motd to FRR nodes
2. copies base frr.conf and daemons files over to each FRR node
   1. Note: frr-2 and frr-3 will get their full day-1 config with ISIS and BGP via the copy of frr.conf. frr-1 will only get interfaces and ISIS. In the next step we'll run the "BGP" playbook with Ansible's FRR module to program frr-1's BGP config
3. restarts FRR process on all three nodes

#### BGP playbook
1. leverages the Ansible frr.frr module to interact via frr vtysh CLI
2. gathers facts - aka 'show running config' for frr-1
3. applies BGP config to frr-1


### Day 2 ops
Prior to running the FRR update playbook we should attempt to configure BFD on one of the FRR nodes - it won't work as the BFD daemon has not been enabled.

#### FRR update playbook
1. day-2 configuration
2. enables FRR's BFD daemon in /etc/frr/daemons on all nodes
3. configures BFD on all nodes

### End of Lesson-3


















