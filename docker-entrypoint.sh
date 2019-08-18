#!/bin/bash
# NODES=$1
#192.15.123.232:1234,123.15.123.232:1234
# echo $NODES
# echo  111111111111111111111111111111111111111111111111
set -e

output='/etc/libapache2-mod-jk/workers.properties'
 
rm -f $output

echo worker.list=loadbalancer > $output
 


seq=0
balance_workers=''
if [ ! -z "$NODES" ]; then
  
    IFS=',' read -r -a ADDR <<< "$NODES"
    for i in "${ADDR[@]}"; do
        seq=$((seq+1)) 
        
        echo worker.node${seq}_worker.type=ajp13 >> $output

        IFS=':' read -r -a NODE <<< "$i"
        echo worker.node${seq}_worker.host=${NODE[0]} >> $output
        echo worker.node${seq}_worker.port=${NODE[1]} >> $output
 
        # for j in "${NODE[@]}"; do
        #     echo "$j"  

        balance_workers=node${seq}_worker,$balance_workers
        # done
        echo  >> $output
        echo  >> $output
    done

fi

echo worker.loadbalancer.type=lb >> $output
echo worker.loadbalancer.balance_workers=$balance_workers >> $output



exec "$@"