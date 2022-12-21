#!/bin/bash

# BASH SCRIPT TO RUN X SIMULATIONS OF COLLOID SUSPENSIONS
# AND EXTRACT 19 CVS
# A. R. Finney, Dec 2022

# generate trajectories sequentially
for i in {1..1000}
do
    echo "#### Executing $i"

    # take the input from a master directory
    cp -r master newrun$i
    cd newrun$i

    # chage the random seed for velocity assignment
    sed -i "s/RANDOM/$RANDOM/" in.3Dcolloid

    # Run lammps
    lmp < in.3Dcolloid

    # Run plumed
    ln -s ../plumed-all-search.dat
    plumed driver --ixyz dump.3Dcolloid.xyz --plumed plumed-all-search.dat --timestep 1 --trajectory-stride 1 --box 92.83178,92.83178,92.83178


    # Extract the potential energy time series data from log.lammps
    grep -A 200001 "Step Atoms Temp E_pair E_coul TotEng Press" log.lammps | tail -n 200001 | awk '{print $4}' > temp1

    # Create a new file by pasting the Plumed output and energy data
    echo "energies" > energy.dat
    cat temp1 >> energy.dat
    paste CVscreening.dat energy.dat > CVscreeningene.dat
    
    # Clean up
    rm -f temp1 temp2

    # Run a python script to extract the numbers of fcc/hcp/bcc/ico and non particles for each frame
    python3.7 ../get-ptm-data.py
    echo "oth fcc hcp bcc ico" > ptm.dat
    cat ptm_timesummary.dt >> ptm.dat

    # Create a new file with all 19 CVs
    paste CVscreeningene.dat ptm.dat > CVscreeningeneptm.dat


    cd ../
done
