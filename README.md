# Submissions to EMBL HPC 

## How to run snakemake pipelines on the EMBL cluster using conda environments

This section contains the description of the steps I follow to run my snakemake pipelines on the EMBL cluster using conda environments.

0. go on seneca
1. by default, conda will create environments and download packages in the .conda folder in your home directory --> this would lead your home directory to get full and give an error when trying to create your personal conda environment --> you need to create the file ~/.condarc file containing the following:
e.g. 
```
pkgs_dirs:
  - /g/boulard/sformich/conda/pkgs
envs_dirs:
  - /g/boulard/sformich/conda/envs
channels:
  - bioconda
  - conda-forge
  - r
  - defaults
```
2. $ module spider conda --> load latest conda package Anaconda3/2019.07 with $ module load Anaconda3/2019.07
3. $ conda init bash #to use the 'conda activate' command later #not sure it is necessay anymore with latest conda versions
4. restart the shell and load conda module again
5. add the bioconda channel as well as the other channels bioconda depends on. 

* From bioconda documentation: "It is important to add them in this order so that the priority is set correctly (that is, bioconda is highest priority).
* The conda-forge channel contains many general-purpose packages not already found in the defaults channel. The r channel contains common R packages used as dependencies for bioconda packages. 
* In practice:
``` shell
conda config --add channels conda-forge
conda config --add channels defaults
conda config --add channels r
conda config --add channels bioconda
```
UNTIL STEP 5, YOU NEED TO REPEAT THESE STEPS ONLY WHENEVER YOU MAKE CHANGES TO THE ~./.condarc FILE BY ADDING CHANNELS ETC! OTHERWISE, JUST PERFORM STEP 2 AND JUMP TO STEP 6 

6. create a yml file containing the channels and the dependencies your workflow is going to use. In order to find a channel:
```shell
conda search fastqc
```
7. create the environment using that file, e.g.:
```shell
conda env create --file environment.yml -n smake
```
Once the environment is created, a folder named as the environment will be created --> IF YOU CLOSE AND REOPEN THE SHELL, THE ONLY THING YOU NEED TO DO IS:
```shell
module load Anaconda3/2019.07
conda activate nameOfTheEnvironment
cd folderWhereYouHaveSnakefile
snakemake
```
8. activate the environment: 
```shell
conda activate smake
```
9. now you can run snakemake in the folder where you have the Snakefile (workflowName/Snakefile)
10.for R packages:



In my case, the result is that I have:

1. in /g/boulard/sformich/conda/envs/: folders named as the environment names i.e. e.g. smake_ChIPSeq_1, containing all packages etc that conda installs when creating the environment (that nees to be created only once or whenever something is added to the envitonment.yml file)
2. in /g/boulard/sformich/analyses/[name of the specific analysis e.g.H3K4me3_Ren_Snyder]/: input/output folders and config.yaml file, which is the configuration file containing all variable which will be used by the snakemake file of the 'general' e.g. ChIP-Seq workflow
3. in /g/boulard/sformich/submissions_to_hpc/snakemake/[name of the 'general' analysis type e.g.ChIPSeq_1]/: it contains the Snakefile for the 'general' workflow
4. in /g/boulard/sformich/submissions_to_hpc/snakemake/envs/: environment.yml files (e.g.ChIPSeq_1.yml), each for one 'general' workflow
