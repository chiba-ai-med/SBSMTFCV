source("src/Functions.R")

args <- commandArgs(trailingOnly = TRUE)
infile <- args[1]
outfile1 <- args[2]
outfile2 <- args[3]
J <- as.numeric(args[4])
num.iter <- as.numeric(args[5])
ratio <- as.numeric(args[6])

# Loading
A <- as.matrix(read.table(infile, header=FALSE))

# Mask Matrix
M <- kFoldMaskTensor(A, k=round(100/ratio),
	seeds=rbinom(1, 1E+5, 0.5))[[1]]

# NMF without binary regularization
out <- SMTF(A=A, M=M, J=J, num.iter=num.iter)
error <- rev(out$TestRecError)[1]

# Save
write.table(error, outfile1, row.names=FALSE, col.names=FALSE, quote=FALSE)
save(out, file=outfile2)