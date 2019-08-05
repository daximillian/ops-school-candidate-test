#!/bin/bash

#set destination path, files to copy
DEST=${!#}		#get last agrgumet
files=( "$@" )  #get all arguments

dest_host="" #not necessary, just nice

#remove the destinstion path from the files list
unset "files[${#files[@]}-1]"

#set destination host to the other server
if [ $HOSTNAME == "server1" ]; then
	dest_host="server2"
else
	dest_host="server1"
fi

#rsyn with SSH because scp doesn't show output. Tail and AWK for number of bytes copied. 
rsync -avz -e "ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -q" --progress ${files[@]} $USER@$dest_host:$DEST  |tail -1 | awk '{print $4}'
