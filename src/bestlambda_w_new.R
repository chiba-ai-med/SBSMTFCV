source("src/Functions.R")

args <- commandArgs(trailingOnly = TRUE)
infile1 <- args[1]
infile2 <- args[2]
outfile <- args[3]
bin_h <- as.logical(args[4])
bin_w <- as.logical(args[5])

if(bin_h){
	file.copy(infile2, outfile, overwrite = TRUE)
}else{
	if(bin_w){
		if(file.info(infile1)$size != 0){
			# Loading
			out <- read.table(infile1, header=FALSE)
			colnames(out) <- c("trial", "lambda", "value")

			# Best lambda
			group_by(out, lambda) |> summarize(Avg = mean(value)) -> avg
			min_position <- which(avg[, 2] >= 90)[1]
			if(is.na(min_position)){
				msg1 <- "The factor matrix is not yet sufficiently binarized."
				msg2 <- "Set a larger --lambda_max value!!!"
				msg <- paste(msg1, msg2)
				stop(msg)
			}
			best_lambda <- avg[min_position, 1]

			# Save
			write.table(10^as.numeric(best_lambda), outfile, row.names=FALSE, col.names=FALSE, quote=FALSE)
		}else{
			write.table(1E-10, outfile, row.names=FALSE, col.names=FALSE, quote=FALSE)
		}
	}else{
		write.table(1E-10, outfile, row.names=FALSE, col.names=FALSE, quote=FALSE)
	}
}
