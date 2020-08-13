for i in {1..5}; do cat RUN$i/FLUX/success_* | grep t | gawk '{m += $3; c += 1}END{print c/m}';done > kin_FLUX.txt
for i in {1..5}; do cat RUN$i/I0I1/ffs.log | grep success_prob | gawk '{print $7}';done > kin_I0I1.txt
for i in {1..5}; do cat RUN$i/I1IF/ffs.log | grep success_prob | gawk '{print $7}';done > kin_I1IF.txt
