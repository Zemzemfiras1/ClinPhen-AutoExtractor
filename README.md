# ClinPhen-AutoExtractor

A lightweight Linux pipeline for **automatic extraction of Human Phenotype Ontology (HPO) terms** from clinical text using **ClinPhen**.

This tool enables batch processing of patient phenotype descriptions from TSV files and generates structured outputs with full logging.

---


## Features

* Batch processing of patient clinical features
* Automatic HPO term extraction using ClinPhen
* Per-patient output files
* Full execution logging
* CLI interface (`--input`)
* Conda environment support
* Lightweight Linux workflow

---

## Project Structure

```text
ClinPhen-AutoExtractor/
│
├── ClinphenResult/
│   ├── logs/
│   │   └── patients_clinical_features.txt
│   ├── P001_clinphen.txt
│   ├── P002_clinphen.txt
│   ├── P003_clinphen.txt
│   ├── P004_clinphen.txt
│   ├── P005_clinphen.txt
│   ├── P006_clinphen.txt
│   ├── P007_clinphen.txt
│   ├── P008_clinphen.txt
│   ├── P009_clinphen.txt
│   └── P010_clinphen.txt
│
├── clinphen.yml
├── patients_clinical_features.tsv
└── run_clinphen_pipeline.sh
```

---

## Installation

### Recommended: Conda environment

To ensure that all dependencies (including ClinPhen, NLP tools, and Python packages) are installed correctly, create and activate the environment:

```bash
conda env create -f clinphen.yml
conda activate clinphen
```


---

## Usage

If you run:

```bash
./run_clinphen_pipeline.sh
```

You will see:

```text
ERROR: Input file is required!

ClinPhen Pipeline Tool

Usage:
  ./run_clinphen_pipeline.sh --input file.tsv

Options:
  -i, --input   Input TSV file (required)
  -h, --help    Show help
```

## Run pipeline

```bash
./run_clinphen_pipeline.sh --input patients_clinical_features.tsv
```


---

## Input Format (TSV)

```tsv
patient_id	clinical_features
P001	seizures; developmental delay; hypotonia
P002	ataxia; speech delay; intellectual disability
P003	hearing loss; vision impairment
```

---

## Output

After execution:

```text
ClinphenResult/
├── P001_clinphen.txt
├── P002_clinphen.txt
├── ...
└── logs/
    └── patients_clinical_features.txt
```

Each file contains extracted HPO terms:

```text
HPO ID	Phenotype name	No. occurrences	Earliness (lower = earlier)	Example sentence
HP:0001250	Seizures	1	0	seizures 
HP:0001263	Global developmental delay	1	1	developmental delay 
HP:0001290	Generalized hypotonia	1	2	hypotonia 
...
```

---

## Workflow

```text
TSV input
   ↓
ClinPhen NLP extraction
   ↓
HPO term mapping
   ↓
Per-patient output + logs
``` 

---

## Citation

This pipeline is based on:

> Deisseroth, C.A., Birgmeier, J., Bodle, E.E. et al. ClinPhen extracts and prioritizes patient phenotypes directly from medical records to expedite genetic disease diagnosis. Genet Med 21, 1585–1593 (2019). https://doi.org/10.1038/s41436-018-0381-1

> [!NOTE]
> This repository does not modify or reimplement the original ClinPhen algorithm.  
> It uses the official ClinPhen source code as the core tool.
>
> The contribution of this project is a lightweight Bash-based automation wrapper designed to:
>
> - facilitate batch processing of cohort-level patient data  
> - standardize input formatting (TSV-based clinical features)  
> - organize per-patient outputs  
> - provide reproducible logging of all runs  
> - simplify testing and deployment in Linux environments  
>
> The purpose of this repository is to streamline and operationalize ClinPhen for cohort-scale analysis, not to alter its underlying methodology.
>
> All phenotype extraction and HPO mapping are performed by the original ClinPhen implementation.

---

## License

MIT License  

 
