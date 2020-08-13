import os
import shutil

# calculate the crowder number
def calculating_crowder_number(box_size = 20.0, exlude_volume_fraction = 0.3, crowder_radius = 1.0):
    box_volume = box_size*box_size*box_size
    crowder_volume = 4.0/3.0*3.14*(crowder_radius*crowder_radius*crowder_radius)
    crowder_number = box_volume*exlude_volume_fraction/crowder_volume
    print(int(crowder_number),exclude_volume_fraction,int(crowder_number)*crowder_volume/box_volume)
    return(int(crowder_number))

def writeINPUTfile(input_file = "input",crowder_radius = 1.0, diff_coeff_crowder = 1.25, crowder_mass = 1):
    read_input = open(input_file)
    file_lines = read_input.readlines()
    new_line = ''
    for line in file_lines:

        ## change the crowder radius
        if 'crowder_radius' in line:
            new_crowder_line = "crowder_radius = " + str(crowder_radius) + "\n"
            new_line += new_crowder_line
        elif 'diff_coeff_crowder' in line:
            new_crowder_line = "diff_coeff_crowder = " + str(diff_coeff_crowder) + "\n"
            new_line += new_crowder_line
        elif 'crowder_mass' in line:
            new_crowder_line = "crowder_mass = " + str(crowder_mass) + "\n"
            new_line += new_crowder_line
        else:
            new_line += line

    new_input_name = input_file
    f = open(new_input_name, "w")
    for line in new_line:
        f.write(line)
    f.close()

exclude_volume_fraction = [0.1]
crowder_radius_set = [1.0]
box_size = 20

for i in range(0, len(exclude_volume_fraction)):
    for j in range(0, len(crowder_radius_set)):
        exlude_volume = exclude_volume_fraction[i]
        crowder_radius = crowder_radius_set[j]
        diff_coeff_crowder = 1.25/crowder_radius
        crowder_mass = crowder_radius*crowder_radius*crowder_radius
        crowder_num = calculating_crowder_number(box_size, exlude_volume, crowder_radius)

        folder_name = 'crowder_'+'f'+str(exlude_volume*100)+'_r'+str(crowder_radius)
        os.mkdir(folder_name)
        
        shutil.copy('generated.dat', folder_name)
        shutil.copy('generated.top', folder_name)
        shutil.copy('input_kin', folder_name)
        shutil.copy('op.txt', folder_name)
        shutil.copy('wfile.txt', folder_name)
        shutil.copy('seq.txt', folder_name)
        shutil.copy('submit.slurm', folder_name)
        shutil.copy('input', folder_name)
        shutil.copy('input_relax', folder_name)
        shutil.copy('input_relax2', folder_name)
        os.system('cp -r FLUX %s/FLUX' %(folder_name))
        os.system('cp -r I0I1 %s/I0I1' % (folder_name))
        os.system('cp -r I1IF %s/I1IF' % (folder_name))
        os.chdir(folder_name)
        writeINPUTfile('input_kin', crowder_radius, diff_coeff_crowder, crowder_mass)
        writeINPUTfile('input', crowder_radius, diff_coeff_crowder, crowder_mass)
        writeINPUTfile('input_relax', crowder_radius, diff_coeff_crowder, crowder_mass)
        writeINPUTfile('input_relax2', crowder_radius, diff_coeff_crowder, crowder_mass)
        command = 'python ~/GitHub/crowderoxdna/UTILS/Add_crowder_no_overlap_checking.py %d %f generated.dat generated.top' %(crowder_num,crowder_radius)
        os.system(command)
        relex1_cmd = '~/GitHub/crowderoxdna/src/bin/oxDNA input_relax'
        os.system(relex1_cmd)
        relex2_cmd = '~/GitHub/crowderoxdna/src/bin/oxDNA input_relax2'

        os.system(relex2_cmd)
        os.system('mv flux_initial.dat FLUX')
        os.system('cp input FLUX/input')
        os.system('cp input I0I1/input')
        os.system('cp input I1IF/input')
        os.system('cp generated_crowder.top FLUX/top.top')
        os.system('cp generated_crowder.top I0I1/top.top')
        os.system('cp generated_crowder.top I1IF/top.top')
        
        for j in range(1, 10):
            os.mkdir('RUN%d' % j)
            os.system('cp -r FLUX  RUN%d/' % j)
            os.system('cp -r I0I1  RUN%d/' % j)
            os.system('cp -r I1IF  RUN%d/' % j)

        os.chdir('..')
        print ('crowder_'+'f'+str(exlude_volume*100)+'_r'+str(crowder_radius)+'is complete \n')