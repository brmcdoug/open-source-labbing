#/bin/bash

sudo brctl addbr ans-br1
sudo brctl addbr ans-br2
sudo brctl addbr frr-2-ext
sudo brctl addbr frr-3-ext

# sudo ip addr add 10.10.92.2/24 dev frr-2-host
# sudo ip addr add 10.10.93.2/24 dev frr-3-host

sudo ifconfig frr-1-host up
sudo ifconfig frr-2-host up
sudo ifconfig frr-2-external up
sudo ifconfig frr-3-external up