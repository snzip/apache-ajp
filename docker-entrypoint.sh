#!/bin/bash
# NODES=PPM_MULTINODE:16.186.78.162:25202,PPM_MULTINODE2:16.186.78.162:25302,PPM_MULTINODE3:16.186.77.158:25402,PPM_MULTINODE4:16.186.77.158:25502

set -e

output='/etc/libapache2-mod-jk/workers.properties'
# output='workers.properties'
 
rm -f $output

echo worker.list=loadbalancer > $output
 


seq=0
balance_workers=''
if [ ! -z "$NODES" ]; then
  
    IFS=',' read -r -a ADDR <<< "$NODES"
    for i in "${ADDR[@]}"; do
        seq=$((seq+1)) 
        
        IFS=':' read -r -a NODE <<< "$i"
        echo worker.${NODE[0]}.type=ajp13 >> $output
        echo worker.${NODE[0]}.host=${NODE[1]} >> $output
        echo worker.${NODE[0]}.port=${NODE[2]} >> $output 
 
        # for j in "${NODE[@]}"; do
        #     echo "$j"  

        balance_workers=${NODE[0]},$balance_workers
        # done
        echo  >> $output
        echo  >> $output
    done

fi

echo worker.loadbalancer.type=lb >> $output
echo worker.loadbalancer.balance_workers=$balance_workers >> $output 


exec "$@"