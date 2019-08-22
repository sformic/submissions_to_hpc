FASTQ_INPUT_DIR = "/g/boulard/sformich/galaxy_transfer/H3K4me3_Ren_Snyder/input_data/"
OUTPUT_DIR = "/g/boulard/sformich/analyses/H3K4me3_Ren_Snyder/output_files/"
SAMPLES = "Ren_ChIP.fastqsanger"

rule all:
  input:
    expand("{path}{sample}_fastqc.html", path=OUTPUT_DIR, sample=SAMPLES)

rule fastqc_my_file:
  input:
    expand("{path}{{fastq_name}}.gz", path=FASTQ_INPUT_DIR)
  params:
    output_dir=OUTPUT_DIR
  output:
    expand("{path}{{fastq_name}}_fastqc.html", path=OUTPUT_DIR)
	#expand("{path}{{fastq_name}}_fastqc.zip", path=OUTPUT_DIR)
  shell:
    "fastqc -o {params.output_dir} {input}"
