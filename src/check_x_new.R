args <- commandArgs(trailingOnly = TRUE)
infile1 <- args[1]
infile2 <- args[2]
outfile <- args[3]

if(infile1 != "_"){
	# Loading
	X_new <- as.matrix(read.table(infile1, header=FALSE))
	initH <- as.matrix(read.table(infile2, header=FALSE))

	checkSameSize <- ncol(X_new) != nrow(initH)
	if(checkSameSize){
		stop("Column size of X_new and row size of H must be the same!!!")
	}
	checkNegative <- length(which(X_new < 0)) != 0
	if(checkNegative){
		stop("Negative elements found!!!")
	}
	file.create(outfile)
}else{
	file.create(outfile)
}
