#!/bin/bash
TMP="tmps"
rm -rf ${TMP}
mkdir ${TMP}

TMP=`cd ${TMP};pwd`
HOST="hosts"
USER=""
PAWD="111111"

if [ $# == 1 ]
then
    USER=$1
elif [ $# == 2 ]
then
    USER=$1
    PAWD=$2
else
    echo "USAGE:$0 username"
    echo "USAGE:$0 username password"
    exit 1
fi

echo ${USER}" "${PAWD}


#download id_rsa.pub from every node to the tmp dir
count=1
for x in `cat ${HOST}| sed "/^#.*/d"`
do
    expect download ${USER} ${x} ${PAWD} "${TMP}/${count}"
    count=`expr $count + 1`
done

#let all id_rsa.pub into authorized_keys
count=1
for x in `ls ${TMP}/*`
do
    if [ count == 1 ]
    then
        cat ${x} > /home/${USER}/.ssh/authorized_keys
    else
        cat ${x} >> /home/${USER}/.ssh/authorized_keys
    fi
    count=`expr $count + 1`
done

#upload the authorized_keys to every node
for x in `cat ${HOST}| sed "/^#.*/d"`
do
    expect upload ${USER} ${x} ${PAWD}
done

#chmod 600 to authorized_keys
for x in `cat ${HOST}| sed "/^#.*/d"`
do
    expect priority ${USER} ${x} ${PAWD}
done

