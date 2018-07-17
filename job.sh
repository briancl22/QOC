#!/bin/bash
#PBS -V
#PBS -N gsandtd
#PBS -j oe
#PBS -l nodes=1:ppn=6
#PBS -l walltime=0:01:00:00
#PBS -q express
#PBS -m abe -M brian.leininger@okstate.edu

cd $PBS_O_WORKDIR

module load intelmpi/5.0.2
module load fftw/3.3.5-intelmpi
module load gsl/1.16
module load libxc/2.2.1-intelmpi

#---------------------------------------------------------------------------------------------------------------------------------------
# Groundstate Job

echo 'gs_Started' >> STATUSV
date >> STATUSV
NP=`cat $PBS_NODEFILE | wc -l`

cp inp_gs  inp

mpirun -np ${NP} /project01/borundagroup/local_octopus/octopus-7.2/mpicc/bin/octopus < inp > gs.log

echo gs_Done >> STATUSV
date >> STATUSV

#---------------------------------------------------------------------------------------------------------------------------------------
# Time-Dependent Job

echo 'td_Started' >> STATUSV
date >> STATUSV
NP=`cat $PBS_NODEFILE | wc -l`

cp inp_td  inp

mpirun -np ${NP} /project01/borundagroup/local_octopus/octopus-7.2/mpicc/bin/octopus < inp > td.log

echo td_Done >> STATUSV
date >> STATUSV
