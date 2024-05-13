args <- commandArgs(trailingOnly = TRUE)
infile <- args[1]
outfile1 <- args[2]
outfile2 <- args[3]

# Loading
out <- read.table(infile, header=FALSE)
colnames(out) <- c("trial", "value")

# Best Rank
min_position <- which(out[, 2] == min(out[, 2]))
best_trial <- out[min_position, 1]

# Loading
filename <- gsub("rec_error", best_trial, infile)
filename <- gsub(".csv", ".RData", filename)
load(filename)

# Save
write.table(out$U, outfile1, row.names=FALSE, col.names=FALSE, quote=FALSE)
write.table(out$S, outfile2, row.names=FALSE, col.names=FALSE, quote=FALSE)