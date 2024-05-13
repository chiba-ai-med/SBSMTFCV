# HTML
mkdir -p report
snakemake --report report/sbsmtfcv.html \
--config input=data/testdata.tsv outdir=output \
rank_min=2 rank_max=10 lambda_min=-10 lambda_max=10 \
trials=10 n_iter_max=100 ratio=5