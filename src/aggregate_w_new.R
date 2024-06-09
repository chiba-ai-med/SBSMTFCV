source("src/Functions.R")

args <- commandArgs(trailingOnly = TRUE)
l <- length(args)
infiles <- args[seq_len(l-1)]
outfile <- args[l]

if(!length(grep("_", args[1]))){
	# Load
	sps <- do.call("rbind", lapply(infiles, readMM))
	# Save
	writeMM(sps, outfile)
}else{
	# Save
	file.create(outfile)
}
