source("src/Functions.R")

args <- commandArgs(trailingOnly = TRUE)
trials <- as.numeric(args[1])
outdir <- args[2]
outfile <- args[3]

# Setting
trial_index = seq_len(trials)

# Loading
rec_error <- data.frame(trial=trial_index, value=0)
count <- 1
for(i in trial_index){
	print(i)
	filename = paste0(outdir, "/bestrank_bestlambda_sbsmtf/", i, ".RData")
	load(filename)
	rec_error[count, 2] <- rev(out$RecError)[1]
	count <- count + 1
}

# Save
write.table(rec_error, outfile, row.names=FALSE, col.names=FALSE, quote=FALSE)