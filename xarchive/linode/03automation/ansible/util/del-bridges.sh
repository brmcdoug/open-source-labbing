#/bin/bash

sudo ifconfig frr-2-host down
sudo ifconfig frr-3-host down

sudo brctl delbr frr-2-host
sudo brctl delbr frr-3-host

