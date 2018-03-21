import os
import shutil
import Add_crowder

# calculate the crowder number
def calculating_crowder_number(box_size = 20.0, exlude_volume_fraction = 0.3, crowder_radius = 1.0):
    box_volume = box_size*box_size*box_size
    crowder_volume = 4/3*3.14*(crowder_radius*crowder_radius*crowder_radius)
    crowder_number = box_volume*exlude_volume_fraction/crowder_volume
    return(int(crowder_number))

def writeINPUTfile(input_file = "input",crowder_radius = 1.0):
    read_input = open(input_file)
    file_lines = read_input.readlines()
    new_line = ''
    for line in file_lines:
        if 'crowder_radius' not in line:
            new_line += line

        else:
            new_crowder_line = "crowder_radius = " + str(crowder_radius) + "\'n"
            new_line += new_crowder_line

    new_input_name = "input_crowder"
    f = open(new_input_name, "w")
    for line in new_line:
        f.write(line)
    f.close()

exclude_volume_fraction = [0.1,0.2,0.3,0.4]
crowder_radius_set = [1,1.5,2,3]
box_size = 20

for i in range(3,len(exclude_volume_fraction)):
    for j in range(0,len(crowder_radius_set)):
        exlude_volume = exclude_volume_fraction[i]
        crowder_radius = crowder_radius_set[j]
        crowder_num = calculating_crowder_number(box_size,exlude_volume,crowder_radius)
        folder_name = 'crowder'+str(exlude_volume)+'_'+str(crowder_radius)
        os.mkdir(folder_name)
        shutil.copy('init.dat',folder_name)
        shutil.copy('prova.top', folder_name)
        shutil.copy('input', folder_name)
        os.chdir(folder_name)
        writeINPUTfile('input','crowder_input')
        Add_crowder.Add_crowder2Conf('init.dat',crowder_num,crowder_radius)
        Add_crowder.AddCrowder2top('prova.top',crowder_num)
        os.chdir("..")


