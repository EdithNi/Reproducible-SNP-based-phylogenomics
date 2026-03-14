# Reproducible Phylogenomics of Multidrug-Resistant *Salmonella enterica* serovar Kentucky ST198 in Burkina Faso

## Overview

This repository provides a **reproducible bioinformatics workflow** used to investigate the population structure and antimicrobial resistance determinants of *Salmonella enterica* serovar Kentucky ST198 isolates collected in Burkina Faso within a **One Health surveillance framework**.  

The workflow integrates **quality control, genome assembly, genotyping, SNP phylogenomics, phylogenetic reconstruction, and antimicrobial resistance profiling**.  

All sequencing data are publicly available in the European Nucleotide Archive (ENA) under:

**PRJEB44192**

---

## Study Design

- **Total isolates:** 161 *Salmonella* collected from clinical and food sources in Ouagadougou (2017–2018).  
- **Focus:** isolates belonging to serovar Kentucky (ST198).  
- **Goal:** investigate high-resolution population structure and evolution of multidrug-resistant clones.

---

## Bioinformatics Workflow

The analysis was implemented in **Snakemake** to ensure **reproducibility and transparency**.

### 1. Raw Read Preprocessing

- Tool: **fqCleanER v0.1**  
- Remove low-quality reads, adapters, and short sequences.  

### 2. Genome Assembly

- Tool: **SPAdes v3.6.0**  
- *De novo* assembly of high-quality reads.  

### 3. Genotyping and cgMLST

- Tool: **EnteroBase cgMLST / HierCC**  
- Confirm ST198 lineage and global context.

### 4. SNP Calling

- Tool: **Snippy v4.6.0**  
- Reference: *Salmonella Kentucky* strain 98K  
- Generate core SNP alignment for high-resolution phylogeny.

### 5. Phylogenetic Reconstruction

- Tool: **RAxML v8.2.12**  
- Model: GTR+I+G, 1000 bootstrap replicates  
- Build maximum likelihood trees to infer evolutionary relationships.

### 6. Antimicrobial Resistance Profiling

- Tool: **ResFinder v4.1**  
- Detect resistance genes for beta-lactams, tetracyclines, sulfonamides, and fluoroquinolones.  
- Identify mutations in *gyrA* and *parC* associated with ciprofloxacin resistance.  

### 7. Resistance Genomic Islands

- Identify SGI1 variants (SGI1-K1, SGI1-P2, SGI1-K4) linked to multidrug resistance.

---

## Repository Structure

salmonella_ST198_phylogenomics/
├── README.md
├── config/
│ └── config.yaml
├── data/
│ └── raw_reads/
├── results/
│ ├── clean_reads/
│ ├── assembly/
│ ├── snps/
│ ├── phylogeny/
│ └── amr/
├── scripts/
├── workflow/
│ └── Snakefile
└── envs/
├── spades.yaml
├── snippy.yaml
└── raxml.yaml


---

## Reproducibility

- Entire workflow implemented in **Snakemake**.  
- Tools and versions are defined in **conda environments** (`envs/*.yaml`).  
- Configuration parameters stored in `config/config.yaml`.  
- Supports **scalability**, **transparency**, and **reproducibility**.

---

## How to Run

```bash
# activate conda
conda activate snakemake

# run workflow
snakemake --use-conda --cores 8
