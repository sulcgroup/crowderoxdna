# NB make sure cadnano saves files as .json
import sys
try:
    import numpy as np
except:
    import mynumpy as np
import base
import generators as gen
import re
from utils import *

DIST=2.55#distance between centers of virtual helices
BOX_FACTOR = 2 # factor by which to expand the box(linear dimension)
# cadnano object structure
class vstrands (object):
    def __init__ (self):
        self.vhelices = []

    def add_vhelix (self, toadd):
        self.vhelices.append(toadd)

    def bbox (self):
        rows = []
        cols = []
        lens = []
        for h in self.vhelices:
            rows.append (h.row)
            cols.append (h.col)
            lens.append (len(h.scaf))
#            lens.append (max (len(h.stap), len(h.scaf)))


        dr = DIST * (max(rows) - min(rows) + 2)
        dc = DIST * (max(cols) - min(cols) + 2)
        dl = 0.34 * (max(lens) + 2)
        
        return 2*max([dr,dc,dl]) * BOX_FACTOR
    
    def __str__ (self):
        a = '{\n"vstrands":[\n'
        if len(self.vhelices) > 0:
            for h in self.vhelices:
                a = a + str(h) + ','
            a = a[0:len(a)-1]
        a = a + '}\n'
        return a


class vhelix (object):
    def __init__ (self):
        self.stapLoop = []
        self.scafLoop = []
        self.skip = []
        self.loop = []
        self.stap_colors = []
        self.row = 0
        self.col = 0
        self.num = 0
        self.stap = []
        self.scaf = []

    def get_length (self):
        return max (len(self.scaf), len(self.stap))

    len = property (get_length)

    def add_square (self, toadd, which):
        if which == 'stap':
            self.stap.append(toadd)
        elif which == 'scaf':
            self.scaf.append (toadd)
        else:
            print >> sys.stderr, "cannot add square that is not scaf or stap. Dying now"
            sys.exit (-1)
    
    def __str__ (self):
        a = '{\n'

        a = a + '"stapLoop":['
        if len(self.stapLoop) > 0:
            for i in self.stapLoop:
                a = a + str(i) + ','
            a = a[0:len(a)-1] # remove last comma
        a = a + '],\n'

        a = a + '"skip":['
        if len(self.skip) > 0:
            for e in self.skip:
                a = a + str(e) + ','
            a = a[0:len(a)-1] # remove last comma
        a = a + '],\n'
        
        a = a + '"loop":['
        if len(self.loop) > 0:
            for e in self.loop:
                a = a + str(e) + ','
            a = a[0:len(a)-1] # remove last comma
        a = a + '],\n'
        
        a = a + '"stap_colors":['
        if len (self.stap_colors) > 0:
            for e in self.stap_colors:
                a = a + str(e) + ','
            a = a[0:len(a)-1] # remove last comma
        a = a + '],\n'

        a = a + '"row":' + str(self.row) + ',\n'
        a = a + '"col":' + str(self.col) + ',\n'
        a = a + '"num":' + str(self.num) + ',\n'
        
        a = a + '"scafLoop":['
        if len(self.scafLoop) > 0:
            for i in self.scafLoop:
                a = a + str(i) + ','
            a = a[0:len(a)-1] # remove last comma
        a = a + '],\n'
        
        a = a + '"stap":['
        if len(self.stap) > 0:
            for i in self.stap:
                a = a + str(i) + ','
            a = a[0:len(a)-1] # remove last comma
        a = a + '],\n'
        
        a = a + '"scaf":['
        if len(self.scaf) > 0:
            for i in self.scaf:
                a = a + str(i) + ','
            a = a[0:len(a)-1] # remove last comma
        a = a + ']\n}'
        return a

class square (object):
    def __init__ (self, V_0=-1, b_0=-1, V_1=-1, b_1=-1):
        self.V_0 = V_0
        self.b_0 = b_0
        self.V_1 = V_1
        self.b_1 = b_1

    def __str__ (self):
        return '[%i,%i,%i,%i]' % (self.V_0, self.b_0, self.V_1, self.b_1)

def parse_cadnano (path):
    if not isinstance (path, str):
        print >> sys.stderr, "must be a path. Aborting"
        sys.exit (-1)
    
    try:
        inp = open (path, 'r')
    except:
        print >> sys.stderr, "Could not open", path, "Aborting now"
        sys.exit (-1)
    
    string = ''
    for line in inp.readlines ():
        string += line
    inp.close()

    string = string[1:len(string)-1] # remove the outer bracket par
    
    ret = vstrands ()
    
    while string.find('{') > 0:
        i = string.find('{')
        j = string.find('}')
        h = parse_helix (string[i+1:j])
        ret.add_vhelix (h)
        string = string[j+1:]

    return ret


