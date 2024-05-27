### Containerlab

1. Prerequisites/requirements:
   * Linux host or VM: Centos, Redhat, Debian, Ubuntu
   * Docker 
  
   This guide is based on Ubuntu 22.04:
    ```
    cisco@topology-host2:~$ cat /etc/lsb-release 
    DISTRIB_ID=Ubuntu
    DISTRIB_RELEASE=22.04
    DISTRIB_CODENAME=jammy
    DISTRIB_DESCRIPTION="Ubuntu 22.04.3 LTS"
    ```

2. [Containerlab installation instructions](https://containerlab.dev/install/)

3. Run install script:
```
bash -c "$(curl -sL https://get.containerlab.dev)"
```

4. Output
```
cisco@topology-host2:~$ bash -c "$(curl -sL https://get.containerlab.dev)"
Downloading https://github.com/srl-labs/containerlab/releases/download/v0.54.2/containerlab_0.54.2_linux_amd64.deb
Preparing to install containerlab 0.54.2 from package
Selecting previously unselected package containerlab.
(Reading database ... 110508 files and directories currently installed.)
Preparing to unpack .../containerlab_0.54.2_linux_amd64.deb ...
Unpacking containerlab (0.54.2) ...
Setting up containerlab (0.54.2) ...
  ____ ___  _   _ _____  _    ___ _   _ _____ ____  _       _     
 / ___/ _ \| \ | |_   _|/ \  |_ _| \ | | ____|  _ \| | __ _| |__  
| |  | | | |  \| | | | / _ \  | ||  \| |  _| | |_) | |/ _` | '_ \ 
| |__| |_| | |\  | | |/ ___ \ | || |\  | |___|  _ <| | (_| | |_) |
 \____\___/|_| \_| |_/_/   \_\___|_| \_|_____|_| \_\_|\__,_|_.__/ 

    version: 0.54.2
     commit: 9ecdf0e2
       date: 2024-04-11T12:01:05Z
     source: https://github.com/srl-labs/containerlab
 rel. notes: https://containerlab.dev/rn/0.54/#0542
cisco@topology-host2:~$ 
```

5. Acquire FRR image
```
docker pull bmcdougall/frr-srv6-usid:latest
```

Output:
```
cisco@topology-host2:~$ docker pull bmcdougall/frr-srv6-usid:latest
latest: Pulling from bmcdougall/frr-srv6-usid
aece8493d397: Pull complete 
a453e2ed23ad: Pull complete 
4a41587179e4: Pull complete 
a9d82dba8399: Pull complete 
eea982e3b7d5: Pull complete 
069e2f97d79a: Pull complete 
6b2f6302b0a1: Pull complete 
7c4cf4b24672: Pull complete 
baae97151dcd: Pull complete 
165b48aca91b: Pull complete 
35017f23b8f5: Pull complete 
Digest: sha256:c76ae0100f555c32b60fe02a97d0d7473444fe8f5c9cc38c81a2b5df4a9dfb64
Status: Downloaded newer image for bmcdougall/frr-srv6-usid:latest
docker.io/bmcdougall/frr-srv6-usid:latest
```

Optional: you can verify the image:
```
docker images -a
```

Output:
```
cisco@topology-host2:~$ docker images -a
REPOSITORY                 TAG       IMAGE ID       CREATED         SIZE
ubuntu-trex                1.1       183a8a2f7445   6 months ago    1.82GB
bmcdougall/frr-srv6-usid   latest    e9bfec1bb684   6 months ago    1.99GB
```

6. Build a Containerlab topology YAML file: [3-node.yaml](3-node.yaml)

7. Define router configurations:  [config](config)
   Note: FRR has both an frr.conf file where router interfaces and features are defined and configure, and a 'daemons' file where specific routing daemons such as OSPF may be enabled or disabled

8. Deploy the topology: 
```
sudo containerlab deploy -t 3-node.yaml 
```

Example output:
```
cisco@topology-host2:~/open-source-labbing/lesson-2$ sudo containerlab deploy -t 3-node.yaml 
INFO[0000] Containerlab v0.54.2 started                 
INFO[0000] Parsing & checking topology file: 3-node.yaml 
INFO[0000] Creating docker network: Name="frr_mgt_net", IPv4Subnet="172.20.1.0/24", IPv6Subnet="", MTU=1500 
INFO[0000] Creating lab directory: /home/cisco/open-source-labbing/lesson-2/clab-3-node 
INFO[0000] Creating container: "frr-1"                  
INFO[0000] Creating container: "frr-2"                  
INFO[0000] Creating container: "frr-3"                  
INFO[0000] Creating container: "pc-1"                   
INFO[0000] Creating container: "pc-2"                   
INFO[0001] Created link: frr-1:eth1 <--> frr-2:eth1     
INFO[0001] Created link: frr-2:eth2 <--> frr-3:eth1     
INFO[0001] Created link: frr-1:eth2 <--> frr-3:eth2     
INFO[0001] Created link: frr-3:eth3 <--> pc-2:eth1      
INFO[0001] Created link: frr-1:eth3 <--> pc-1:eth1      
INFO[0001] Adding containerlab host entries to /etc/hosts file 
INFO[0001] Adding ssh config for containerlab nodes     
+---+-------------------+--------------+---------------------------------+-------+---------+-----------------+--------------+
| # |       Name        | Container ID |              Image              | Kind  |  State  |  IPv4 Address   | IPv6 Address |
+---+-------------------+--------------+---------------------------------+-------+---------+-----------------+--------------+
| 1 | clab-3-node-frr-1 | 0c3d1c97be62 | bmcdougall/frr-srv6-usid:latest | linux | running | 172.20.1.101/24 | N/A          |
| 2 | clab-3-node-frr-2 | a999b2e93f55 | bmcdougall/frr-srv6-usid:latest | linux | running | 172.20.1.102/24 | N/A          |
| 3 | clab-3-node-frr-3 | b21bab2137af | bmcdougall/frr-srv6-usid:latest | linux | running | 172.20.1.103/24 | N/A          |
| 4 | clab-3-node-pc-1  | c3ee0da37adb | praqma/network-multitool:latest | linux | running | 172.20.1.111/24 | N/A          |
| 5 | clab-3-node-pc-2  | b6e8ceb0f049 | praqma/network-multitool:latest | linux | running | 172.20.1.112/24 | N/A          |
+---+-------------------+--------------+---------------------------------+-------+---------+-----------------+--------------+
```

