
for i in {1..6}; do cd crowder_f10.0_r1.0/RUN$i/FLUX; sbatch submit.slurm;cd ../../..;done
for i in {1..6}; do cd crowder_f10.0_r3.0/RUN$i/FLUX; sbatch submit.slurm;cd ../../..;done
for i in {1..6}; do cd crowder_f30.0_r1.0/RUN$i/FLUX; sbatch submit.slurm;cd ../../..;done
for i in {1..6}; do cd crowder_f30.0_r3.0/RUN$i/FLUX; sbatch submit.slurm;cd ../../..;done

for i in {1..6}; do cd crowder_f10.0_r1.0/RUN$i/I0I1; sbatch submit.slurm;cd ../../..;done
for i in {1..6}; do cd crowder_f10.0_r3.0/RUN$i/I0I1; sbatch submit.slurm;cd ../../..;done
for i in {1..6}; do cd crowder_f30.0_r1.0/RUN$i/I0I1; sbatch submit.slurm;cd ../../..;done
for i in {1..6}; do cd crowder_f30.0_r3.0/RUN$i/I0I1; sbatch submit.slurm;cd ../../..;done

for i in {1..6}; do cd crowder_f10.0_r1.0/RUN$i/I1IF; sbatch submit.slurm;cd ../../..;done
for i in {1..6}; do cd crowder_f10.0_r3.0/RUN$i/I1IF; sbatch submit.slurm;cd ../../..;done
for i in {1..6}; do cd crowder_f30.0_r1.0/RUN$i/I1IF; sbatch submit.slurm;cd ../../..;done
for i in {1..6}; do cd crowder_f30.0_r3.0/RUN$i/I1IF; sbatch submit.slurm;cd ../../..;done
