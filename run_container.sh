#!/bin/bash

lmp -k on g 1 -sf kk -pk kokkos  newton on neigh half -in in.snap.test -var nsteps 1 -var nx 10 -var ny 10 -var nz 10 -var snapdir 2J14_W.SNAP
