#!/bin/bash

# ssh-keygen every node
hosts="hosts"

if [ -f hosts ]
then
    echo "Start ssh free"
else
    echo "Please add hosts file"
    exit 1
fi

if [ $# != 2 ]
then
    echo "USAGE:$0 user password!"
    exit 1
else
    username=$1
    pawdname=$2
    #login every node and ssh-keygen
    for x in `cat hosts | sed "/^#.*/d"`
    do
        #echo ${x}
        if [ -f keygen ]
        then
            expect keygen ${username} ${x} ${pawdname}
        else
            echo "ssh-keygen not exists"
            echo "Please check it"
            exit 1
        fi
    done
fi


