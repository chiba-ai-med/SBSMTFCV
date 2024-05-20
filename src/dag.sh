# DAG graph
mkdir -p plot
snakemake --rulegraph --config input=data/testdata.tsv outdir=output rank_min=2 rank_max=10 lambda_min=-10 lambda_max=10 trials=10 n_iter_max=100 beta=2 ratio=5 | dot -Tpng > plot/dag.png