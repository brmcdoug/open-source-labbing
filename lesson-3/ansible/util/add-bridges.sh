#/bin/bash

sudo brctl addbr ans-br1
sudo brctl addbr ans-br2
sudo brctl addbr frr-2-ext
sudo brctl addbr frr-3-ext

sudo ifconfig ans-br1 up
sudo ifconfig ans-br2 up
sudo ifconfig frr-2-ext up
sudo ifconfig frr-3-ext up