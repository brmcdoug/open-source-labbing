#/bin/bash

sudo ifconfig frr-1-xrd-1 down
sudo ifconfig frr-2-xrd-1 down
sudo ifconfig frr-2-external down
sudo ifconfig frr-3-external down

sudo ifconfig xrd01-host down
sudo ifconfig xrd01-host2 down
sudo ifconfig xrd02-host down
sudo ifconfig frr-4-host down

sudo brctl delbr frr-1-xrd-1
sudo brctl delbr frr-2-xrd-1
sudo brctl delbr frr-2-external
sudo brctl delbr frr-3-external

sudo brctl delbr xrd01-host
sudo brctl delbr xrd01-host2
sudo brctl delbr xrd02-host
sudo brctl delbr frr-4-host

