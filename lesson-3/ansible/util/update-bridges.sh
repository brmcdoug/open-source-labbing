#/bin/bash

sudo brctl addbr xrd01-host
sudo brctl addbr xrd01-host2
sudo brctl addbr xrd02-host
sudo brctl addbr frr-4-host

sudo brctl delif frr-2-ext frr-2-eth3
sudo brctl delif frr-3-ext frr-3-eth4
sudo brctl addif frr-4-host frr-2-eth3
sudo brctl addif xrd02-host frr-3-eth4

sudo brctl delif ans-br1 frr-1-eth4
sudo brctl delif ans-br2 frr-2-eth4
sudo brctl addif xrd01-host frr-1-eth4
sudo brctl addif xrd01-host2 frr-2-eth4

sudo ifconfig xrd01-host up
sudo ifconfig xrd01-host2 up
sudo ifconfig xrd02-host up
sudo ifconfig frr-4-host up

sudo ifconfig frr-2-ext down
sudo ifconfig frr-3-ext down
sudo ifconfig ans-br1 down
sudo ifconfig ans-br2 down
sudo brctl delbr frr-2-ext 
sudo brctl delbr frr-3-ext
sudo brctl delbr ans-br1
sudo brctl delbr ans-br2