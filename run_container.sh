#!/bin/bash

lmp -k on g 4 -sf kk -pk kokkos  newton on neigh half -in in.snap.test -var nsteps 100 -var nx 100 -var ny 100 -var nz 10 -var snapdir 2J14_W.SNAP
