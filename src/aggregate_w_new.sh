#!/bin/bash
#$ -l nc=4
#$ -p -50
#$ -r yes
#$ -q node.q

#SBATCH -n 4
#SBATCH --nice=50
#SBATCH --requeue
#SBATCH -p node03-06
SLURM_RESTART_COUNT=2

args=("$@")
len=${#args[@]}
INFILES=("${args[@]:0:len-1}")
OUTFILE=("${args[len-1]}")

cat ${INFILES[@]} > $OUTFILE