source("src/Functions.R")

args <- commandArgs(trailingOnly = TRUE)
infile <- args[1]
outfile <- args[2]
bin <- as.logical(args[3])

if(bin){
	# Loading
	out <- read.table(infile, header=FALSE)
	colnames(out) <- c("trial", "lambda", "value")

	# Plot
	g <- ggplot(out, aes(x=lambda, y=value)) +
	geom_point() +
	stat_summary(fun = mean, geom = "point", shape=21, size=3, fill="blue") +
	stat_summary(fun = mean, geom = "line", colour = "blue", aes(group=1)) +
	xlab("Lambda") +
	ylab("0/1 Percentage (%)")
	ggsave(file=outfile, plot=g, dpi=200, width=14.0, height=7.0)
}else{
	file.create(outfile)
}
