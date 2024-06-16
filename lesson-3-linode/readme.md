### Lesson 3 - automating tasks with Ansible

1. Install Ansible
```
sudo apt-add-repository ppa:ansible/ansible
sudo apt update
sudo apt install ansible

```

2. Install sshpass to enable Ansible to ssh into network elements
```
apt-get install sshpass
```

3. Create Ansible files for inventory, vars, roles, configs, etc.
4. Create playbooks

### Playbooks used in Lesson-3:

### Day-1 ops:

#### Destroy playbook
1. deletes linux bridge instances (if configured)
2. destroys containerlab topology (if running)
```
ansible-playbook -i hosts lesson-3-destroy-playbook.yml -e "ansible_user=frr ansible_ssh_pass=frr123 ansible_sudo_pass=frr123" -vv
```

#### Deploy playbook
1. starts logging
2. creates linux bridge instances for pc connectivity to frr-2 and frr-3
3. adds a message of the day to the topology host
4. executes containerlab deploy command to bring up the topology
5. calls the nested [frr-base-config playbook](ansible/lesson-3-frr-base-playbook.yml) 
```
ansible-playbook -i hosts lesson-3-deploy-playbook.yml -e "ansible_user=frr ansible_ssh_pass=frr123 ansible_sudo_pass=frr123" -vv
```

#### FRR base playbook
1. automatically called by the Deploy playbook
2. applies motd to FRR nodes
3. copies base frr.conf and daemons files over to each FRR node
   1. Note: frr-2 and frr-3 will get their full day-1 config with ISIS and BGP via the copy of frr.conf. frr-1 will only get interfaces and ISIS. In the next step we'll run the "BGP" playbook with Ansible's FRR module to program frr-1's BGP config
4. restarts FRR process on all three nodes

#### FRR-1 BGP playbook
1. leverages the Ansible frr.frr module to interact via frr vtysh CLI
2. gathers facts - aka 'show running config' for frr-1
3. applies BGP config to frr-1
```
ansible-playbook -i hosts  lesson-3-frr-1-bgp-playbook.yml -e "ansible_user=frr ansible_ssh_pass=frr123 ansible_sudo_pass=frr123" -vv
```

### Day 2 ops
Prior to running the FRR update playbook we should attempt to configure BFD on one of the FRR nodes - it won't work as the BFD daemon has not been enabled.

#### FRR update playbook
1. day-2 configuration
2. enables FRR's BFD daemon in /etc/frr/daemons on all nodes
3. configures BFD on all nodes
```
ansible-playbook -i hosts  lesson-3-frr-update-playbook.yml -e "ansible_user=frr ansible_ssh_pass=frr123 ansible_sudo_pass=frr123" -vv
```

### End of Lesson-3


















