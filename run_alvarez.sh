#!/bin/bash -l
#SBATCH -C gpu
#SBATCH -q debug
#SBATCH -t 00:10:00
#SBATCH -J LAMMPS_SNAP
#SBATCH -o LAMMPS_SNAP.o%j
#SBATCH -A nstaff
#SBATCH -N 1
#SBATCH --ntasks-per-node=1
#SBATCH -c 10
#SBATCH --gpus-per-task=1
#SBATCH --gpu-bind=none

module load PrgEnv-gnu

export MPICH_GPU_SUPPORT_ENABLED=1

#backend=ompt
backend=cuda

# If its the OpenMPTarget backend, load the llvm/16 module
if [ "$backend" = "ompt" ]; then
    module load llvm/16
fi

lammps_install=/ascratch/sd/r/rgayatri/EXAALT/lammps-ompt/AMPERE80/

# This is needed if LAMMPS is built using cmake.
export LD_LIBRARY_PATH=${lammps_install}/${backend}/lib64:$LD_LIBRARY_PATH


exe=lmp_${backend}

gpus_per_node=$SLURM_NTASKS_PER_NODE

input="-k on g $gpus_per_node -sf kk -pk kokkos newton on neigh half -in in.snap.test -var nsteps 100 -var nx 100 -var ny 100 -var nz 10 -var snapdir 2J14_W.SNAP/"

command="srun -n $SLURM_NTASKS ./$exe $input"

echo $command

$command
