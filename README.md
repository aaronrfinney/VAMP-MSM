# VAMP and MSMs

This repository contains scripts and input files to generate the data used in 'A Variational Approach to Determine Two-Step Crystallisation Reaction Coordinates' by A. R. Finney and M. Salvalaglio. Please cite:


A recent version of LAMMPS with the colloid package installed is required to run the simulations. A verson of PLUMED beyond v. 2.5 is required with the crystallisation module installed. (PLUMED-driver.zip is available at PLUMED-NEST).
To run the Python scripts and interactive notebooks, numpy, scipy, seaborn, scikit-learn, mdanalysis , pyemma and deeptime are all reqired.


1. To run the particle simulations, execute run-sims.sh. This will perform 1000 independent simulations using the LAMMPS input file in ./master. New run* directories will be created. The script also executes the PLUMED driver and extracts 19 CVs from LAMMPS and PLUMED outputs into a file called CVscreeningeneptm.dat.

2. We use the check-crystals.sh script to determine which simulations provide crystallising trajectories based on a threshold in the potential energies per particle, reported in the log.lammps file. 

2. To compute the VAMP-2 scores for all possible combinations of 17 CVs, we used the approach in VAMP-scores-CVs1-6.ipynb, currently set-up to do determine VAMP-2 scores for 1-5 CV dimensions. (All VAMP-2 scores and ranked RCs according to these scores are available in RC_data.tar.gz)

3. CVdist-17CVs.ipynb sorts through all of the possible RCs and VAMP-2 scores to rank them and analyse their distributions.

4. With knowledge of the best performing RCs, we apply TICA to project the high dimension CV RCs onto two TICA coordinates and construct Bayesian MSMs using discrete TICA trajectories following the approach in MSM2_TICA.ipynb.

5. collate-plots.ipynb is a short notebook to summarise the rates and timescales evaluated in MSMs.
