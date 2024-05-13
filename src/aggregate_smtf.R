source("src/Functions.R")

args <- commandArgs(trailingOnly = TRUE)
rank_min <- as.numeric(args[1])
rank_max <- as.numeric(args[2])
trials <- as.numeric(args[3])
outdir <- args[4]
outfile <- args[5]

# Setting
rank_index = rank_min:rank_max
trial_index = seq_len(trials)

# Loading
out <- expand.grid(trial=trial_index, rank=rank_index, value=0)
count <- 1
for(i in seq_along(rank_index)){
	for(j in trial_index){
		filename = paste0(outdir, "/smtf/", rank_index[i], "/", j, "_error.txt")
		out[count, 3] <- read.table(filename)
		count <- count + 1
	}
}

# Log-transformation
out[,3] <- log10(out[,3])

# Save
write.table(out, outfile, row.names=FALSE, col.names=FALSE, quote=FALSE)