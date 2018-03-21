import numpy as np
import math

def trajector_analysis(input_file = 'input_crowder',top_file = 'prova_crowder.top', trajectory_file = 'trajectory.dat'):

    input_file_lines = open(input_file).readlines()
    for line in input_file_lines:
        if 'crowder_radius' in line:
            crowder_radius = float(line.split()[2])

    top_file_lines = open(top_file).readlines()
    over_all_particle_number = int(top_file_lines[0].split()[0])

    base_number = 0
    for line in top_file_lines:
        if line.split()[1] in ['A', 'T', 'C', 'G']:
            base_number += 1
        else:
            base_number = base_number

    trajectory = open(trajectory_file)
    trajectory_lines = trajectory.readlines()

    trajectory_para = np.array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])

    for line in trajectory_lines:
        base_para = []
        if 't' not in line.split() and 'E' not in line.split() and 'b' not in line.split():
            for x in line.split():
                base_para.append(float(x))
        else:
            base_para = []

        if base_para:
            base_para = np.array(base_para)

            trajectory_para = np.vstack((trajectory_para, base_para))
    trajectory_para = np.delete(trajectory_para, 0, 0)
    conformation_num = len(trajectory_para) / over_all_particle_number

    for i in range(0,int(conformation_num)):
        conformation_start = i*over_all_particle_number
        conformation_end = (i+1)*over_all_particle_number
        conformation = trajectory_para[conformation_start:conformation_end, ]

        base_conformation = conformation[0:base_number, ]
        crowder_conformation = conformation[base_number:over_all_particle_number, ]

    return crowder_radius, base_conformation, crowder_conformation


def calculating_distance(a =np.random.rand(1,3),b = np.random.rand(1,3)):
    vector_ab = a-b
    distance = math.sqrt(vector_ab[0] * vector_ab[0] + \
                         vector_ab[1] * vector_ab[1] + \
                         vector_ab[2] * vector_ab[2])
    return distance


def check_overlapping(crowder_radius = 1, base_conformation = np.random.rand(1,15), crowder_conformation = np.random.rand(1,15)):
    base_particle_size = 0.5
    base_number = len(base_conformation)
    crowder_number = len(crowder_conformation)

    # Calculate base-Crowder distance
    for x in range(0,base_number):
        individual_base_conf = base_conformation[x, ]
        for y in range(0,crowder_number):
            individual_crowder_conf = crowder_conformation[y, ]
            base_crowder_distance = calculating_distance(individual_base_conf,individual_crowder_conf)

            if base_crowder_distance<base_particle_size+crowder_radius:
                print "WARNING: conformation has Base-Crowder overlapping \n"

    # Calculate crowder-crowder distance
    for x in range(0,crowder_number):
        crowder1_conf = crowder_conformation[x, ]
        crowder_conformation_set2 = crowder_conformation
        crowder_conformation_set2 = np.delete(crowder_conformation_set2, (x), axis = 0)
        for y in range(0,crowder_number-1):
            crowder2_conf = crowder_conformation_set2[y, ]
            crowder_crowder_distance = calculating_distance(crowder1_conf, crowder2_conf)

        if crowder_crowder_distance<crowder_radius+crowder_radius:
            print "WARNING: conformation has Base-Crowder overlapping \n"

    print "OverLap Checking is done"

# Example of usage:
crowder_radius, base_conformation, crowder_conformation = trajector_analysis('input_crowder','prova_crowder.top', 'trajectory.dat')
check_overlapping(crowder_radius,base_conformation,crowder_conformation)