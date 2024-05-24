source("src/Functions.R")

args <- commandArgs(trailingOnly = TRUE)
lambda_min <- as.numeric(args[1])
lambda_max <- as.numeric(args[2])
trials <- as.numeric(args[3])
outdir <- args[4]
outfile <- args[5]
bin_w <- as.logical(args[6])

if(bin_w){
	# Setting
	lambda_index = lambda_min:lambda_max
	trial_index = seq_len(trials)

	# Loading
	out <- expand.grid(trial=trial_index, lambda=lambda_index, value=0)
	count <- 1
	for(i in seq_along(lambda_index)){
		for(j in trial_index){
			filename = paste0(outdir, "/sbmf/", lambda_index[i], "/", j, "_error.txt")
			out[count, 3] <- read.table(filename)
			count <- count + 1
		}
	}

	# Save
	write.table(out, outfile, row.names=FALSE, col.names=FALSE, quote=FALSE)
}else{
	file.create(outfile)
}
