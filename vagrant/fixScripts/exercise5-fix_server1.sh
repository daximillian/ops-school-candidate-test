#!/bin/bash
	
# set host host key checking off and host registering off by creating an ssh config file
cat <<EOF >> /home/vagrant/.ssh/config
Host *
  StrictHostKeyChecking no
  UserKnownHostsFile=/dev/null
EOF
	
# create an ssh key with no passphrase
su - vagrant -c "ssh-keygen -t rsa -N '""' -f /home/vagrant/.ssh/id_rsa"

# concatinate the key we just created, authenticating server1 to itself, 
# to allow server2 to ssh to server1 using the same private key 
# with no password. Note that if server2 was active at the time we could have just copied the keys
# and used ssh-agent to manage them. 
cat /home/vagrant/.ssh/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys

# copy private and public key for use of server2, placing them in the synced /vagrant directory
mkdir /vagrant/.ssh
cp /home/vagrant/.ssh/id_rsa* /vagrant/.ssh/