#!/bin/bash 

#SBATCH --nodes 1
#SBATCH --mem=6gb
#SBATCH --ntasks=1
#SBATCH --time 03:00:00
#SBATCH --output slurm_%x_%A_%a.out

bam_input_dir=$1
chr_sizes_file=$2
custom_bin_size=$3

for treatment_file in $bam_input_dir/*picardreorder_*
	do
		if [[ ! "$(basename $treatment_file)" =~ control && ! "$(basename $treatment_file)" =~ input ]]; then
			sample_type=$(basename $treatment_file | sed 's/_trimgalore_bowtie2_.*$//')
			SRR_id=$(basename $treatment_file | sed 's/.*dupremoved_SRR/SRR/' | sed ' s/\..*$//')
			input_file=$(ls $bam_input_dir | awk '/picardreorder_/' | egrep 'control|input && $sample_type') 
			srun /g/funcgen/bin/hiddenDomains -g $chr_sizes_file -b $custom_bin_size -t $treatment_file -c $bam_input_dir/$input_file -o $sample_type.$SRR_id.$custom_bin_size
		else
			sample_type=$(basename $treatment_file | sed 's/_trimgalore_bowtie2_.*$//')
			SRR_id=$(basename $treatment_file | sed 's/.*dupremoved_SRR/SRR/' | sed ' s/\..*$//')
			srun /g/funcgen/bin/hiddenDomains -g $chr_sizes_file -b $custom_bin_size -t $treatment_file -o $sample_type.$SRR_id.$custom_bin_size

		fi
	done

			
