#!/bin/bash -xe
nodes=(demo00 demo01 demo02 demo03 demo04 demo05 demo06 demo07 demo08)

for n in ${nodes[*]}; do
    ssh ${n} "mkdir -p ~/bin/"  
    scp ./bin/sph.out ./blink1-tool/libblink1.so ${n}:~/bin/ &
done
wait

export LD_LIBRARY_PATH=$LD_RUN_PATH:/home/demo/bin/
mpirun -x LD_LIBRARY_PATH --hostfile ~/mpihostfilebig -np 9 -N 1 --mca btl_tcp_if_include eth0 valgrind --tool=callgrind  /home/demo/bin/sph.out
#mpirun -np 9 -N 1 valgrind /home/demo/bin/sph.out
