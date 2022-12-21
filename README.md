# VAMP and MSMs

This repository contains scripts and input files to generate the data used in 'A Variational Approach to Determine Two-Step Crystallisation Reaction Coordinates' by A. R. Finney and M. Salvalaglio. Please cite:


A recent version of LAMMPS with the colloid package installed is required to run the simulations. A verson of PLUMED beyond v. 2.5 is required with the crystallisation module installed.
To run the Python scripts and interactive notebooks, numpy, scipy, seaborn, scikit-learn, mdanalysis , pyemma and deeptime are all reqired.


1. To run the particle simulations, execute run-sims.sh. This will perform 1000 independent simulations using the LAMMPS input file in ./master. The script also executes the PLUMED driver and extracts 19 CVs from LAMMPS and PLUMED outputs nto a file called CVscreeningeneptm.dat.

2. We use the check-crystals.sh script to dtermine which simulations provide crystallising trajectories based on a threshold in the potential energies per particle, reported in the log.lammps file. 

2. To compute the VAMP-2 scores for all possible combinations of 17 CVs, we used the approach in VAMP-scores-CVs1-6.ipynb, currently set-up to do this for just 1-5 CV dimensions.

3. CVdist-17CVs.ipynb sorts through all of the possible RCs and VAMP-2 scores to rank them and analyse their distributions.

4. With knowledge of the best performing RCs, we apply TICA to project the high dimension CV RCs onto two TICA coordinates and construct bayesian MSMs using discrete TICA trajectories following the approach in MSM2_TICA.ipynb.
