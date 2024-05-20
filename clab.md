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

6. Build a Containerlab topology YAML file
