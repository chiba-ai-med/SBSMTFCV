# SBSMTFCV

[![Snakemake](https://img.shields.io/badge/snakemake-≥7.30.1-brightgreen.svg)](https://snakemake.github.io)
[![DOI](https://zenodo.org/badge/659959126.svg)](https://zenodo.org/doi/10.5281/zenodo.8189643)
![GitHub Actions](https://github.com/chiba-ai-med/SBSMTFCV/actions/workflows/build_test_push.yml/badge.svg)
![GitHub Actions](https://github.com/chiba-ai-med/SBSMTFCV/actions/workflows/dockerrun1.yml/badge.svg)
![GitHub Actions](https://github.com/chiba-ai-med/SBSMTFCV/actions/workflows/dockerrun2.yml/badge.svg)
![GitHub Actions](https://github.com/chiba-ai-med/SBSMTFCV/actions/workflows/dockerrun3.yml/badge.svg)
![GitHub Actions](https://github.com/chiba-ai-med/SBSMTFCV/actions/workflows/unittest1.yml/badge.svg)
![GitHub Actions](https://github.com/chiba-ai-med/SBSMTFCV/actions/workflows/unittest2.yml/badge.svg)
![GitHub Actions](https://github.com/chiba-ai-med/SBSMTFCV/actions/workflows/release-please.yml/badge.svg)
[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Fchiba-ai-med%2FSBSMTFCV.svg?type=shield&issueType=license)](https://app.fossa.com/projects/git%2Bgithub.com%2Fchiba-ai-med%2FSBSMTFCV?ref=badge_shield&issueType=license)

Cross validation workflow of Semi-Binary Symmetric Matrix Tri-Factorization (SBSMTF)

`SBSMTFCV` searches for the optimal hyper-parameters (rank and binary regularization parameters) for Semi-Binary Symmetric Matrix Tri-Factorization (SBSMTF) performed by `dcTensor::dNMTF`. In SBSMTF, a non-negative symmetric matrix A is decomposed to a matrix product U * S * U' and only U is imposed to have binary ({0,1}) values. For the details, see the vignette of [dNMTF](https://cran.r-project.org/web/packages/dcTensor/vignettes/dcTensor-2.html).

`SBSMTFCV` consists of the rules below:

![](https://github.com/chiba-ai-med/SBSMTFCV/blob/main/plot/dag.png?raw=true)

# Pre-requisites (our experiment)
- Snakemake: v7.30.1
- Singularity: v3.7.1
- Docker: v20.10.10 (optional)

`Snakemake` is available via Python package managers like `pip`, `conda`, or `mamba`.

`Singularity` and `Docker` are available by the installer provided in each website or package manager for each OS like `apt-get/yum` for Linux, or `brew` for Mac.

For the details, see the installation documents below.

- https://snakemake.readthedocs.io/en/stable/getting_started/installation.html
- https://docs.sylabs.io/guides/3.0/user-guide/installation.html
- https://docs.docker.com/engine/install/

**Note: The following source code does not work on M1/M2 Mac. M1/M2 Mac users should refer to [README_AppleSilicon.md](README_AppleSilicon.md) instead.**

# Usage

In this demo, we use a toy data matrix (data/testdata.tsv) consisting of 13 rows and 13 columns but any non-negative symmetric matrix can be specified by user.

*Note that the input file is assumed to be tab separated values (TSV) format with no row/column names.*

## Download this GitHub repository

First, download this GitHub repository and change the working directory.

```bash
git clone https://github.com/chiba-ai-med/SBSMTFCV.git
cd SBSMTFCV
```

## Example with local machine

Next, perform `SBSMTFCV` by the `snakemake` command as follows.

**Note: To check if the command is executable, set smaller parameters such as rank_min=2 rank_max=3 lambda_min=9 lambda_max=10 trials=2 n_iter_max=2.**

```bash
snakemake -j 4 --config input=data/testdata.tsv outdir=output rank_min=2 \
rank_max=10 lambda_min=1 lambda_max=10 trials=10 \
n_iter_max=100 x_new_list="" \
input_sparse=FALSE output_sparse=FALSE \
x_new_sparse=FALSE w_new_sparse=FALSE \
bin_h=TRUE bin_w_new=FALSE \
beta=2 ratio=20 --resources mem_gb=10 --use-singularity
```

The meanings of all the arguments are below.

- `-j`: Snakemake option to set [the number of cores](https://snakemake.readthedocs.io/en/stable/executing/cli.html#useful-command-line-arguments) (e.g. 10, mandatory)
- `--config`: Snakemake option to set [the configuration](https://snakemake.readthedocs.io/en/stable/snakefiles/configuration.html) (mandatory)
- `input`: Input file (e.g., testdata.tsv, mandatory)
- `outdir`: Output directory (e.g., output, mandatory)
- `rank_min`: Lower limit of rank parameter to search (Default value is 2, which is used for the rank parameter J of dNMF, optional)
- `rank_max`: Upper limit of rank parameter to search (Default value is 10, which is used for the rank parameter J of dNMF, optional)
- `lambda_min`: Lower limit of lambda parameter to search (Default value is 1, which means 10^1 is used for the binary regularization parameter Bin_U of dNMF, optional)
- `lambda_max`: Upper limit of lambda parameter to search (Default value is 10, which means 10^10 is used for the binary regularization parameter Bin_U of dNMF, optional)
- `trials`: Number of random trials (Default value is 10, optional)
- `n_iter_max`: Number of iterations (Default value is 100, optional)
- `x_new_list`: X_new file list to predict U_new values (Default value is "", which means no prediction is performed, optional)
- `input_sparse`: Whether the input data is formatted as Matrix Market <MM> (Default value is FALSE, optional)
- `output_sparse`: Whether the output data is formatted as Matrix Market <MM> (Default value is FALSE, optional)
- `x_new_sparse`: Whether the X_new data is formatted as Matrix Market <MM> (Default value is FALSE, optional)
- `w_new_sparse`: Whether the W_new is formatted as Matrix Market <MM> (Default value is FALSE, optional)
- `bin_h`: Whether the binarization of H is perfomed (Default value is TRUE, optional)
- `bin_w_new`: Whether the binarization of W_new is perfomed (Default value is FALSE, optional)
- `beta`: Parameter for Beta-divergence (Default value is 2, optional)
- `ratio`: Sampling ratio of cross-validation (Default value is 20, optional)
- `--resources`: Snakemake option to control [resources](https://snakemake.readthedocs.io/en/stable/snakefiles/rules.html#resources) (optional)
- `mem_gb`: Memory usage (GB, e.g. 10, optional)
- `--use-singularity`: Snakemake option to use Docker containers via [`Singularity`](https://snakemake.readthedocs.io/en/stable/snakefiles/deployment.html) (mandatory)

## Example with the parallel environment (GridEngine)

If the `GridEngine` (`qsub` command) is available in your environment, you can add the `qsub` command. Just adding the `--cluster` option, the jobs are submitted to multiple nodes and the computations are distributed.

**Note: To check if the command is executable, set smaller parameters such as rank_min=2 rank_max=3 lambda_max=9 lambda_min=10 trials=2 n_iter_max=2.**

```bash
snakemake -j 4 --config input=data/testdata.tsv outdir=output rank_min=2 \
rank_max=10 lambda_min=1 lambda_max=10 trials=10 \
n_iter_max=100 x_new_list="" \
input_sparse=FALSE output_sparse=FALSE \
x_new_sparse=FALSE w_new_sparse=FALSE \
bin_h=TRUE bin_w_new=FALSE \
beta=2 ratio=20 --resources mem_gb=10 --use-singularity \
--cluster "qsub -l nc=4 -p -50 -r yes" --latency-wait 60
```

## Example with the parallel environment (Slurm)

Likewise, if the `Slurm` (`sbatch` command) is available in your environment, you can add the `sbatch` command after the `--cluster` option.

**Note: To check if the command is executable, set smaller parameters such as rank_min=2 rank_max=3 lambda_min=9 lambda_max=10 trials=2 n_iter_max=2.**

```bash
snakemake -j 4 --config input=data/testdata.tsv outdir=output rank_min=2 \
rank_max=10 lambda_min=1 lambda_max=10 trials=10 \
n_iter_max=100 x_new_list="" \
input_sparse=FALSE output_sparse=FALSE \
x_new_sparse=FALSE w_new_sparse=FALSE \
bin_h=TRUE bin_w_new=FALSE \
beta=2 ratio=20 --resources mem_gb=10 --use-singularity \
--cluster "sbatch -n 4 --nice=50 --requeue" --latency-wait 60
```

## Example with a local machine with Docker

If the `docker` command is available, the following command can be performed without installing any tools.

**Note: To check if the command is executable, set smaller parameters such as rank_min=2 rank_max=3 lambda_min=9 lambda_max=10 trials=2 n_iter_max=2.**

```bash
docker run --rm -v $(pwd):/work ghcr.io/chiba-ai-med/sbsmtfcv:main \
-i /work/data/testdata.tsv -o /work/output \
--cores=4 --rank_min=2 --rank_max=10 \
--lambda_min=1 --lambda_max=10 --trials=10 \
--n_iter_max=100 --x_new_list="" \
--input_sparse=FALSE --output_sparse=FALSE \
--x_new_sparse=FALSE --w_new_sparse=FALSE \
--bin_h=TRUE ––bin_w_new=FALSE \
--beta=2 --ratio=20 --memgb=10
```

## For Snakemake >=8 users
`--cluster CMD` option was removed from Snakemake v8.
Use `--executor cluster-generic --cluster-generic-submit-cmd CMD` instead.
To use this new feature, you have to install `snakemake-executor-plugin-cluster-generic` in advance.

cf.

https://stackoverflow.com/questions/77929511/how-to-run-snakemake-8-on-a-slurm-cluster
https://snakemake.readthedocs.io/en/latest/getting_started/migration.html#migrating-to-snakemake-8

# Reference
- [dcTensor](https://cran.r-project.org/web/packages/dcTensor/index.html)

# Authors
- Koki Tsuyuzaki
- Eiryo Kawakami
