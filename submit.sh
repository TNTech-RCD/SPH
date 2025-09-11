#!/bin/bash

if [ -z $SLURM_JOB_NODELIST ]; then
	echo "Run me as a slurm job!"
	exit
fi

if [ $SLURM_PROCID == 0 ]; then
	if [ -z $1 ] || [ -z $SLURM_NTASKS_PER_NODE ]; then
		echo "Usage: srun --ntasks-per-node <ntasks-per-node> ./submit.sh <display_node>"
		echo "	Where 'display_node' is the hostname of the node with a graphical environemt"
		exit
	fi

	display_node=$1

	echo "rank 0=${display_node} slot=0" | tee rankfile

	ranks_to_assign=$((${SLURM_NTASKS}-1))

	nodelist_raw=$(scontrol show hostnames $SLURM_JOB_NODELIST)
	readarray -t nodelist <<<"$nodelist_raw"
	nodelist_index=0

	current_node_task=0
	display_node_skipped="false"

	for i in $(seq 1 $ranks_to_assign); do
		if [ $current_node_task == $SLURM_NTASKS_PER_NODE ]; then
			nodelist_index=$((nodelist_index+1))
			current_node_task=0
		fi
		if [ ${nodelist[${nodelist_index}]} == $display_node ] && [ $display_node_skipped == "false" ]; then
			current_node_task=$((${current_node_task}+1))
			display_node_skipped="true"
		fi

		echo "rank ${i}=${nodelist[${nodelist_index}]} slot=${current_node_task}" | tee -a rankfile
		
		current_node_task=$((${current_node_task}+1))
	done

	mpirun --map-by rankfile:file=./rankfile -n $SLURM_NTASKS ${SLURM_SUBMIT_DIR}/bin/sph.out
fi 
