# Verify EC2 Instances #

## Access instances in the public subnets from local PC and access to the Internet ##
### my_public_instance01 - 47.128.219.68 - 10.0.1.148 ###
```
yeemon@dell:~$ ssh -i my_keypair.pem ubuntu@47.128.219.68
The authenticity of host '47.128.219.68 (47.128.219.68)' can't be established.
ED25519 key fingerprint is SHA256:uztRLtGXgQEXiND9ydfxS06r31DXNXA1dsCfjGXs0vQ.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '47.128.219.68' (ED25519) to the list of known hosts.
Welcome to Ubuntu 22.04.3 LTS (GNU/Linux 6.2.0-1017-aws x86_64)
...
ubuntu@ip-10-0-1-148:~$
ubuntu@ip-10-0-1-148:~$ ping 8.8.8.8
PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.
64 bytes from 8.8.8.8: icmp_seq=1 ttl=110 time=0.859 ms
64 bytes from 8.8.8.8: icmp_seq=2 ttl=110 time=0.898 ms
64 bytes from 8.8.8.8: icmp_seq=3 ttl=110 time=0.924 ms

--- 8.8.8.8 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2022ms
rtt min/avg/max/mdev = 0.859/0.893/0.924/0.026 ms
```

### bastion_host - 18.138.252.70 - 10.0.2.12 ###
```
yeemon@dell:~$ ssh -i my_keypair.pem ubuntu@18.138.252.70
The authenticity of host '18.138.252.70 (18.138.252.70)' can't be established.
ED25519 key fingerprint is SHA256:uouTNc0SoBlyAAeEQLcFyfjO8enk0uFzN49D9tbJ5sk.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '18.138.252.70' (ED25519) to the list of known hosts.
Welcome to Ubuntu 22.04.3 LTS (GNU/Linux 6.2.0-1017-aws x86_64)
...
ubuntu@ip-10-0-2-12:~$
ubuntu@ip-10-0-2-12:~$ ping 8.8.8.8
PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.
64 bytes from 8.8.8.8: icmp_seq=1 ttl=111 time=0.897 ms
64 bytes from 8.8.8.8: icmp_seq=2 ttl=111 time=0.926 ms
64 bytes from 8.8.8.8: icmp_seq=3 ttl=111 time=0.903 ms

--- 8.8.8.8 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2002ms
rtt min/avg/max/mdev = 0.897/0.908/0.926/0.012 ms
```

## Access instances in the private subnets from local PC ##
### my_private_instance01 - 10.0.4.177 ###
```
yeemon@dell:~$ ssh -i my_keypair.pem ubuntu@10.0.4.177
^C
```

### my_private_db_instance - 10.0.5.199 ###
```
yeemon@dell:~$ ssh -i my_keypair.pem ubuntu@10.0.5.199
^C
```

## Access instances in the private subnets from my_public_instance01 - 10.0.1.148 ##
### my_private_instance01 - 10.0.4.177 ###
```
ubuntu@ip-10-0-1-148:~$ ssh -i my_keypair.pem ubuntu@10.0.4.177
^C
```

### my_private_db_instance - 10.0.5.199 ###
```
ubuntu@ip-10-0-1-148:~$ ssh -i my_keypair.pem ubuntu@10.0.5.199
^C
```

## Access instances in the private subnets from bastion_host - 10.0.2.12 and access to the Internet ##
### my_private_instance01 - 10.0.4.177 (can access the Internet via NAT gateway) ###
```
ubuntu@ip-10-0-2-12:~$ ssh -i my_keypair.pem ubuntu@10.0.4.177
The authenticity of host '10.0.4.177 (10.0.4.177)' can't be established.
ED25519 key fingerprint is SHA256:cj7LMvUTqSEsj6Ny7sFy0Uwre47fR1Tac8+iCLO9egc.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '10.0.4.177' (ED25519) to the list of known hosts.
Welcome to Ubuntu 22.04.3 LTS (GNU/Linux 6.2.0-1017-aws x86_64)
...
ubuntu@ip-10-0-4-177:~$
ubuntu@ip-10-0-4-177:~$ ping 8.8.8.8
PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.
64 bytes from 8.8.8.8: icmp_seq=1 ttl=109 time=2.30 ms
64 bytes from 8.8.8.8: icmp_seq=2 ttl=109 time=1.69 ms
64 bytes from 8.8.8.8: icmp_seq=3 ttl=109 time=1.68 ms

--- 8.8.8.8 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2003ms
rtt min/avg/max/mdev = 1.675/1.888/2.302/0.292 ms
```

### my_private_db_instance - 10.0.5.199 (can't access the Internet because of no route to NAT gateway) ###
```
ubuntu@ip-10-0-2-12:~$ ssh -i my_keypair.pem ubuntu@10.0.5.199
The authenticity of host '10.0.5.199 (10.0.5.199)' can't be established.
ED25519 key fingerprint is SHA256:o0X4UYzpQRfXcWkQJCZMbfAbQHqAdCDbOyP3O+u8NvQ.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '10.0.5.199' (ED25519) to the list of known hosts.
Welcome to Ubuntu 22.04.3 LTS (GNU/Linux 6.2.0-1017-aws x86_64)
...
ubuntu@ip-10-0-5-199:~$ 
ubuntu@ip-10-0-5-199:~$ ping 8.8.8.8
PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.
^C
--- 8.8.8.8 ping statistics ---
11 packets transmitted, 0 received, 100% packet loss, time 10226ms
```
