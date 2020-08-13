
for i in {1..5}; do cd crowder_f10.0_r1.0/RUN$i/I1IF; sbatch submit.slurm;cd ../../..;done
for i in {1..5}; do cd crowder_f10.0_r2.0/RUN$i/I1IF; sbatch submit.slurm;cd ../../..;done
for i in {1..5}; do cd crowder_f10.0_r3.0/RUN$i/I1IF; sbatch submit.slurm;cd ../../..;done

for i in {1..5}; do cd crowder_f20.0_r1.0/RUN$i/I1IF; sbatch submit.slurm;cd ../../..;done
for i in {1..5}; do cd crowder_f20.0_r2.0/RUN$i/I1IF; sbatch submit.slurm;cd ../../..;done
for i in {1..5}; do cd crowder_f20.0_r3.0/RUN$i/I1IF; sbatch submit.slurm;cd ../../..;done

for i in {1..5}; do cd crowder_f30.0_r1.0/RUN$i/I1IF; sbatch submit.slurm;cd ../../..;done
for i in {1..5}; do cd crowder_f30.0_r2.0/RUN$i/I1IF; sbatch submit.slurm;cd ../../..;done
for i in {1..5}; do cd crowder_f30.0_r3.0/RUN$i/I1IF; sbatch submit.slurm;cd ../../..;done

for i in {1..5}; do cd crowder_f40.0_r1.0/RUN$i/I1IF; sbatch submit.slurm;cd ../../..;done
for i in {1..5}; do cd crowder_f40.0_r2.0/RUN$i/I1IF; sbatch submit.slurm;cd ../../..;done
for i in {1..5}; do cd crowder_f40.0_r3.0/RUN$i/I1IF; sbatch submit.slurm;cd ../../..;done

cd crowder_f10.0_r1.0
for i in {1..5}; do cat RUN$i/FLUX/success_* | grep t | gawk '{m += $3; c += 1}END{print c/m}';done > kin_FLUX.txt
cd ..

cd crowder_f20.0_r1.0
for i in {1..5}; do cat RUN$i/FLUX/success_* | grep t | gawk '{m += $3; c += 1}END{print c/m}';done > kin_FLUX.txt
cd ..

cd crowder_f30.0_r1.0
for i in {1..5}; do cat RUN$i/FLUX/success_* | grep t | gawk '{m += $3; c += 1}END{print c/m}';done > kin_FLUX.txt
cd ..

cd crowder_f40.0_r1.0
for i in {1..5}; do cat RUN$i/FLUX/success_* | grep t | gawk '{m += $3; c += 1}END{print c/m}';done > kin_FLUX.txt
cd ..

for i in {1..5}; do cat RUN$i/I0I1/ffs.log | grep success_prob | gawk '{print $7}';done > kin_I0I1.txt
for i in {1..5}; do cat RUN$i/I1IF/ffs.log | grep success_prob | gawk '{print $7}';done > kin_I1IF.txt