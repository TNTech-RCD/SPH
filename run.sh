#!/bin/bash -xe

#mpirun -x LD_LIBRARY_PATH --hostfile ./hostfile -np 4 -N 1 --mca btl_tcp_if_include eth0 /home/demo/bin/sph.out
mpirun -np 4 -N 1 --hostfile ./hostfile ./bin/sph.out
