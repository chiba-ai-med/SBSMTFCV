source("src/Functions.R")

args <- commandArgs(trailingOnly = TRUE)
infile1 <- args[1]
infile2 <- args[3]
infile3 <- args[4]
outfile <- args[5]
num.iter <- as.numeric(args[6])
beta <- as.numeric(args[7])

if(infile1 != "_"){
	# Loading
	X_new <- as.matrix(read.table(infile1, header=FALSE))
	Bin_U <- as.numeric(read.table(infile2, header=FALSE))
	initV <- as.matrix(read.table(infile3, header=FALSE))

	# NMF with binary regularization
	out <- dNMF(X=X_new, J=ncol(initV), Bin_U=Bin_U, initV=initV, fixV=TRUE,
		num.iter=num.iter, Beta=beta)

	# Save
	write.table(out$U, outfile, row.names=FALSE, col.names=FALSE, quote=FALSE)
}else{
	file.create(outfile)
}