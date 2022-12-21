#!/bin/bash

r=0
rc=0
echo "Crystallising trajectories:"
for i in run* 
do

    if [ -f $i/cn.dat ]; then

	r=$(( r+1 ))

	nq6=`tail -1 $i/cn.dat | awk '{print $3}'`

	cryst=`echo "$nq6>2" | bc`

	if [ "$cryst" -eq "1" ]; then 
	    rc=$(( rc+1 ))
	    echo $i $nq6
	fi
    fi
    
done

fr=`echo "scale=1; 100*$rc/$r" | bc`
echo "$fr% ($rc) of $r trajectories managed it"
