
for i in {1..6}; do cd crowder_mass1_diff1.25/RUN$i/FLUX; sbatch FLUX_submission.shatch submit.slurm;cd ../../..;done
for i in {1..6}; do cd crowder_mass1_diff2.5/RUN$i/FLUX; sbatch submit.slurm;cd ../../..;done
for i in {1..6}; do cd crowder_mass1_diff5/RUN$i/FLUX; sbatch submit.slurm;cd ../../..;done
for i in {1..6}; do cd crowder_mass1_diff7.5/RUN$i/FLUX; sbatch submit.slurm;cd ../../..;done

for i in {1..6}; do cd crowder_mass10_diff1.25/RUN$i/FLUX; sbatch submit.slurm;cd ../../..;done
for i in {1..6}; do cd crowder_mass20_diff1.25/RUN$i/FLUX; sbatch submit.slurm;cd ../../..;done
for i in {1..6}; do cd crowder_mass30_diff1.25/RUN$i/FLUX; sbatch submit.slurm;cd ../../..;don