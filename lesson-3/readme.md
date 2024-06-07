### Lesson 3 - automating tasks with Ansible

1. Install Ansible
```
sudo apt-add-repository ppa:ansible/ansible
sudo apt update
sudo apt install ansible

```

3. Install sshpass
```
apt-get install sshpass
```

4. Create files for inventory, vars, configs, etc.
5. Create playbooks

### Playbooks used in Lesson-3:

#### Deploy playbook
1. starts logging
2. adds a message of the day to the topology host
3. executes containerlab deploy command to bring up the topology
4. calls nested [frr-base-config playbook](ansible/lesson-3-frr-base-playbook.yml) 

#### FRR base playbook
1. applies motd to FRR nodes
2. copies base frr.conf and daemons files over to each FRR node
   1. Note: frr-2 and frr-3 will get their full day-1 config via the copy of frr.conf. frr-1 will only get interfaces and ISIS, then we'll run the "BGP" playbook with Ansible's FRR module to program frr-1's BGP config
3. restarts FRR process

#### BGP playbook
1. leverages the Ansible frr.frr module to interact via frr vtysh CLI
2. gathers facts - aka 'show running config' for frr-1
3. applies BGP config to frr-1

#### FRR update playbook

   
4. Attempt to manually configure BFD, it doesn't work

5. Create and run Ansible playbook(s)
   1. deploy playbook: motd, base daemons and frr.conf
   2. update playbook: bfdd, bfd config, isis p2p
   3. srv6 config


### End of Lesson-3


















