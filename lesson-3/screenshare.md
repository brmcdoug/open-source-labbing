### screenshare steps

```
export PROMPT_DIRTRIM=1
```

### Destroy lesson-3 topo
```
ansible-playbook -i hosts lesson-3-destroy-playbook.yml -e "ansible_user=cisco ansible_ssh_pass=cisco123 ansible_sudo_pass=cisco123" -vv
```

```
more lesson-3-deploy-playbook.yml
more lesson-3-frr-base-playbook.yml
```

### Deploy lesson-3 topo
```
ansible-playbook -i hosts lesson-3-deploy-playbook.yml -e "ansible_user=frr ansible_ssh_pass=frr123 ansible_sudo_pass=frr123" -vv
```

#### verify clab topology
```
brctl show
containerlab inspect -a

docker exec -it clab-ans-frr-1 bash
ifconfig
vtysh
show isis database
show ip route
show ipv6 route
show bgp sum

docker exec -it clab-ans-frr-2 vtysh
show bgp sum
```

### Add BGP on frr-1
```
more lesson-3-frr-bgp-playbook.yml
more roles/frr_bgp/tasks/main.yml
```
```
ansible-playbook -i hosts lesson-3-frr-bgp-playbook.yml -e "ansible_user=frr ansible_ssh_pass=frr123 ansible_sudo_pass=frr123" -vv
```

#### verify frr-1 bgp
```
ssh frr@clab-ans-frr-1
frr123

vtysh
show bgp sum
```

### Update topo
```
more lesson-3-frr-update-playbook.yml
```
```
ansible-playbook -i hosts lesson-3-frr-update-playbook.yml -e "ansible_user=frr ansible_ssh_pass=frr123 ansible_sudo_pass=frr123" -vv
```

### 3.2 deploy
ansible-playbook -i hosts lesson-3.2-deploy-playbook.yml -e "ansible_user=frr ansible_ssh_pass=frr123 ansible_sudo_pass=frr123" -vv

### 3.2 Destroy
ansible-playbook -i hosts lesson-3.2-destroy-playbook.yml -e "ansible_user=cisco ansible_ssh_pass=cisco123 ansible_sudo_pass=cisco123" -vv
