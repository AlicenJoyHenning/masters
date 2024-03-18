#!/bin/bash
# Script to download mouse control (GSE121611) fastqs 

# Define the list of accession numbers
url_list=("ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR818/000/SRR8180470/SRR8180470_1.fastq.gz" "ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR818/000/SRR8180470/SRR8180470_2.fastq.gz" "ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR818/002/SRR8180472/SRR8180472_1.fastq.gz" "ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR818/002/SRR8180472/SRR8180472_2.fastq.gz" "ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR818/003/SRR8180473/SRR8180473_1.fastq.gz" "url": "ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR818/003/SRR8180473/SRR8180473_2.fastq.gz" "url": "ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR818/001/SRR8180471/SRR8180471_1.fastq.gz" "ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR818/001/SRR8180471/SRR8180471_2.fastq.gz")

# Iterate through the list
for url in "${url_list[@]}"; do
    # Use aria to download the file & specify the output location 
    aria2c "$url" 
done

# Create output file with md5 of all downloaded files 
md5sum *.gz > GSE121611.md5.txt
