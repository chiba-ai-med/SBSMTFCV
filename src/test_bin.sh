echo "TRUE / TRUE wo x_new_list"
snakemake -j 10 \
--config input=data/testdata.tsv outdir=output_bin1 rank_min=2 \
rank_max=3 lambda_min=9 lambda_max=10 trials=2 \
n_iter_max=10 \
input_sparse=FALSE output_sparse=FALSE \
x_new_sparse=FALSE w_new_sparse=FALSE \
bin_h=TRUE bin_w_new=TRUE \
beta=2 ratio=20 --resources mem_gb=10 --use-singularity

echo "FALSE / TRUE wo x_new_list"
snakemake -j 10 \
--config input=data/testdata.tsv outdir=output_bin2 rank_min=2 \
rank_max=3 lambda_min=9 lambda_max=10 trials=2 \
n_iter_max=10 \
input_sparse=FALSE output_sparse=FALSE \
x_new_sparse=FALSE w_new_sparse=FALSE \
bin_h=FALSE bin_w_new=TRUE \
beta=2 ratio=20 --resources mem_gb=10 --use-singularity

echo "TRUE / FALSE wo x_new_list"
snakemake -j 10 \
--config input=data/testdata.tsv outdir=output_bin3 rank_min=2 \
rank_max=3 lambda_min=9 lambda_max=10 trials=2 \
n_iter_max=10 \
input_sparse=FALSE output_sparse=FALSE \
x_new_sparse=FALSE w_new_sparse=FALSE \
bin_h=TRUE bin_w_new=FALSE \
beta=2 ratio=20 --resources mem_gb=10 --use-singularity

echo "FALSE / FALSE wo x_new_list"
snakemake -j 10 \
--config input=data/testdata.tsv outdir=output_bin4 rank_min=2 \
rank_max=3 lambda_min=9 lambda_max=10 trials=2 \
n_iter_max=10 \
input_sparse=FALSE output_sparse=FALSE \
x_new_sparse=FALSE w_new_sparse=FALSE \
bin_h=FALSE bin_w_new=FALSE \
beta=2 ratio=20 --resources mem_gb=10 --use-singularity

echo "TRUE / TRUE"
snakemake -j 10 \
--config input=data/testdata.tsv outdir=output_bin5 rank_min=2 \
rank_max=3 lambda_min=9 lambda_max=10 trials=2 \
n_iter_max=10 x_new_list="data/x_new_list.txt" \
input_sparse=FALSE output_sparse=FALSE \
x_new_sparse=FALSE w_new_sparse=FALSE \
bin_h=TRUE bin_w_new=TRUE \
beta=2 ratio=20 --resources mem_gb=10 --use-singularity

echo "FALSE / TRUE"
snakemake -j 10 \
--config input=data/testdata.tsv outdir=output_bin6 rank_min=2 \
rank_max=3 lambda_min=9 lambda_max=10 trials=2 \
n_iter_max=10 x_new_list="data/x_new_list.txt" \
input_sparse=FALSE output_sparse=FALSE \
x_new_sparse=FALSE w_new_sparse=FALSE \
bin_h=FALSE bin_w_new=TRUE \
beta=2 ratio=20 --resources mem_gb=10 --use-singularity

echo "TRUE / FALSE"
snakemake -j 10 \
--config input=data/testdata.tsv outdir=output_bin7 rank_min=2 \
rank_max=3 lambda_min=9 lambda_max=10 trials=2 \
n_iter_max=10 x_new_list="data/x_new_list.txt" \
input_sparse=FALSE output_sparse=FALSE \
x_new_sparse=FALSE w_new_sparse=FALSE \
bin_h=TRUE bin_w_new=FALSE \
beta=2 ratio=20 --resources mem_gb=10 --use-singularity

echo "FALSE / FALSE"
snakemake -j 10 \
--config input=data/testdata.tsv outdir=output_bin8 rank_min=2 \
rank_max=3 lambda_min=9 lambda_max=10 trials=2 \
n_iter_max=10 x_new_list="data/x_new_list.txt" \
input_sparse=FALSE output_sparse=FALSE \
x_new_sparse=FALSE w_new_sparse=FALSE \
bin_h=FALSE bin_w_new=FALSE \
beta=2 ratio=20 --resources mem_gb=10 --use-singularity
