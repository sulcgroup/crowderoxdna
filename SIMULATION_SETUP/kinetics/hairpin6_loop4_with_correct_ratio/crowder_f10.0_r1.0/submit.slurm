#!/bin/bash

#SBATCH -p sulccpu1
#SBATCH -q sulcgpu1
#SBATCH -n 1                        # number of cores
#SBATCH -c 28
#SBATCH -t 14-00:00                  # wall time (D-HH:MM)
#SBATCH -A psulc                   # Account hours will be pulled from (commented out with double # in front)
#SBATCH -o slurm.%j.out             # STDOUT (%j = JobId)
#SBATCH -e slurm.%j.err             # STDERR (%j = JobId)
#SBATCH --mail-type=ALL             # Send a notification when the job starts, stops, or fails
#SBATCH --mail-user=hongfan0911@gmail.com # send-to address

module load gcc/4.9.4

python ffs_flux.py -c 28 -n 1000 -v
