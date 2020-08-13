

import glob
import os


folder_list = []
for folder_name in glob.glob("crowder_f*"):
        foler_list_name = folder_name+'/'
        folder_list.append(foler_list_name)

for simulation_name in folder_list:
    print('\n\n')
    print('## Calculating simulation'+simulation_name)

    os.chdir(simulation_name)
    flux_cal = 'for i in {1..5}; do cat RUN$i/FLUX/success_* | grep t | gawk \'{m += $3; c += 1}END{print c/m}\';done > kin_FLUX.txt'
    I0I1_cal = 'for i in {1..5}; do cat RUN$i/I0I1/ffs.log | grep success_prob | gawk \'{print $7}\';done > kin_I0I1.txt'
    I1IF_cal = 'for i in {1..5}; do cat RUN$i/I1IF/ffs.log | grep success_prob | gawk \'{print $7}\';done > kin_I1IF.txt'

    os.system(flux_cal)
    os.system(I0I1_cal)
    os.system(I1IF_cal)

    os.system('cat kin_FLUX.txt')
    os.system('cat kin_I0I1.txt')
    os.system('cat kin_I1IF.txt')

    os.chdir('..')