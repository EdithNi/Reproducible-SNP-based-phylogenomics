rule all:
    input:
        "results/phylogeny/tree.nwk",
        "results/amr/resfinder_results.txt"


rule clean_reads:
    input:
        R1="data/raw_reads/{sample}_R1.fastq.gz",
        R2="data/raw_reads/{sample}_R2.fastq.gz"
    output:
        R1="results/clean_reads/{sample}_R1.clean.fastq.gz",
        R2="results/clean_reads/{sample}_R2.clean.fastq.gz"
    shell:
        """
        fqCleanER \
        -i {input.R1} \
        -I {input.R2} \
        -o results/clean_reads/
        """


rule assembly:
    input:
        R1="results/clean_reads/{sample}_R1.clean.fastq.gz",
        R2="results/clean_reads/{sample}_R2.clean.fastq.gz"
    output:
        "results/assembly/{sample}/contigs.fasta"
    shell:
        """
        spades.py \
        --careful \
        -1 {input.R1} \
        -2 {input.R2} \
        -o results/assembly/{wildcards.sample}
        """


rule snp_calling:
    input:
        R1="results/clean_reads/{sample}_R1.clean.fastq.gz",
        R2="results/clean_reads/{sample}_R2.clean.fastq.gz"
    output:
        "results/snps/{sample}/snps.vcf"
    params:
        ref="reference/98K.fasta"
    shell:
        """
        snippy \
        --ref {params.ref} \
        --R1 {input.R1} \
        --R2 {input.R2} \
        --outdir results/snps/{wildcards.sample}
        """


rule phylogeny:
    input:
        "results/snps/core.full.aln"
    output:
        "results/phylogeny/tree.nwk"
    shell:
        """
        raxmlHPC \
        -s {input} \
        -n tree \
        -m GTRGAMMAI \
        -# 1000 \
        -p 12345 \
        -w results/phylogeny/
        """


rule resfinder:
    input:
        "results/assembly/{sample}/contigs.fasta"
    output:
        "results/amr/{sample}_resfinder.txt"
    shell:
        """
        run_resfinder.py \
        -ifa {input} \
        -o results/amr/{wildcards.sample}
        """
