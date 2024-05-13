args <- commandArgs(trailingOnly = TRUE)
infile <- args[1]
outfile <- args[2]

# Loading
data <- as.matrix(read.table(infile, header=FALSE))

checkNegative <- length(which(data < 0)) != 0
if(checkNegative){
	stop("Negative elements found!!!")
}else{
	file.create(outfile)
}