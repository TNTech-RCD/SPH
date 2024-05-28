#!/bin/bash -xe

hostfile=./hostfile
# validate ssh fingerprints and ensure blink light tools work
for p in `cat ${hostfile}`; do
  ssh "`whoami`@$p" "sudo `pwd`/blink1-tool/blink1-tool --add_udev_rules" &
done
wait

# starts a number of process equal to size of hostfile
mpirun -np `cat hostfile | wc -l` -N 1 --hostfile ${hostfile} --mca btl_tcp_if_include eth0  ./bin/sph.out


#mpirun -np `wc -l $hostfile` -N 1 --hostfile ${hostfile} ./bin/sph.out
#mpirun -x LD_LIBRARY_PATH --hostfile ./hostfile -np 4 -N 1 --mca btl_tcp_if_include eth0 /home/demo/bin/sph.out

