source("src/Functions.R")

args <- commandArgs(trailingOnly = TRUE)
l <- length(args)
outdir <- args[1]
# Only the first file is evaluated
infile1 <- gsub(paste0(outdir, "/"), "",
	gsub("/CHECK_X_NEW", "", args[2]))
infile2 <- args[l-8]
outfile1 <- args[l-7]
outfile2 <- args[l-6]
outdir <- args[l-5]
Bin_U <- 10^as.numeric(args[l-4])
num.iter <- as.numeric(args[l-3])
bin_w <- as.logical(args[l-2])
beta <- as.numeric(args[l-1])
x_new_sparse <- as.logical(args[l])

infile1 <- gsub("/CHECK_X_NEW", "",
	gsub(paste0(outdir, "/"), "", infile1))

if((infile1 != "_") && bin_w){
	# Loading
	if(x_new_sparse){
		X_new <- readMM(infile1)
	}else{
		X_new <- as.matrix(read.table(infile1, header=FALSE))
	}
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