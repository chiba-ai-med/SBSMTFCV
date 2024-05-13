args <- commandArgs(trailingOnly = TRUE)
infile <- args[1]
outfile <- args[2]

# Loading
U <- as.matrix(read.table(infile, header=FALSE))

# {0,1} => {-1,1}
U[which(U < 0.5)] <- -1
U[which(U >= 0.5)] <- 1

# Save
write.table(U, outfile, row.names=FALSE, col.names=FALSE, quote=FALSE, sep="\t")