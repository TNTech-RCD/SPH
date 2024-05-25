#!/bin/bash -xe

#mpirun -x LD_LIBRARY_PATH --hostfile ./hostfile -np 4 -N 1 --mca btl_tcp_if_include eth0 /home/demo/bin/sph.out

hostfile=./hostfile
for p in `cat ${hostfile}`; do
  ssh "`whoami`@$p" "sudo `pwd`/blink1-tool/blink1-tool --add_udev_rules"
  echo "$p"
done
mpirun -np 4 -N 1 --hostfile ${hostfile} ./bin/sph.out
