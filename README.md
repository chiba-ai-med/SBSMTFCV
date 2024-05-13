# SBSMTFCV

[![Snakemake](https://img.shields.io/badge/snakemake-≥7.30.1-brightgreen.svg)](https://snakemake.github.io)
[![DOI](https://zenodo.org/badge/???.svg)](https://zenodo.org/badge/latestdoi//???.)
![GitHub Actions](https://github.com/chiba-ai-med/SBSMTFCV/actions/workflows/build_test_push.yml/badge.svg)
![GitHub Actions](https://github.com/chiba-ai-med/SBSMTFCV/actions/workflows/dockerrun1.yml/badge.svg)
![GitHub Actions](https://github.com/chiba-ai-med/SBSMTFCV/actions/workflows/dockerrun2.yml/badge.svg)
![GitHub Actions](https://github.com/chiba-ai-med/SBSMTFCV/actions/workflows/dockerrun3.yml/badge.svg)
![GitHub Actions](https://github.com/chiba-ai-med/SBSMTFCV/actions/workflows/unittest1.yml/badge.svg)
![GitHub Actions](https://github.com/chiba-ai-med/SBSMTFCV/actions/workflows/unittest2.yml/badge.svg)
![GitHub Actions](https://github.com/chiba-ai-med/SBSMTFCV/actions/workflows/release-please.yml/badge.svg)
[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Fchiba-ai-med%2FSBSMTFCV.svg?type=shield)](https://app.fossa.com/projects/git%2Bgithub.com%2Fchiba-ai-med%2FSBSMTFCV?ref=badge_shield)

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

**Note: To check if the command is executable, set smaller parameters such as rank_min=2 rank_max=2 lambda_max=2 lambda_min=2 trials=2 n_iter_max=2.**

```bash
snakemake -j 4 --config input=data/testdata.tsv outdir=output rank_min=2 \
rank_max=10 lambda_min=-10 lambda_max=10 trials=10 \
n_iter_max=100 ratio=20 --resources mem_gb=10 --use-singularity
```

The meanings of all the arguments are below.

- `-j`: Snakemake option to set [the number of cores](https://snakemake.readthedocs.io/en/stable/executing/cli.html#useful-command-line-arguments) (e.g. 10, mandatory)
- `--config`: Snakemake option to set [the configuration](https://snakemake.readthedocs.io/en/stable/snakefiles/configuration.html) (mandatory)
- `input`: Input file (e.g., testdata.tsv, mandatory)
- `outdir`: Output directory (e.g., output, mandatory)
- `rank_min`: Lower limit of rank parameter to search (e.g., 2, which is used for the rank parameter J of dNMF, mandatory)
- `rank_max`: Upper limit of rank parameter to search (e.g., 10, which is used for the rank parameter J of dNMF, mandatory)
- `lambda_min`: Lower limit of lambda parameter to search (e.g., -10, which means 10^-10 is used for the binary regularization parameter Bin_U of dNMF, mandatory)
- `lambda_max`: Upper limit of lambda parameter to search (e.g., -10, which means 10^10 is used for the binary regularization parameter Bin_U of dNMF, mandatory)
- `trials`: Number of random trials (e.g., 50, mandatory)
- `n_iter_max`: Number of iterations (e.g., 100, mandatory)
- `ratio`: Sampling ratio of cross-validation (0 - 100, e.g., 20, mandatory)
- `--resources`: Snakemake option to control [resources](https://snakemake.readthedocs.io/en/stable/snakefiles/rules.html#resources) (optional)
- `mem_gb`: Memory usage (GB, e.g. 10, optional)
- `--use-singularity`: Snakemake option to use Docker containers via [`Singularity`](https://snakemake.readthedocs.io/en/stable/snakefiles/deployment.html) (mandatory)

## Example with the parallel environment (GridEngine)

If the `GridEngine` (`qsub` command) is available in your environment, you can add the `qsub` command. Just adding the `--cluster` option, the jobs are submitted to multiple nodes and the computations are distributed.

**Note: To check if the command is executable, set smaller parameters such as rank_min=2 rank_max=2 lambda_max=2 lambda_min=2 trials=2 n_iter_max=2.**

```bash
snakemake -j 4 --config input=data/testdata.tsv outdir=output rank_min=2 \
rank_max=10 lambda_min=-10 lambda_max=10 trials=10 \
n_iter_max=100 ratio=20 --resources mem_gb=10 --use-singularity \
--cluster "qsub -l nc=4 -p -50 -r yes" --latency-wait 60
```

## Example with the parallel environment (Slurm)

Likewise, if the `Slurm` (`sbatch` command) is available in your environment, you can add the `sbatch` command after the `--cluster` option.

**Note: To check if the command is executable, set smaller parameters such as rank_min=2 rank_max=2 lambda_max=2 lambda_min=2 trials=2 n_iter_max=2.**

```bash
snakemake -j 4 --config input=data/testdata.tsv outdir=output rank_min=2 \
rank_max=10 lambda_min=-10 lambda_max=10 trials=10 \
n_iter_max=100 ratio=20 --resources mem_gb=10 --use-singularity \
--cluster "sbatch -n 4 --nice=50 --requeue" --latency-wait 60
```

## Example with a local machine with Docker

If the `docker` command is available, the following command can be performed without installing any tools.

**Note: To check if the command is executable, set smaller parameters such as rank_min=2 rank_max=2 lambda_max=2 lambda_min=2 trials=2 n_iter_max=2.**

```bash
docker run --rm -v $(pwd):/work ghcr.io/chiba-ai-med/sbsmtfcv:main \
-i /work/data/testdata.tsv -o /work/output \
--cores=4 --rank_min=2 --rank_max=10 \
--lambda_min=-10 --lambda_max=10 --trials=10 \
--n_iter_max=100 --ratio=20 --memgb=10
```

# Reference
- [dcTensor](https://cran.r-project.org/web/packages/dcTensor/index.html)

# Authors
- Koki Tsuyuzaki
- Eiryo Kawakami
