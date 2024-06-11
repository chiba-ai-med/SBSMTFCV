echo "DENSE / DENSE wo x_new_list"
snakemake -j 10 \
--config input=data/testdata.tsv outdir=output1 rank_min=2 \
rank_max=3 lambda_min=9 lambda_max=10 trials=2 \
n_iter_max=10 \
input_sparse=FALSE output_sparse=FALSE \
x_new_sparse=FALSE w_new_sparse=FALSE \
bin_h=TRUE bin_w_new=FALSE \
beta=2 ratio=20 --resources mem_gb=10 --use-singularity

echo "SPARSE / DENSE wo x_new_list"
snakemake -j 10 \
--config input=data/testdata_sparse.tsv outdir=output2 rank_min=2 \
rank_max=3 lambda_min=9 lambda_max=10 trials=2 \
n_iter_max=10 \
input_sparse=TRUE output_sparse=TRUE \
x_new_sparse=FALSE w_new_sparse=FALSE \
bin_h=FALSE bin_w_new=FALSE \
beta=2 ratio=20 --resources mem_gb=10 --use-singularity

echo "DENSE / SPARSE wo x_new_list"
snakemake -j 10 \
--config input=data/testdata.tsv outdir=output3 rank_min=2 \
rank_max=3 lambda_min=9 lambda_max=10 trials=2 \
n_iter_max=10 \
input_sparse=FALSE output_sparse=FALSE \
x_new_sparse=TRUE w_new_sparse=TRUE \
bin_h=TRUE bin_w_new=FALSE \
beta=2 ratio=20 --resources mem_gb=10 --use-singularity

echo "SPARSE / SPARSE wo x_new_list"
snakemake -j 10 \
--config input=data/testdata_sparse.tsv outdir=output4 rank_min=2 \
rank_max=3 lambda_min=9 lambda_max=10 trials=2 \
n_iter_max=10 \
input_sparse=TRUE output_sparse=TRUE \
x_new_sparse=TRUE w_new_sparse=TRUE \
bin_h=FALSE bin_w_new=FALSE \
beta=2 ratio=20 --resources mem_gb=10 --use-singularity

echo "DENSE / DENSE"
snakemake -j 10 \
--config input=data/testdata.tsv outdir=output5 rank_min=2 \
rank_max=3 lambda_min=9 lambda_max=10 trials=2 \
n_iter_max=10 x_new_list="data/x_new_list.txt" \
input_sparse=FALSE output_sparse=FALSE \
x_new_sparse=FALSE w_new_sparse=FALSE \
bin_h=TRUE bin_w_new=FALSE \
beta=2 ratio=20 --resources mem_gb=10 --use-singularity

echo "SPARSE / DENSE"
snakemake -j 10 \
--config input=data/testdata_sparse.tsv outdir=output6 rank_min=2 \
rank_max=3 lambda_min=9 lambda_max=10 trials=2 \
n_iter_max=10 x_new_list="data/x_new_list.txt" \
input_sparse=TRUE output_sparse=TRUE \
x_new_sparse=FALSE w_new_sparse=FALSE \
bin_h=FALSE bin_w_new=FALSE \
beta=2 ratio=20 --resources mem_gb=10 --use-singularity

echo "DENSE / SPARSE"
snakemake -j 10 \
--config input=data/testdata.tsv outdir=output7 rank_min=2 \
rank_max=3 lambda_min=9 lambda_max=10 trials=2 \
n_iter_max=10 x_new_list="data/x_new_list_sparse.txt" \
input_sparse=FALSE output_sparse=FALSE \
x_new_sparse=TRUE w_new_sparse=TRUE \
bin_h=TRUE bin_w_new=FALSE \
beta=2 ratio=20 --resources mem_gb=10 --use-singularity

echo "SPARSE / SPARSE"
snakemake -j 10 \
--config input=data/testdata_sparse.tsv outdir=output8 rank_min=2 \
rank_max=3 lambda_min=9 lambda_max=10 trials=2 \
n_iter_max=10 x_new_list="data/x_new_list_sparse.txt" \
input_sparse=TRUE output_sparse=TRUE \
x_new_sparse=TRUE w_new_sparse=TRUE \
bin_h=FALSE bin_w_new=FALSE \
beta=2 ratio=20 --resources mem_gb=10 --use-singularity
