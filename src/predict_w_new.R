source("src/Functions.R")

args <- commandArgs(trailingOnly = TRUE)
infile1 <- args[1]
infile2 <- args[2]
infile3 <- args[3]
outfile <- args[4]
num.iter <- as.numeric(args[5])
beta <- as.numeric(args[6])
x_new_sparse <- as.logical(args[7])
w_new_sparse <- as.logical(args[8])

if(infile1 != "_"){
	# Loading
	if(x_new_sparse){
		X_new <- 1.0 * as.matrix(readMM(infile1))
	}else{
		X_new <- as.matrix(read.table(infile1, header=FALSE))
	}
	Bin_U <- as.numeric(read.table(infile2, header=FALSE))
	initV <- as.matrix(read.table(infile3, header=FALSE))

	# NMF with binary regularization
	out <- dNMF(X=X_new, J=ncol(initV), Bin_U=Bin_U,
		initV=initV, num.iter=num.iter, Beta=beta, verbose=TRUE)
	U <- out$U

	# Binarization
	if(w_new_sparse){
		U[which(U < 0.5)] <- 0
		U[which(U >= 0.5)] <- 1
		U <- as(U, "TsparseMatrix")
		# Save
		writeMM(U, outfile)
	}else{
		# Save
		write.table(U, outfile, row.names=FALSE, col.names=FALSE, quote=FALSE)
	}
}else{
	file.create(outfile)
}