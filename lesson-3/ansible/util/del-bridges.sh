#/bin/bash

sudo ifconfig frr-1-xrd-1 down
sudo ifconfig frr-2-xrd-1 down
sudo ifconfig frr-2-external down
sudo ifconfig frr-3-external down

sudo brctl delbr frr-1-xrd-1
sudo brctl delbr frr-2-xrd-1
sudo brctl delbr frr-2-external
sudo brctl delbr frr-3-external

