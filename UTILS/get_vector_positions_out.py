#!/usr/bin/env python

import base
import readers
try:
    import numpy as np
except:
    import mynumpy as np
import os.path
import sys
import fileinput
import getopt

input_options = ['seq_base_colour','colour_by_domain=']

longArgs=input_options
shortArgs='sc:'

try:
    args, files = getopt.getopt(sys.argv[1:], shortArgs, longArgs)
except:
    base.Logger.log( "Wrong usage. Aborting",base.Logger.CRITICAL)
    sys.exit (-2)


if len(files) < 2:
    base.Logger.log("Usage is %s [-s] [-c domain_file] configuration topology [output]" % sys.argv[0]) 
    sys.exit()

if len(files) >2:
    output = files[2]
else: output = files[0] + ".pdb"

base.MM_GROOVING = True
l = readers.LorenzoReader(files[0], files[1])
s = l.get_system()

N = len(s._nucleotides)

for i in range(1,(N/2)-1):
     nucA = s._nucleotides[i]
     nucB = s._nucleotides[N-1-i]
     
     
     posA_bb = nucA.get_pos_back()
     posB_bb = nucB.get_pos_back()
     posA_cm = nucA.cm_pos
     posB_cm = nucB.cm_pos
     vector_Abb_to_Bbb = posB_bb - posA_bb

     A_to_A3prime = -posA_bb + s._nucleotides[i+1].get_pos_back() 
     A_to_A5prime = -posA_bb + s._nucleotides[i-1].get_pos_back()

     B_to_B3prime = -posB_bb + s._nucleotides[N-1-i+1].get_pos_back() 
     B_to_B5prime = -posB_bb + s._nucleotides[N-i-1-1].get_pos_back()

     #print '%d: cm_pos = %f back-back  + %f back-3\'_back + %f back-5\'_back ' % (i, np.dot(posA_cm,vector_Abb_to_Bbb), np.dot(posA_cm,A_to_A3prime), np.dot(posA_cm)
     #print nucA
     #print nucA.get_pos_back()
     a = nucA.cm_pos - nucA.get_pos_back() 
     b = vector_Abb_to_Bbb
     c = A_to_A3prime 
     d = A_to_A5prime 
     
     b = b/np.sqrt(np.dot(b,b)) 
     c = c/np.sqrt(np.dot(c,c)) 
     d = d/np.sqrt(np.dot(d,d))

     print a,b,c,d
     M = np.array([b,c,d]).transpose()
     coefficients = np.linalg.solve(M,a) 
     #print np.linalg.det(M)
     #print np.dot(M,coefficients), a
     print '%d nucleotide: ' %  (i) , coefficients
    

     a = nucB.cm_pos - nucB.get_pos_back() 
     b = -vector_Abb_to_Bbb
     c = B_to_B3prime 
     d = B_to_B5prime 
     
     b = b/np.sqrt(np.dot(b,b)) 
     c = c/np.sqrt(np.dot(c,c)) 
     d = d/np.sqrt(np.dot(d,d))

     print a,b,c,d
     M = np.array([b,c,d]).transpose()
     coefficients = np.linalg.solve(M,a) 
     #print np.linalg.det(M)
     #print np.dot(M,coefficients), a
     print '%d nucleotide: ' %  (N-1-i) , coefficients




     a = nucA._a3
     b = vector_Abb_to_Bbb
     c = A_to_A3prime 
     d = A_to_A5prime 
     
     b = b/np.sqrt(np.dot(b,b)) 
     c = c/np.sqrt(np.dot(c,c)) 
     d = d/np.sqrt(np.dot(d,d))

     print a,b,c,d
     M = np.array([b,c,d]).transpose()
     coefficients = np.linalg.solve(M,a) 
     #print np.linalg.det(M)
     #print np.dot(M,coefficients), a
     print '%d nucleotide a3 vector: ' %  (i) , coefficients




     a = nucB._a3
     b = -vector_Abb_to_Bbb
     c = B_to_B3prime 
     d = B_to_B5prime 
     
     b = b/np.sqrt(np.dot(b,b)) 
     c = c/np.sqrt(np.dot(c,c)) 
     d = d/np.sqrt(np.dot(d,d))

     print a,b,c,d
     M = np.array([b,c,d]).transpose()
     coefficients = np.linalg.solve(M,a) 
     #print np.linalg.det(M)
     print 'A3 control', np.dot(M,coefficients), a
     print '%d nucleotide, a3 vector: ' %  (N-1-i) , coefficients


 #print '%d: cm_pos - bb_pos: (%f,%f,%f) = a (%f,%f,%f) + b (%f,%f,%f) + c (%f,%f,%f) ' % (nucA.cm_pos -nucA.cm_pos + nucA.cm_pos) 
