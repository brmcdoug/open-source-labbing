#/bin/bash

sudo brctl addbr xrd01-host
sudo brctl addbr xrd01-host2
sudo brctl addbr xrd02-host
sudo brctl addbr frr-4-host

sudo brctl delif frr-2-external frr-2-eth3
sudo brctl delif frr-3-external frr-3-eth4
sudo brctl addif frr-4-host frr-2-eth3
sudo brctl addif xrd02-host frr-3-eth4

sudo brctl delif frr-1-xrd-1 frr-1-eth4
sudo brctl delif frr-2-xrd-1 frr-2-eth4
sudo brctl addif xrd01-host frr-1-eth4
sudo brctl addif xrd01-host2 frr-2-eth4

sudo ifconfig xrd01-host up
sudo ifconfig xrd01-host2 up
sudo ifconfig xrd02-host up
sudo ifconfig frr-4-host up

sudo ifconfig frr-2-external down
sudo ifconfig frr-3-external down
sudo ifconfig frr-1-xrd-1 down
sudo ifconfig frr-2-xrd-1 down
sudo brctl delbr frr-2-external 
sudo brctl delbr frr-3-external 
sudo brctl delbr frr-1-xrd-1
sudo brctl delbr frr-2-xrd-1