def parse_helix (string):
    try:
        i = string.index ('{')
    except:
        i = 0

    try:
        j = string.index ('}')
    except:
        j = len(string)
    
    string = string[i:j].strip()
    
    ret = vhelix ()

    lines = []
    delims = []
    index = 0
    in_bracket = 0
    for char in string:
        if char == '[':
            in_bracket += 1
        elif char == ']':
            in_bracket -= 1
        elif in_bracket < 1:
            if char == ',':
                delims.append(index)
        index += 1

    lines.append(string[:delims[0]+1])
    for i in range(len(delims)):
        if i != len(delims) - 1:
            lines.append(string[delims[i]+1:delims[i+1]+1])
        else:
            lines.append(string[delims[i]+1:])

    for line in lines:
        line = line.strip()
        if line.startswith('"stapLoop"'):
            ret.stapLoop = map (int, re.findall(r'\d+', line))
        elif line.startswith('"skip"'):
            ret.skip = map (int, re.findall(r'\d+', line))
        elif line.startswith('"loop"'):
            ret.loop = map (int, re.findall(r'\d+', line))
        elif line.startswith('"stap_colors"'):
            # not implemented at the moment
            pass
        elif line.startswith('"scafLoop"'):
            ret.scafLoop = map (int, re.findall(r'\d+', line))
        elif line.startswith('"stap"'):
            i = line.index('[')
            j = line.rindex(']')
            words = line[i+1+1:j-1].split('],[')
            for word in words:
                V_0, b_0, V1, b_1 = map(int, word.split(','))
                sq = square (V_0, b_0, V1, b_1)
                ret.add_square (sq, 'stap')
        elif line.startswith('"scaf"'):
            i = line.index('[')
            j = line.rindex(']')
            words = line[i+1+1:j-1].split('],[')
            base = 0
            for word in words:
                V_0, b_0, V1, b_1 = map(int, word.split(','))
                sq = square (V_0, b_0, V1, b_1)
                ret.add_square (sq, 'scaf')
        elif line.startswith('"row"'):
            ret.row = map(int, re.findall(r'(\d+)', line))[0]
        elif line.startswith('"num"'):
            ret.num = map(int, re.findall(r'(\d+)', line))[0]
        elif line.startswith('"col"'):
            ret.col = map(int, re.findall(r'(\d+)', line))[0]
        else:
            pass #print >> sys.stderr, "Unknown line... Passing"
        
    return ret

