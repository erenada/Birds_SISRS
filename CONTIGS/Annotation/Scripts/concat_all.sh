#!/bin/bash

#SBATCH --job-name="cat_all"
#SBATCH --time=100:00:00  # walltime limit (HH:MM:SS)
#SBATCH --nodes=1   # number of nodes
#SBATCH --ntasks-per-node=20   # CHANGE THIS to the number of processors on your node
#SBATCH --mail-user="erenada@uri.edu" #CHANGE THIS to your email address
#SBATCH --mail-type=ALL
#SBATCH -o %x_%A.out
#SBATCH -e %x_%A.err
#SBATCH --exclusive

cd $SLURM_SUBMIT_DIR

module purge

#CHANGE THESE IF NOT ON A URI SYSTEM

module load Python/3.7.4-GCCcore-8.3.0


PTH=(/data/schwartzlab/eren/Chapter1/SISRS_Run/aligned_contigs)
PTH_OUT=(/data/schwartzlab/eren/Chapter1/CONTIGS/Annotation/CONCAT/ALL)


cd $PTH

cp /data/schwartzlab/eren/Chapter1/CONTIGS/Annotation/Scripts/AMAS_ch1.py AMAS_ch1.py

getconf ARG_MAX

python3 AMAS_ch1.py concat -f fasta -d dna -i *fasta -c 20

mv ${PTH}/concatenated.out ${PTH_OUT}/all_concatenated.fasta
mv ${PTH}/partitions.txt ${PTH_OUT}/all_partitions.txt

rm AMAS_ch1.py