source("src/Functions.R")

args <- commandArgs(trailingOnly = TRUE)
infile <- args[1]
outfile <- args[2]

# Loading
out <- read.table(infile, header=FALSE)
colnames(out) <- c("trial", "rank", "value")

# Best Rank
group_by(out, rank) |> summarize(Avg = mean(value)) -> avg
min_position <- which(avg[, 2] == min(avg[, 2]))
best_rank <- avg[min_position, 1]

# Save
write.table(as.numeric(best_rank), outfile, row.names=FALSE, col.names=FALSE, quote=FALSE)