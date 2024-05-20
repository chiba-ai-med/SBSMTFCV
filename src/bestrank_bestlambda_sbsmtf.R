source("src/Functions.R")

args <- commandArgs(trailingOnly = TRUE)
infile1 <- args[1]
infile2 <- args[2]
infile3 <- args[3]
outfile <- args[4]
num.iter <- as.numeric(args[5])
beta <- as.numeric(args[6])

# Loading
A <- as.matrix(read.table(infile1, header=FALSE))
J <- as.numeric(read.table(infile2, header=FALSE))
Bin_U <- as.numeric(read.table(infile3, header=FALSE))

# NMF without binary regularization
out <- SMTF(A=A, J=J, Bin_U=Bin_U, num.iter=num.iter, Beta=beta)

# Save
save(out, file=outfile)