cadsys = parse_cadnano ('dummy.json')
side = cadsys.bbox ()
vhelix_direction = np.array([0,0,1])
vhelix_perp = np.array([1,0,0])
R = get_rotation_matrix(vhelix_direction, np.pi*160./180)
vhelix_perp = np.dot(R, vhelix_perp)
g = gen.StrandGenerator ()
slice_sys = base.System([side,side,side])            
final_sys = base.System([side,side,side])
strand_number = -1
partner_list_scaf = []
partner_list_stap = []
found_partner = False
join_list_scaf = []
join_list_stap = []
for h in cadsys.vhelices:
    # generate helix angles
    helix_angles = np.zeros(h.len - 1, dtype=float)

    av_angle = 720./21 * np.pi/180

    for i in range(len(helix_angles)):
        modi = i%21
        if modi == 0:
            helix_angles[i] = 32.571 * np.pi/180
        elif modi == 1:
            helix_angles[i] = 36 * np.pi/180
        elif modi in (1,2,3):
            helix_angles[i] = 42 * np.pi/180
        elif modi in (5,6,7):
            helix_angles[i] = 29.143 * np.pi/180
        elif modi == 8:
            helix_angles[i] = 32 * np.pi/180
        elif modi in (9,10):
            helix_angles[i] = 44 * np.pi/180
        elif modi in (12,13,14):
            helix_angles[i] = 28.571 * np.pi/180
        elif modi in (16,17):
            helix_angles[i] = 41.5 * np.pi/180
        elif modi in (19,20):
            helix_angles[i] = 28.476 * np.pi/180
        else:
            helix_angles[i] = 720./21 * (np.pi/180.) 

    # make sure it's periodic
    sum = 0
    for i in range(20):
        sum += helix_angles[i]

    for i in range(len(helix_angles)):
        if i % 21 == 20:
            helix_angles[i] = 720. * np.pi/180 - sum

    # make the virtual helices
    if h.num % 2 == 0:
        pos = np.array([h.col * np.sqrt(3)*DIST/2, h.row * 3*DIST/2, 0])
        dir = vhelix_direction
        perp = vhelix_perp
        strands = g.generate_or_sq(h.len, start_pos=pos, dir=dir, perp=perp, double=True, rot=0., angle = helix_angles)
    else:
        pos = np.array([h.col * np.sqrt(3)*DIST/2, h.row * 3*DIST/2 + DIST/2, (h.len-1)*base.BASE_BASE])
        dir = -vhelix_direction
        perp = -vhelix_perp
        rot = -np.sum(helix_angles) % (2*np.pi)
        angles = np.flipud(helix_angles)
        strands = g.generate_or_sq(h.len, start_pos=pos, dir=dir, perp=perp, double=True, rot=rot, angle=angles)

    # read the scaffold squares and add strands to slice_sys
    i = 0
    for s in h.scaf:
        if s.V_0 == -1 and s.b_0 == -1:
            if s.V_1 == -1 and s.b_0 == -1:
                pass
            elif s.V_1 == h.num:
                if h.num % 2 == 0:
                    strand_number += 1
                begin_helix = i
                if h.num % 2 == 1:
                    slice_sys.add_strand(strands[0].get_slice(h.len - begin_helix - 1, h.len - end_helix), check_overlap = False)
            else:
                base.Logger.log("unexpected square array", base.Logger.WARNING)
        elif s.V_0 == h.num:
            if s.V_1 == -1 and s.b_1 == -1:
                if h.num % 2 == 1:
                    strand_number += 1
                end_helix = i
                if h.num % 2 == 0:
                    slice_sys.add_strand(strands[0].get_slice(begin_helix, end_helix + 1), check_overlap = False)
            elif s.V_1 == h.num:
                pass
            else:
                if h.num % 2 == 1:
                    strand_number += 1
                end_helix = i
                if h.num % 2 == 0 :
                    slice_sys.add_strand(strands[0].get_slice(begin_helix, end_helix + 1), check_overlap = False)
                if h.num % 2 == 1:
                    column = i
                else:
                    column = i
                for j in range(len(partner_list_scaf)):
                    
                    if [h.num, column] == partner_list_scaf[j]:
                        join_list_scaf[j].insert(0,strand_number)
                        found_partner = True
                if found_partner == False:
                    join_list_scaf.append([strand_number])
                    partner_list_scaf.append([s.V_1, s.b_1])
                found_partner = False
        else:
            if s.V_1 == -1 and s.b_1 == -1:
                base.Logger.log("unexpected square array", base.Logger.WARNING)
            elif s.V_1 == h.num:
                if h.num % 2 == 0:
                    strand_number += 1
                begin_helix = i
                if h.num % 2 == 1:
                    slice_sys.add_strand(strands[0].get_slice(h.len - begin_helix - 1, h.len - end_helix), check_overlap = False)
                for j in range(len(partner_list_scaf)):
                    if h.num % 2 == 1:
                        column = i
                    else:
                        column = i
                    if [h.num, column] == partner_list_scaf[j]:
                        join_list_scaf[j].append(strand_number)
                        found_partner = True
                if found_partner == False:
                    join_list_scaf.append([strand_number])
                    partner_list_scaf.append([s.V_0, s.b_0])
                found_partner = False
            else:
                base.Logger.log("unexpected square array", base.Logger.WARNING)                
        i += 1

    # read the staple squares and add strands to slice_sys
    i = 0
    for s in h.stap:
        if s.V_0 == -1 and s.b_0 == -1:
            if s.V_1 == -1 and s.b_0 == -1:
                pass
            elif s.V_1 == h.num:
                if h.num % 2 == 1:
                    strand_number += 1
                begin_helix = i
                if h.num % 2 == 0:
                    slice_sys.add_strand(strands[1].get_slice(h.len - begin_helix - 1, h.len - end_helix), check_overlap = False)
            else:
                base.Logger.log("unexpected square array", base.Logger.WARNING)
        elif s.V_0 == h.num:
            if s.V_1 == -1 and s.b_1 == -1:
                if h.num % 2 == 0:
                    strand_number += 1
                end_helix = i
                if h.num % 2 == 1:
                    slice_sys.add_strand(strands[1].get_slice(begin_helix, end_helix + 1), check_overlap = False)
            elif s.V_1 == h.num:
                pass
            else:
                if h.num % 2 == 0:
                    strand_number += 1
                end_helix = i
                if h.num % 2 == 1:
                    slice_sys.add_strand(strands[1].get_slice(begin_helix, end_helix + 1), check_overlap = False)
                if h.num % 2 == 0:
                    column = i
                else:
                    column = i
                for j in range(len(partner_list_stap)):
                    
                    if [h.num, column] == partner_list_stap[j]:
                        join_list_stap[j].insert(0,strand_number)
                        found_partner = True
                if found_partner == False:
                    join_list_stap.append([strand_number])
                    partner_list_stap.append([s.V_1, s.b_1])
                found_partner = False
        else:
            if s.V_1 == -1 and s.b_1 == -1:
                base.Logger.log("unexpected square array", base.Logger.WARNING)
            elif s.V_1 == h.num:
                if h.num % 2 == 1:
                    strand_number += 1
                begin_helix = i
                if h.num % 2 == 0:
                    slice_sys.add_strand(strands[1].get_slice(h.len - begin_helix - 1, h.len - end_helix), check_overlap = False)
                for j in range(len(partner_list_stap)):
                    if h.num % 2 == 0:
                        column = i
                    else:
                        column = i
                    if [h.num, column] == partner_list_stap[j]:
                        join_list_stap[j].append(strand_number)
                        found_partner = True
                if found_partner == False:
                    join_list_stap.append([strand_number])
                    partner_list_stap.append([s.V_0, s.b_0])
                found_partner = False
            else:
                base.Logger.log("unexpected square array", base.Logger.WARNING)                
        i += 1

