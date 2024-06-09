source("src/Functions.R")

args <- commandArgs(trailingOnly = TRUE)
infile <- args[1]
outfile <- args[2]
input_sparse <- as.logical(args[3])

if(input_sparse){
	data <- readMM(infile)
	if(length(which(slotNames(data) == "x"))){
		checkNegative <- length(which(data@x < 0)) != 0
	}else{
		checkNegative <- FALSE
	}
}else{
	data <- as.matrix(read.table(infile, header=FALSE))
	checkNegative <- length(which(data < 0)) != 0
}

# Negative Value Check
if(checkNegative){
	stop("Negative elements found!!!")
}else{
	# Save
	file.create(outfile)
}
