import os
import shutil

# calculate the crowder number
def calculating_crowder_number(box_size = 20.0, exlude_volume_fraction = 0.3, crowder_radius = 1.0):
    box_volume = box_size*box_size*box_size
    crowder_volume = 4/3*3.14*(crowder_radius*crowder_radius*crowder_radius)
    crowder_volume_new = 4.0/3.0*3.14*(crowder_radius*crowder_radius*crowder_radius)
    crowder_number = box_volume*exlude_volume_fraction/crowder_volume
    crowder_number_new = box_volume*exlude_volume_fraction/crowder_volume_new
    
    fraction = crowder_number*4./3.*3.14*(crowder_radius*crowder_radius*crowder_radius)/box_volume
    fraction_new = crowder_number_new*4./3.*3.14*(crowder_radius*crowder_radius*crowder_radius)/box_volume
    print crowder_number,crowder_number_new,fraction,fraction_new
    return(int(crowder_number_new))

def writeINPUTfile(input_file = "input",crowder_radius = 1.0):
    read_input = open(input_file)
    file_lines = read_input.readlines()
    new_line = ''
    for line in file_lines:
        if 'crowder_radius' not in line:
            new_line += line

        else:
            new_crowder_line = "crowder_radius = " + str(crowder_radius) + "\n"
            new_line += new_crowder_line

    new_input_name = input_file
    f = open(new_input_name, "w")
    for line in new_line:
        f.write(line)
    f.close()

exclude_volume_fraction = [0.1, 0.2, 0.3]
crowder_radius_set = [1. , 1.5, 2, 2.5, 3]
box_size = 20

for i in range(0,len(exclude_volume_fraction)):
    for j in range(0,len(crowder_radius_set)):
        exlude_volume = exclude_volume_fraction[i]
        box_volume = 20*20*20
        crowder_radius = crowder_radius_set[j]
        crowder_num = calculating_crowder_number(box_size,exlude_volume,crowder_radius)
        folder_name = 'crowder_'+'f'+str(exlude_volume*100)+'_r'+str(crowder_radius)
        os.mkdir(folder_name)
        shutil.copy('init.dat',folder_name)
        shutil.copy('prova.top', folder_name)
        shutil.copy('input', folder_name)
        shutil.copy('input_mc_relax', folder_name)
        shutil.copy('op.txt', folder_name)
        shutil.copy('wfile.txt', folder_name)
        shutil.copy('seq.txt', folder_name)
        shutil.copy('submit.slurm', folder_name)
        os.chdir(folder_name)
        writeINPUTfile('input',crowder_radius)
        writeINPUTfile('input_mc_relax',crowder_radius)

        fraction_new = crowder_num*4./3.*3.14*(crowder_radius*crowder_radius*crowder_radius)/box_volume
        print(fraction_new)
        command = 'python ~/GitHub/crowderoxdna/UTILS/Add_crowder_no_overlap_checking.py %d %f init.dat prova.top' %(crowder_num,crowder_radius)
        os.system(command)
        relax_cmd = '/Users/fanhong/GitHub/crowderoxdna/src/bin/oxDNA input_mc_relax'
        os.system(relax_cmd)
        os.system('cp last_conf.dat ini_crowder.dat')
        os.system('rm last*')
        os.system('rm traj*')
        os.mkdir('RUN1')
        os.system('mv * RUN1')
        os.chdir("..")
        print 'crowder_'+'f'+str(exlude_volume*100)+'_r'+str(crowder_radius)+'is complete \n'
        