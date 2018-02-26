try:
    import numpy as np
except:
    import mynumpy as np

import math
import base
import sys,os

def Add_crowder2Conf(conf_file = 'prova.conf',crowder_number = 10,crowder_size = 0.5):

    try:
        conf = open(conf_file, "r")
    except IOError:
        print "%s not found" % conf_file

    conflines = conf.readlines()
    boxsize = float(conflines[1].split()[2])

    a1_vector = [0.0, 0.0, 1.0]
    a3_vector = [0.0, 0.0, 1.0]
    velocity = [0.0, 0.0, 0.0]
    angle_momuntum = [0.0, 0.0, 0.0]
    base_particle_size = 0.5

    base_x_pos = [float(conflines[i].split()[0]) for i in range(3, len(conflines))]
    base_y_pos = [float(conflines[i].split()[1]) for i in range(3, len(conflines))]
    base_z_pos = [float(conflines[i].split()[2]) for i in range(3, len(conflines))]

    for crowder_index in range(0, crowder_number):
        new_conf_line = []
        OVER_LAP = True

        while OVER_LAP:
            over_lap_index = []
            crowder_cm = np.random.rand(1, 3) * boxsize
            crowder_cm = crowder_cm[0]

            for i in range(0, len(base_x_pos)):
                x_pos = base_x_pos[i]
                y_pos = base_y_pos[i]
                z_pos = base_z_pos[i]

                base_pos = [x_pos, y_pos, z_pos]
                crowder_base_vector = crowder_cm - base_pos
                distance = math.sqrt(crowder_base_vector[0] * crowder_base_vector[0] + \
                                     crowder_base_vector[1] * crowder_base_vector[1] + \
                                     crowder_base_vector[2] * crowder_base_vector[2])

                if distance < base_particle_size + crowder_size:
                    over_lap_index.append(1)
                else:
                    over_lap_index.append(0)
            # print over_lap_index
            OVER_LAP = 1 in over_lap_index
            # print OVER_LAP
        crowder_cm = list(crowder_cm)
        crowder_cm.extend(a1_vector)
        crowder_cm.extend(a3_vector)
        crowder_cm.extend(velocity)
        crowder_cm.extend(angle_momuntum)
        conflines += ' '.join(str(x) for x in crowder_cm)
        conflines += '\n'
        #print crowder_cm

    conf_output_name = conf_file[0:-5] + '_crowder.dat'

    f = open(conf_output_name, "w")
    for line in conflines:
        f.write(line)
    f.close()
    print "...%d crowder has been added to the %s... " %(crowder_number,conf_file)

def AddCrowder2top(top_file = 'prova.conf',crowder_number = 10):
    try:
        top = open(top_file, "r")
    except IOError:
        print "%s not found" % top_file

    toplines = top.readlines()

    strand_index = []

    for i in range(1, len(toplines)):
        strand_index.append(int(toplines[i].split()[0]))

    strand_num = max(strand_index)

    for i in range(1, crowder_number + 1):
        new_crowder = [strand_num + i, -1, -1, -1]
        new_top_line = []
        for n in range(0, len(new_crowder)):
            new_top_line.append(str(new_crowder[n]))

        a = [' '.join(new_top_line)]
        toplines += a[0] + '\n'

    top_output_name = top_file[0:-4] + '_crowder.top'
    #print top_output_name

    #print toplines
    f = open(top_output_name, "w")
    for line in toplines:
        f.write(line)
    f.close()

    print "...%d crowder has been added to the %s... " %(crowder_number,top_file)

def main():

    try:
        crowder_number = int(sys.argv[1])
        crowder_size = float(sys.argv[2])
        conf_filename = sys.argv[3]
        top_filename = sys.argv[4]
    except:
        base.Logger.die("Usage: %s <%s> <%s> <%s> <%s>" % (sys.argv[0],"crowder_num","crowder_size" "conf_filename", "top_filename"))
        sys.exit(1)

    Add_crowder2Conf(conf_filename,crowder_number,crowder_size)
    AddCrowder2top(top_filename,crowder_number)


if __name__ == "__main__":
    main()

