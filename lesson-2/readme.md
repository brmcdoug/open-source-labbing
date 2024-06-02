### Using Containerlab to Build and Launch a Basic Topology

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
#### Containerlab install

1. [Containerlab installation instructions](https://containerlab.dev/install/)

2. Run install script:
```
bash -c "$(curl -sL https://get.containerlab.dev)"
```

3. Output
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

#### Acquire router image(s)

1. We'll use a somewhat custom FRR image which can be pulled from here:
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

#### Containerlab Topology YAML

1. Build a Containerlab topology YAML file: [lesson-2-topo.yaml](lesson-2-topo.yaml)
   *Note:* the topology file includes specific parameters for starting both FRR and SSHD and for applying FRR configurations

2. Define router configurations:  [config](config)
   
   * FRR has both an frr.conf file where router interfaces and features are defined and configure, and a 'daemons' file where specific routing daemons such as OSPF may be enabled or disabled. Containerlab uses the 'binds' syntax in the base-topo.yaml to copy local files to a specific location in the FRR containers once they come up:
   ```
      binds:
      - config/frr-3/daemons:/etc/frr/daemons
      - config/frr-3/frr-3.conf:/etc/frr/frr.conf
   ```

   * The base-topo.yaml file includes a pair of lines instructing containerlab to issue a pair of commands to start both the FRR and SSHd services after the container comes up:
   ```
      exec: 
      - sudo /usr/lib/frr/frr start
      - sudo service ssh start
   ```

3. Deploy the topology: 
```
sudo containerlab deploy -t lesson-2-topo.yaml 
```

Example output:
```
cisco@topology-host:~/open-source-labbing/lesson-2$ sudo containerlab deploy -t lesson-2-topo.yaml 
INFO[0000] Containerlab v0.48.6 started                 
INFO[0000] Parsing & checking topology file: lesson-2-topo.yaml 
INFO[0000] Creating docker network: Name="frr_mgt_net", IPv4Subnet="172.20.1.0/24", IPv6Subnet="", MTU='ל' 
INFO[0000] Creating lab directory: /home/cisco/open-source-labbing/lesson-2/clab-oslab 
INFO[0000] Creating container: "pc-2"                   
INFO[0000] Creating container: "frr-3"                  
INFO[0000] Creating container: "frr-1"                  
INFO[0000] Creating container: "frr-2"                  
INFO[0000] Creating container: "pc-1"                   
INFO[0001] Creating link: frr-2:eth2 <--> frr-3:eth1    
INFO[0001] Creating link: frr-1:eth1 <--> frr-2:eth1    
INFO[0002] Creating link: frr-1:eth2 <--> frr-3:eth2    
INFO[0002] Creating link: frr-3:eth3 <--> pc-2:eth1     
INFO[0002] Creating link: frr-1:eth3 <--> pc-1:eth1     
INFO[0002] Adding containerlab host entries to /etc/hosts file 
INFO[0002] Adding ssh config for containerlab nodes     
INFO[0010] Executed command "sudo /usr/lib/frr/frr start" on the node "frr-1". stdout:
starting staticd since zebra is running[45|mgmtd] sending configuration
[46|zebra] sending configuration
[62|staticd] sending configuration
Waiting for children to finish applying config...
Exiting from the script 
INFO[0010] Executed command "sudo service ssh start" on the node "frr-1". stdout:
 * Starting OpenBSD Secure Shell server sshd
   ...done. 
INFO[0010] Executed command "sudo /usr/lib/frr/frr start" on the node "frr-2". stdout:
starting staticd since zebra is running[67|mgmtd] sending configuration
[68|zebra] sending configuration
[74|bgpd] sending configuration
[75|isisd] sending configuration
[84|staticd] sending configuration
Waiting for children to finish applying config...
Exiting from the script 
INFO[0010] Executed command "sudo service ssh start" on the node "frr-2". stdout:
 * Starting OpenBSD Secure Shell server sshd
   ...done. 
INFO[0010] Executed command "sudo /usr/lib/frr/frr start" on the node "frr-3". stdout:
starting staticd since zebra is running[67|mgmtd] sending configuration
[68|zebra] sending configuration
[74|bgpd] sending configuration
[75|isisd] sending configuration
[84|staticd] sending configuration
Waiting for children to finish applying config...
Exiting from the script 
INFO[0010] Executed command "sudo service ssh start" on the node "frr-3". stdout:
 * Starting OpenBSD Secure Shell server sshd
   ...done. 
INFO[0010] 🎉 New containerlab version 0.54.2 is available! Release notes: https://containerlab.dev/rn/0.54/#0542
Run 'containerlab version upgrade' to upgrade or go check other installation options at https://containerlab.dev/install/ 
+---+------------------+--------------+---------------------------------+-------+---------+-----------------+--------------+
| # |       Name       | Container ID |              Image              | Kind  |  State  |  IPv4 Address   | IPv6 Address |
+---+------------------+--------------+---------------------------------+-------+---------+-----------------+--------------+
| 1 | clab-oslab-frr-1 | b6c4a10c2e7b | bmcdougall/frr-srv6-usid:1.4    | linux | running | 172.20.1.101/24 | N/A          |
| 2 | clab-oslab-frr-2 | f5d2562aeb62 | bmcdougall/frr-srv6-usid:1.4    | linux | running | 172.20.1.102/24 | N/A          |
| 3 | clab-oslab-frr-3 | 24ebb8484b3e | bmcdougall/frr-srv6-usid:1.4    | linux | running | 172.20.1.103/24 | N/A          |
| 4 | clab-oslab-pc-1  | 6712768d3834 | praqma/network-multitool:latest | linux | running | 172.20.1.111/24 | N/A          |
| 5 | clab-oslab-pc-2  | d512975ea294 | praqma/network-multitool:latest | linux | running | 172.20.1.112/24 | N/A          |
+---+------------------+--------------+---------------------------------+-------+---------+-----------------+--------------+
```

A couple useful commands once the topology has been deployed:
```
sudo containerlab inspect -a
```
Outputs a table much like the one the terminal outputs on deployment complete

```
docker ps
```
Lists the running containers on the node

#### Accessing nodes in the topology

1. Once the topology is deployed we have options for accessing the router nodes:

   1. docker exec directory into vtysh, or into bash then invoke the FRR CLI:
```
docker exec -it clab-oslab-frr-1 vtysh
or
docker exec -it clab-oslab-frr-1 bash
then
vtysh
```

Output:
```
cisco@topology-host:~/open-source-labbing/lesson-2$ docker exec -it clab-oslab-frr-1 bash
frr@frr-1:/$ vtysh

Hello, this is FRRouting (version 9.1-dev-my-manual-build).
Copyright 1996-2005 Kunihiro Ishiguro, et al.

frr-1# 
```

   2. The other option is ssh (user/pw = frr/frr123)
```
ssh frr@clab-oslab-frr-1 
```

2. FRR's vty shell can be accessed from either the docker exec session or the ssh session:

```
vtysh
```

Output:
```
frr@frr-1:~$ vtysh

Hello, this is FRRouting (version 9.1-dev-my-manual-build).
Copyright 1996-2005 Kunihiro Ishiguro, et al.

frr-1# 
```

*Note:* The FRR nodes should have booted with minimal config - interfaces with IPs and descriptions

#### Validate connectivity
1. vtysh into any of the FRR nodes and ping its neighbors:

```
frr-1# ping 10.1.1.1
PING 10.1.1.1 (10.1.1.1) 56(84) bytes of data.
64 bytes from 10.1.1.1: icmp_seq=1 ttl=64 time=0.247 ms
^C
```

*Note:* the "client" linux nodes connected to our topology don't have IP addresses

#### FRR daemons
FRR's modular structure allows the operator to select which feature sets to turn on and off. These capabilities are found in FRR's 'daemons' file found at /etc/frr/daemons

For lesson-2 in this lab we've enabled both the isisd and bgpd daemons on frr-2 and frr-3, so those two routers are ready for protocol configuration. At the same time we've left isisd and bgpd off on frr-1. In order to configure frr-1 we need to enable the two daemons and restart frr-1

1. ssh to frr-1
```
ssh frr@clab-oslab-frr-1 
pw = frr123
```

2. edit the /etc/frr/daemons file and change isisd and bgpd to 'yes'
```
bgpd=yes
isisd=yes
```

3. restart frr
```
sudo /usr/lib/frr/frr restart
```

Example output:
```
frr@frr-1:~$ sudo /usr/lib/frr/frr restart
Stopping Frr monitor daemon: (watchfrr).
Stopping Frr daemons (prio:0): (bgpd) (isisd)Stopping staticd since zebra is running (ripd) (ripngd) (ospfd) (ospf6d) (babeld) (pimd) (pim6d) (ldpd) (nhrpd) (eigrpd) (sharpd) (pbrd) (staticd) (bfdd) (fabricd) (vrrpd) (pathd).
Stopping other frr daemons/usr/lib/frr/ssd: warning: failed to kill 52: No such process
./usr/lib/frr/ssd: warning: failed to kill 64: No such process
..
Removing remaining .vty files.
Exiting from the script
2024/06/02 02:56:05 ZEBRA: [NNACN-54BDA][EC 4043309110] Disabling MPLS support (no kernel support)
starting staticd since zebra is running2024/06/02 02:56:05 ISIS: [ZKB8W-3S2Q4][EC 100663330] unneeded 'destroy' callback for '/frr-isisd:isis/instance/segment-routing-srv6/msd/node-msd/max-segs-left'
2024/06/02 02:56:05 ISIS: [ZKB8W-3S2Q4][EC 100663330] unneeded 'destroy' callback for '/frr-isisd:isis/instance/segment-routing-srv6/msd/node-msd/max-end-pop'
2024/06/02 02:56:05 ISIS: [ZKB8W-3S2Q4][EC 100663330] unneeded 'destroy' callback for '/frr-isisd:isis/instance/segment-routing-srv6/msd/node-msd/max-h-encaps'
2024/06/02 02:56:05 ISIS: [ZKB8W-3S2Q4][EC 100663330] unneeded 'destroy' callback for '/frr-isisd:isis/instance/segment-routing-srv6/msd/node-msd/max-end-d'
[305|mgmtd] sending configuration
[306|zebra] sending configuration
[312|bgpd] sending configuration
[313|isisd] sending configuration
[305|mgmtd] done
[322|staticd] sending configuration
Waiting for children to finish applying config...
[322|staticd] done
[306|zebra] done
[312|bgpd] done
[313|isisd] done
Exiting from the script
Exiting from the script
```

#### Configure ISIS and BGP 

1. Note, per https://docs.frrouting.org/en/latest/setup.html
   the default the FRR Daemons file has nothing enabled

   Thus, if we attempt to configure routing protocols we'll get something like this:

   ```
   frr@frr-1:~$ vtysh

   Hello, this is FRRouting (version 9.1-dev-my-manual-build).
   Copyright 1996-2005 Kunihiro Ishiguro, et al.

   frr-1# conf t
   frr-1(config)# router bgp 65000
   bgpd is not running
   frr-1(config-router)# 
   ```

2. Exit from vtysh and edit /etc/frr/daemons to enable protocols; change isisd and bgpd from 'no' to 'yes'
   *Note:* for the sake of brevity isisd and bgpd are already enabled on frr nodes 2 and 3

```
sudo vi /etc/frr/daemons 
```

1. Restart FRR
```
sudo /usr/lib/frr/frr restart
```

Truncated output:
```
[297|staticd] sending configuration
Waiting for children to finish applying config...
[297|staticd] done
[281|zebra] done
[287|bgpd] done
[288|isisd] done
Exiting from the script
Exiting from the script
```

4. Re-enter vtysh and apply configs found [here](lesson-2-quick-config.md)
   *Note:* this particular FRR images wants you to login to vtysh with sudo in order to save configs

```
sudo vtysh
```

5. Validate ISIS and RIB
```
show isis neighbor
show isis database
show isis route
show route
```

Example output:
```
frr-2# sho isis neigh
Area 1:
  System Id           Interface   L  State        Holdtime SNPA
 frr-1               eth1        2  Up            30       aac1.abd9.41a1
 frr-3               eth2        2  Up            28       aac1.ab54.4471
 frr-2# 
frr-2# sho isis database 
Area 1:
IS-IS Level-2 link-state database:
LSP ID                  PduLen  SeqNumber   Chksum  Holdtime  ATT/P/OL
frr-1.00-00               108   0x00000005  0x535d    1019    0/0/0
frr-1.b9-00                51   0x00000001  0x848d     983    0/0/0
frr-1.bb-00                51   0x00000001  0x8a84     979    0/0/0
frr-2.00-00          *    108   0x00000002  0x0c9d    1019    0/0/0
frr-2.bd-00          *     51   0x00000001  0x7d8d     982    0/0/0
frr-3.00-00               108   0x00000003  0x2c73    1019    0/0/0
    6 LSPs

frr-2# 
```

6. Validate BGP sessions are up and prefixes are being exchanged
```
show bgp summary
show bgp ipv4 unicast
```

Example output:
```
frr-1# show bgp summary

IPv4 Unicast Summary (VRF default):
BGP router identifier 10.0.0.1, local AS number 65000 vrf-id 0
BGP table version 5
RIB entries 9, using 864 bytes of memory
Peers 2, using 52 KiB of memory

Neighbor        V         AS   MsgRcvd   MsgSent   TblVer  InQ OutQ  Up/Down State/PfxRcd   PfxSnt Desc
10.0.0.2        4      65000        11        10        5    0    0 00:00:58            1        2 FRRouting/9.1-dev-my
10.0.0.3        4      65000        12        12        5    0    0 00:00:14            2        2 FRRouting/9.1-dev-my

Total number of neighbors 2
frr-1# 

frr-1# show bgp ipv4 unicast 
BGP table version is 5, local router ID is 10.0.0.1, vrf id 0
Default local pref 100, local AS 65000
Status codes:  s suppressed, d damped, h history, * valid, > best, = multipath,
               i internal, r RIB-failure, S Stale, R Removed
Nexthop codes: @NNN nexthop's vrf id, < announce-nh-self
Origin codes:  i - IGP, e - EGP, ? - incomplete
RPKI validation codes: V valid, I invalid, N Not found

    Network          Next Hop            Metric LocPrf Weight Path
 *> 10.0.0.1/32      0.0.0.0                  0         32768 i
   i10.0.0.2/32      10.0.0.2                 0    100      0 i
   i10.0.0.3/32      10.0.0.3                 0    100      0 i
 *> 10.10.1.0/24     0.0.0.0                  0         32768 i
 *>i10.10.2.0/24     10.0.0.3                 0    100      0 i

Displayed  5 routes and 5 total paths
frr-1# 
```

7. Validate BGP reachability

Example from frr-1
```
ping 10.0.0.2
ping 10.0.0.3
```

### End of Lesson-2


















