# cluster
## Requesting an interactive session
```
srun --pty -n 1 -c 1 --time=01:00:00 --mem=4G bash -l
```
## Terminating an interative session
```
exit
```
## Creating environment from file
```
module mamba
mamba env create -f environment.yml
source activate environment
```
## Listing available modules
```
module avail
```