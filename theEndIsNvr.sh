#!/bin/bash

#SBATCH --time=1:00:00   # walltime limit (HH:MM:SS)
#SBATCH --nodes=1   # number of nodes
#SBATCH --ntasks-per-node=16   # 16 processor core(s) per node 
#SBATCH --job-name="ThisIsTheLoopThatNeverEnds"

while [[ 1 -eq 1 ]]
do
	echo "The end is never"
done
