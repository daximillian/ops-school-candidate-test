#!/bin/bash
# create key for ssh and copy it to server 1
mkdir -m 700 ~/.ssh/id_rsa
ssh-keygen -t rsa -P "" -f ~/.ssh/id_dsa
cat $HOME/.ssh/id_dsa.pub >> $HOME/.ssh/authorized_keys
ssh-copy-id -i $HOME/.ssh/id_dsa.pub vagrant@server1

# add ssh-agent to deal with the passphrase
eval $(ssh-agent)
ssh-add ~/.ssh/id_dsa
