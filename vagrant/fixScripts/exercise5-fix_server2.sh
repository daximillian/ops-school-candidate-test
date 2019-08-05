#!/bin/bash
	
# set host host key checking off and host registering off by creating an ssh config file
cat <<EOF >> /home/vagrant/.ssh/config
Host *
  StrictHostKeyChecking no
  UserKnownHostsFile=/dev/null
EOF
	
# concatinate the public key we created from server1 on synced folder to server2
cat /vagrant/.ssh/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys
# (very securly) move server1's private key created in the server1 script to server2's ssh home
mv /vagrant/.ssh/id_rsa /home/vagrant/.ssh/

# make script reusable
rm -rf /vagrant/.ssh