join_lists = [join_list_scaf, join_list_stap]

# add strands to final_sys that aren't joined
join_list_unpacked = []
for a in range(2):
    for i in join_lists[a]:
        join_list_unpacked.extend(i)
for i in range(len(slice_sys._strands)):
    if i not in join_list_unpacked:
        final_sys.add_strand(slice_sys._strands[i], check_overlap = False)

for a in range(2):
    join_list = join_lists[a]
    all_are_joined = False
    restart = False

    # check distance between the backbones we are about to join
    for pair in join_list:
        strand1 = slice_sys._strands[pair[0]]
        strand2 = slice_sys._strands[pair[1]]
        backbone_backbone_dist = strand1._nucleotides[-1].distance(strand2._nucleotides[0], PBC=False)
        absolute_bb_dist = np.sqrt(np.dot(backbone_backbone_dist, backbone_backbone_dist))
        if absolute_bb_dist > 1.001 or absolute_bb_dist < 0.5525:
            base.Logger.log("backbone-backbone distance across join the wrong length", base.Logger.WARNING)
            print "backbone-backbone distance: " + str(absolute_bb_dist)

    # match up all the pairs of joins that involve the same strand
    while all_are_joined == False:
        restart = False
        for i in range(len(join_list)):
            if restart == True:
                break
            for j in range(len(join_list)):
                if restart == True:
                    break
                if join_list[i][0] == join_list[j][len(join_list[j]) - 1] and i != j:
                    join_list[j].extend(join_list[i][1:])
                    join_list.pop(i)
                    restart = True
                    break
                elif join_list[i][0] == join_list[j][len(join_list[j]) - 1] and i == j:
                    base.Logger.log("circular strand detected - currently unsupported", base.Logger.WARNING)
            
        if restart == False:
            all_are_joined = True

    # add joined strands
    for join in join_list:
        joined_strand = slice_sys._strands[join[0]]
        for k in range(len(join) - 1):
            joined_strand = joined_strand.append(slice_sys._strands[join[k + 1]])
        final_sys.add_strand(joined_strand, check_overlap = False)
        
final_sys.print_lorenzo_output ("prova.conf", "prova.top")
final_sys.print_vmd_xyz_output ('gino.xyz', same_colors=True)

print "number of strands: " + str(len(final_sys._strands))

# python traj2tcl-detailed.py prova.conf prova.top caca.tcl cdmto0
'''
    for i in range(len(helix_angles)):
        modi = i%21
        if modi == 0:
            helix_angles[i] = (av_angle*6 - (40 * 3) * np.pi/180)/3 + (4 * np.pi/180)
        elif modi == 1:
            helix_angles[i] = 36 * np.pi/180
        elif modi in (1,2,3):
            helix_angles[i] = 42 * np.pi/180
        elif modi in (5,6,7):
            helix_angles[i] = (av_angle*5 - 45 * np.pi/180 * 2)/3 + (2 * np.pi/180)
        elif modi == 8:
            helix_angles[i] = 32 * np.pi/180
        elif modi in (9,10):
            helix_angles[i] = 44 * np.pi/180
        elif modi in (12,13,14):
            helix_angles[i] = (av_angle*6 - (32 + 47 + 47) * np.pi/180)/3 + (2 * np.pi/180)
        elif modi in (16,17):
            helix_angles[i] = 41.5 * np.pi/180
        elif modi in (19,20):
            helix_angles[i] = (av_angle*5 - (43 * 2) * np.pi/180)/3
        else:
            helix_angles[i] = (720./21 * 21 ) * (np.pi/180.) / 21
            '''
