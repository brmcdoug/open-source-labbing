### Lesson 3 - automating tasks with Ansible

1. Deploy clab topology

2. Install Ansible
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
   
5. Attempt to manually configure BFD, it doesn't work

5. Create and run Ansible playbook(s)
   1. deploy playbook: motd, base daemons and frr.conf
   2. update playbook: bfdd, bfd config, isis p2p
   3. srv6 config


### End of Lesson-3


















