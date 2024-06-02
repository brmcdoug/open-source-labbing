### ISIS and BGP configurations for Lesson 2

#### frr-1
```
interface eth1
 ip router isis 1
exit
!
interface eth2
 ip router isis 1
exit
! 
interface lo
 ip router isis 1
exit
!
router bgp 65000
 bgp router-id 10.0.0.1
 bgp log-neighbor-changes
 no bgp ebgp-requires-policy
 no bgp default ipv4-unicast
 bgp bestpath as-path multipath-relax
 !
 neighbor 10.0.0.2 remote-as 65000
 neighbor 10.0.0.2 update-source lo
 neighbor 10.0.0.3 remote-as 65000
 neighbor 10.0.0.3 update-source lo
 !
 address-family ipv4 unicast
  network 10.0.0.1/32
  network 10.10.1.0/24
  neighbor 10.0.0.2 activate
  neighbor 10.0.0.3 activate
 exit-address-family
exit
!
router isis 1
 is-type level-2-only
 net 49.0001.0000.0000.0001.00
exit
exit
```

#### frr-2
```
interface eth1
 ip router isis 1
exit
!
interface eth2
 ip router isis 1
exit
!
interface lo
 ip router isis 1
exit
!
router bgp 65000
 bgp router-id 10.0.0.2
 bgp log-neighbor-changes
 no bgp ebgp-requires-policy
 no bgp default ipv4-unicast
 bgp bestpath as-path multipath-relax
 !
 neighbor 10.0.0.1 remote-as 65000
 neighbor 10.0.0.1 update-source lo
 neighbor 10.0.0.3 remote-as 65000
 neighbor 10.0.0.3 update-source lo
 !
 address-family ipv4 unicast
  network 10.0.0.2/32
  neighbor 10.0.0.1 activate
  neighbor 10.0.0.3 activate
 exit-address-family
exit
router isis 1
 is-type level-2-only
 net 49.0001.0000.0000.0002.00
exit
exit
```

#### frr-3
```
interface eth1
 ip router isis 1
exit
!
interface eth2
 ip router isis 1
exit
!
interface lo
 ip router isis 1
exit
!
router bgp 65000
 bgp router-id 10.0.0.3
 bgp log-neighbor-changes
 no bgp ebgp-requires-policy
 no bgp default ipv4-unicast
 bgp bestpath as-path multipath-relax
 !
 neighbor 10.0.0.1 remote-as 65000
 neighbor 10.0.0.1 update-source lo
 neighbor 10.0.0.2 remote-as 65000
 neighbor 10.0.0.2 update-source lo
 !
 address-family ipv4 unicast
  network 10.0.0.3/32
  network 10.10.2.0/24
  neighbor 10.0.0.1 activate
  neighbor 10.0.0.2 activate
 exit-address-family
exit
router isis 1
 is-type level-2-only
 net 49.0001.0000.0000.0003.00
exit
exit
```
