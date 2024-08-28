# cluster
## Requesting an interactive session
```
srun --pty -n 1 -c 1 --time=01:00:00 --mem=4G bash -l
```
## Creating environment from file
```
module mamba
mamba env create -f nextflow.yml
source activate nextflow
```
## Terminating an interative session
```
exit
```
## Submit sumbission script
```
chmod +x run_cluster_test.sh
sbatch run_cluster_test.sh
```