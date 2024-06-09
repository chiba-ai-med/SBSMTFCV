source("src/Functions.R")

args <- commandArgs(trailingOnly = TRUE)
infile1 <- args[1]
infile2 <- args[2]
outfile <- args[3]
x_new_sparse <- as.logical(args[4])

if(infile1 != "_"){
	# Loading
	if(x_new_sparse){
		X_new <- readMM(infile1)
		if(length(which(slotNames(X_new) == "x"))){
			checkNegative <- length(which(X_new@x < 0)) != 0
		}else{
			checkNegative <- FALSE
		}
	}else{
		X_new <- as.matrix(read.table(infile1, header=FALSE))
		checkNegative <- length(which(X_new < 0)) != 0
	}
	initH <- as.matrix(read.table(infile2, header=FALSE))
	# Check
	checkSameSize <- ncol(X_new) != nrow(initH)
	if(checkSameSize){
		stop("Column size of X_new and row size of H must be the same!!!")
	}
	if(checkNegative){
		stop("Negative elements found!!!")
	}
}
file.create(outfile)
