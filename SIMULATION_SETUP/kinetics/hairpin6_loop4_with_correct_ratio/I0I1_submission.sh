for i in {1..9}; do cd crowder_f0_r1.0/RUN$i/I0I1; sbatch submit.slurm;cd ../../..;done
for i in {1..9}; do cd crowder_f10.0_r1.0/RUN$i/I0I1; sbatch submit.slurm;cd ../../..;done
for i in {1..9}; do cd crowder_f20.0_r1.0/RUN$i/I0I1; sbatch submit.slurm;cd ../../..;done
for i in {1..9}; do cd crowder_f30.0_r1.0/RUN$i/I0I1; sbatch submit.slurm;cd ../../..;done
for i in {1..9}; do cd crowder_f40.0_r1.0/RUN$i/I0I1; sbatch submit.slurm;cd ../../..;done