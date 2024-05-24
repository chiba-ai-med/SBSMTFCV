echo "TRUE / TRUE wo x_new_list"
snakemake -j 4 \
--config input=data/testdata.tsv outdir=output1 rank_min=2 \
rank_max=10 lambda_min=0 lambda_max=6 trials=5 \
n_iter_max=100 x_new_list="" bin_h=TRUE bin_w_new=TRUE \
beta=2 ratio=20 --resources mem_gb=10 --use-singularity

echo "FALSE / TRUE wo x_new_list"
snakemake -j 4 \
--config input=data/testdata.tsv outdir=output2 rank_min=2 \
rank_max=10 lambda_min=0 lambda_max=6 trials=5 \
n_iter_max=100 x_new_list="" bin_h=FALSE bin_w_new=TRUE \
beta=2 ratio=20 --resources mem_gb=10 --use-singularity

echo "TRUE / FALSE wo x_new_list"
snakemake -j 4 \
--config input=data/testdata.tsv outdir=output3 rank_min=2 \
rank_max=10 lambda_min=0 lambda_max=6 trials=5 \
n_iter_max=100 x_new_list="" bin_h=TRUE bin_w_new=FALSE \
beta=2 ratio=20 --resources mem_gb=10 --use-singularity

echo "FALSE / FALSE wo x_new_list"
snakemake -j 4 \
--config input=data/testdata.tsv outdir=output4 rank_min=2 \
rank_max=10 lambda_min=0 lambda_max=6 trials=5 \
n_iter_max=100 x_new_list="" bin_h=FALSE bin_w_new=FALSE \
beta=2 ratio=20 --resources mem_gb=10 --use-singularity

echo "TRUE / TRUE"
snakemake -j 4 \
--config input=data/testdata.tsv outdir=output5 rank_min=2 \
rank_max=10 lambda_min=0 lambda_max=6 trials=5 \
n_iter_max=100 x_new_list="data/x_new_list.txt" bin_h=TRUE bin_w_new=TRUE \
beta=2 ratio=20 --resources mem_gb=10 --use-singularity

echo "FALSE / TRUE"
snakemake -j 4 \
--config input=data/testdata.tsv outdir=output6 rank_min=2 \
rank_max=10 lambda_min=0 lambda_max=6 trials=5 \
n_iter_max=100 x_new_list="data/x_new_list.txt" bin_h=FALSE bin_w_new=TRUE \
beta=2 ratio=20 --resources mem_gb=10 --use-singularity

echo "TRUE / FALSE"
snakemake -j 4 \
--config input=data/testdata.tsv outdir=output7 rank_min=2 \
rank_max=10 lambda_min=0 lambda_max=6 trials=5 \
n_iter_max=100 x_new_list="data/x_new_list.txt" bin_h=TRUE bin_w_new=FALSE \
beta=2 ratio=20 --resources mem_gb=10 --use-singularity

echo "FALSE / FALSE"
snakemake -j 4 \
--config input=data/testdata.tsv outdir=output8 rank_min=2 \
rank_max=10 lambda_min=0 lambda_max=6 trials=5 \
n_iter_max=100 x_new_list="data/x_new_list.txt" bin_h=FALSE bin_w_new=FALSE \
beta=2 ratio=20 --resources mem_gb=10 --use-singularity
