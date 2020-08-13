#!/bin/bash

#SBATCH -p sulccpu1                                                        
#SBATCH -q sulcgpu1
#SBATCH -n 1                        # number of cores
#SBATCH -c 25
#SBATCH -t 00-05:00                  # wall time (D-HH:MM)
#SBATCH -A psulc                   # Account hours will be pulled from (commented out with double # in front)
#SBATCH -o slurm.%j.out             # STDOUT (%j = JobId)
#SBATCH -e slurm.%j.err             # STDERR (%j = JobId)
#SBATCH --mail-type=ALL             # Send a notification when the job starts, stops, or fails
#SBATCH --mail-user=myaddress@asu.edu # send-to address

module load gcc/4.9.4

python ffs_flux.py -c 25 -n 1000 -v
