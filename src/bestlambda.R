source("src/Functions.R")

args <- commandArgs(trailingOnly = TRUE)
infile <- args[1]
outfile <- args[2]

# Loading
out <- read.table(infile, header=FALSE)
colnames(out) <- c("trial", "lambda", "value")

# Best lambda
group_by(out, lambda) |> summarize(Avg = mean(value)) -> avg
min_position <- which(avg[, 2] >= 90)[1]
best_lambda <- avg[min_position, 1]

# Save
write.table(as.numeric(best_lambda), outfile, row.names=FALSE, col.names=FALSE, quote=FALSE)