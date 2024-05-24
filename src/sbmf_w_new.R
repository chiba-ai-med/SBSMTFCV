source("src/Functions.R")

args <- commandArgs(trailingOnly = TRUE)
l <- length(args)
infile1 <- args[1] # Only the first file is evaluated
infile2 <- args[l-7]
outfile1 <- args[l-6]
outfile2 <- args[l-5]
outdir <- args[l-4]
Bin_U <- 10^as.numeric(args[l-3])
num.iter <- as.numeric(args[l-2])
bin_w <- as.logical(args[l-1])
beta <- as.numeric(args[l])
infile1 <- gsub("/CHECK_X_NEW", "",
	gsub(paste0(outdir, "/"), "", infile1))

if(bin_w){
	# Loading
	X_new <- as.matrix(read.table(infile1, header=FALSE))
	initV <- as.matrix(read.table(infile2, header=FALSE))

	# NMF with binary regularization
	out <- dNMF(X=X_new, J=ncol(initV), Bin_U=Bin_U, initV=initV, fixV=TRUE,
		num.iter=num.iter, Beta=beta)
	pctBin <- zero_one_percentage(out$U)

	# Save
	write.table(pctBin, outfile1, row.names=FALSE, col.names=FALSE, quote=FALSE)
	save(out, file=outfile2)
}else{
	file.create(outfile1)
	file.create(outfile2)
}