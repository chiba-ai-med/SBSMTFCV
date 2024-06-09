source("src/Functions.R")

args <- commandArgs(trailingOnly = TRUE)
infile <- args[1]
outfile1 <- args[2]
outfile2 <- args[3]
J <- as.numeric(args[4])
num.iter <- as.numeric(args[5])
beta <- as.numeric(args[6])
ratio <- as.numeric(args[7])
input_sparse <- as.logical(args[8])

# Loading
if(input_sparse){
	A <- 1.0 * as.matrix(readMM(infile))
}else{
	A <- as.matrix(read.table(infile, header=FALSE))
}
colnames(A) <- NULL

# Mask Matrix
M <- kFoldMaskTensor(A, k=round(100/ratio),
	seeds=rbinom(1, 1E+5, 0.5), sym=TRUE)[[1]]

# NMF without binary regularization
out <- SMTF(A=A, M=M, J=J, num.iter=num.iter, Beta=beta)
error <- rev(out$TestRecError)[1]

# Save
write.table(error, outfile1, row.names=FALSE, col.names=FALSE, quote=FALSE)
save(out, file=outfile2)