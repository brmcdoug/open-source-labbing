### screenshare steps

1. Show lesson-3-topo.yaml and talk about frr image

```
export PROMPT_DIRTRIM=1
```
### cleanup any stale lesson-3 topologies
```
ansible-playbook -i hosts lesson-3.2-destroy-playbook.yml -e "ansible_user=cisco ansible_ssh_pass=cisco123 ansible_sudo_pass=cisco123" -vv

ansible-playbook -i hosts lesson-3-destroy-playbook.yml -e "ansible_user=cisco ansible_ssh_pass=cisco123 ansible_sudo_pass=cisco123" -vv
```

### Ansible inventory
```
cat hosts
```

### Deploy lesson-3 topo
```
more lesson-3-deploy-playbook.yml
more lesson-3-frr-base-playbook.yml
```
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

#### verify update - review ansible stdout for bfdd status
```
docker exec -it clab-ans-frr-3 vtysh
show run
show bfd peers
ping 10.10.2.2
exit

docker exec -it clab-ans-pc-1 sh
ip a
ip route
ping 10.0.0.1 -c 2
ping 10.0.0.2 -c 2
```

### 3.2 deploy 
```
more lesson-3.2-deploy-playbook.yml
more lesson-3.2-update-playbook.yml

# look for MTU, etc.
```
```
ansible-playbook -i hosts lesson-3.2-deploy-playbook.yml -e "ansible_user=frr ansible_ssh_pass=frr123 ansible_sudo_pass=frr123" -vv
```

#### verify 3.2
```
more logs/labbing.log
clab inspect -a
brctl show

docker exec -it clab-ext-frr-4 bash
ifconfig
vtysh
show run
show isis database
show bgp sum

ssh cisco@clab-ext-xrd02
show bgp ipv6 uni sum

ssh cisco@clab-ext-xrd01
show isis database
show bgp ipv6 uni sum
ping fc00:0:4::1 source lo1
```

### 3.3 SRv6
```
more lesson-3.3-srv6-playbook.yml
```

```
ansible-playbook -i hosts lesson-3.3-srv6-playbook.yml -e "ansible_user=frr ansible_ssh_pass=frr123 ansible_sudo_pass=frr123" -vv
```

#### verify 3.3 srv6

```
docker exec -it clab-ans-frr-3 vtysh
show bgp ipv4 vpn
show bgp ipv4 vpn rd 10.0.0.5:0 13.13.13.0/24
exit
ip route show vrf blue

ssh cisco@clab-ext-xrd01
show bgp vrf blue   
show bgp vpnv4 uni rd 10.0.0.5:0 10.10.2.0/24 det
```
