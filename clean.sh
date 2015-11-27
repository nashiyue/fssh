#!/bin/bash
if [ $# != 1 ]
then
    echo "USAGE:$0 username"
    exit 1
fi

USER=$1
HOSTS="hosts"

for x in `cat ${HOSTS}| sed "/^#.*/d"`
do
    echo ${x}
    ssh ${USER}@${x} "rm /home/${USER}/.ssh/authorized_keys"
done
