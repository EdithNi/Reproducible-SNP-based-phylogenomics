# Reproducible-SNP-based-phylogenomics

# Reproducible Phylogenomics of Multidrug-Resistant *Salmonella enterica* serovar Kentucky ST198 in Burkina Faso

## Overview

This repository provides the bioinformatics workflow used to investigate the population structure and antimicrobial resistance determinants of *Salmonella enterica* serovar Kentucky ST198 isolates collected in Burkina Faso. The analysis was conducted within a One Health surveillance framework integrating isolates from clinical and food sources.

The workflow implements a reproducible genomic epidemiology pipeline including:

- quality control of sequencing reads
- genome assembly
- in silico genotyping
- high-resolution SNP phylogenomics
- antimicrobial resistance gene detection

The objective is to reconstruct the evolutionary relationships and resistance profiles of multidrug-resistant *Salmonella Kentucky* ST198 isolates circulating in West Africa.

All sequencing data are publicly available in the European Nucleotide Archive (ENA) under accession:

PRJEB44192

---

## Study design

A total of 161 *Salmonella* isolates collected from clinical and food sources in Ouagadougou between 2017 and 2018 were whole-genome sequenced. Following initial screening and serotype identification, isolates belonging to serovar Kentucky were selected for in-depth phylogenomic analysis.

The isolates were analyzed in the context of the globally disseminated ST198 lineage.

---

# Bioinformatics workflow

The analysis was performed using a reproducible pipeline integrating open-source bioinformatics tools commonly used in bacterial genomics.

## 1. Raw read preprocessing

Raw Illumina paired-end reads were quality filtered to remove:

- low-quality bases
- sequencing adapters
- short reads

Tool used:

fqCleanER v0.1

Example command:

fqCleanER -i sample_R1.fastq -I sample_R2.fastq -o cleaned_reads/

Output:
- filtered paired-end reads ready for assembly

---

## 2. De novo genome assembly

High-quality reads were assembled into draft genomes using the SPAdes assembler.

Assembler:

SPAdes v3.6.0

Command example:

spades.py \
--careful \
-1 cleaned_R1.fastq \
-2 cleaned_R2.fastq \
-o spades_output/

Outputs:

- contigs.fasta
- assembly statistics

Assemblies were inspected to verify genome size consistency with *Salmonella enterica* (~4.7–5.0 Mb).

---

## 3. In silico genotyping and cgMLST typing

Genome assemblies were uploaded to EnteroBase for:

- MLST confirmation
- cgMLST analysis
- hierarchical clustering (HierCC)

This allowed identification of:

Sequence type:
ST198

Phylogenetic lineage:
X1-ST198-SGI1

cgMLST also provided context with global *Salmonella Kentucky* genomes.

---

## 4. Reference-based SNP calling

High-resolution phylogenomic analysis was conducted using a reference-based SNP approach.

Reference genome:

Salmonella Kentucky strain 98K

Pipeline:

Snippy v4.6.0

Example command:

snippy \
--cpus 4 \
--outdir snippy_sample \
--ref reference_98K.fasta \
--R1 cleaned_R1.fastq \
--R2 cleaned_R2.fastq

Outputs:

- core SNP alignment
- variant calls
- filtered SNP matrix

---

## 5. Phylogenetic reconstruction

Maximum likelihood phylogenetic trees were reconstructed from the core SNP alignment.

Software:

RAxML v8.2.12

Model used:

GTR + Gamma + Invariant sites (GTR+I+G)

Bootstrap support:

1000 replicates

Example command:

raxmlHPC \
-s core.full.aln \
-n phylogeny \
-m GTRGAMMAI \
-p 12345 \
-x 12345 \
-# 1000 \
-f a

Outputs:

- best-scoring ML tree
- bootstrap support values

---

## 6. Detection of antimicrobial resistance genes

Antimicrobial resistance genes were identified using the ResFinder database.

Tool:

ResFinder v4.1

This analysis allowed detection of resistance determinants associated with:

- beta-lactams
- tetracyclines
- sulfonamides
- fluoroquinolones

Fluoroquinolone resistance was associated with mutations in:

gyrA (S83F, D87Y/G)  
parC (S80I)

---

## 7. Identification of resistance genomic islands

Genomic analysis revealed the presence of variants of the Salmonella Genomic Island 1 (SGI1), including:

SGI1-K1  
SGI1-P2  
SGI1-K4

These genomic islands are associated with multidrug resistance in *Salmonella Kentucky* ST198.

---

# Reproducibility

This repository aims to support transparent and reproducible genomic epidemiology.

All analyses were conducted using open-source tools and publicly available reference genomes.

Sequencing data:
ENA project PRJEB44192

The workflow described here allows reproduction of:

- genome assemblies
- SNP calling
- phylogenetic reconstruction
- resistance gene identification

---

# Repository structure

---

# Requirements

Recommended computational environment:

Linux (Ubuntu)

Minimum requirements:

- 8 CPU cores
- 16 GB RAM

Software dependencies:

fqCleanER v0.1  
SPAdes v3.6.0  
Snippy v4.6.0  
RAxML v8.2.12  
ResFinder v4.1

---

# Citation

If you use this workflow, please cite:

Nikiema et al.  
High-resolution phylogenomics of multidrug-resistant *Salmonella Kentucky* ST198 in Burkina Faso.

---

# Author

Edith Nikiema  
Molecular Epidemiology and Genomics of Antimicrobial Resistance  
Burkina Faso

---

# License

This project is distributed under an open scientific license to support reproducible research.
