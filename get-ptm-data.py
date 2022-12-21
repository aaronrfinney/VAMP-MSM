#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import numpy as np
import matplotlib.pyplot as plt

def load_frame(f,atoms,skip):
    rows = []  # unknown number of lines, so use list

    j=1
    for line in f:
        if j>skip:
            line = [float(s) for s in line.split()]
            rows.append(np.array(line, dtype = np.double))
            j+=1
        else:
            j+=1

        if j>atoms+skip:
            break            
        
            
    return np.vstack(rows)  # convert list of vectors to array

nskip=9 # lines to skip at each frame
tframes=200001 # total frames
# polyhedral template matching structures
oth = []
fcc = []
hcp = []
bcc = []
ico = []


with open("ptm.atom",'r') as f: # open the file
    
    # loop through frame-by-frame
    for step in range(tframes):
        if step%1000 == 0:
            print('STEP',step)
            
        frame = load_frame(f,388,nskip)
        
        oth.append(np.count_nonzero(frame[:,1]<1))
        fcc.append(np.count_nonzero(frame[:,1]==1))
        hcp.append(np.count_nonzero(frame[:,1]==2))
        bcc.append(np.count_nonzero(frame[:,1]==3))
        ico.append(np.count_nonzero(frame[:,1]==4))

        
        
np.savetxt('ptm_timesummary.dt',np.c_[oth,fcc,hcp,bcc,ico])
        
        
        
        
        
        
