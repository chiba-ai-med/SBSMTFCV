# -*- coding: utf-8 -*-

# Package Loading
import sys
import numpy as np
import scipy.io
import scipy.sparse
import pathlib

# Arguments passed by Snakemake
args = sys.argv
l = len(args)
infiles = args[1:-1]
outfile = args[l-1]

if "/_/" not in infiles[0]:
	# Merge multiple Matrix Market
	matrices = [scipy.io.mmread(f) for f in infiles]
	combined_matrix = scipy.sparse.vstack(matrices)
	# Save
	scipy.io.mmwrite(outfile, combined_matrix)
else:
	pathlib.Path(outfile).touch()
