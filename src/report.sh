# HTML
mkdir -p report
snakemake --report report/sbsmtfcv.html \
--config input=data/testdata.tsv outdir=output