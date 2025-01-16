# cluster
An implementation of the UZH s3it [example snakemake pipeline](https://docs.s3it.uzh.ch/how-to_articles/how_to_run_snakemake/) in nextflow.
## Requesting an interactive session
```
srun --pty -n 1 -c 1 --time=01:00:00 --mem=4G bash -l
```
## Creating environment from file
```
module load mamba
mamba env create -f nextflow.yml
source activate nextflow
```
## Terminating an interative session
Type `exit` or press `Ctrl+D`.
## Submit sumbission script
```
sbatch run_cluster_test.slurm
```
