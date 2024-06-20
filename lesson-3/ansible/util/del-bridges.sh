#/bin/bash

sudo ifconfig ans-br1 down
sudo ifconfig ans-br2 down
sudo ifconfig frr-2-ext down
sudo ifconfig frr-3-ext down

sudo ifconfig xrd01-host down
sudo ifconfig xrd01-host2 down
sudo ifconfig xrd02-host down
sudo ifconfig frr-4-host down

sudo brctl delbr ans-br1
sudo brctl delbr ans-br2
sudo brctl delbr frr-2-ext
sudo brctl delbr frr-3-ext

sudo brctl delbr xrd01-host
sudo brctl delbr xrd01-host2
sudo brctl delbr xrd02-host
sudo brctl delbr frr-4-host

