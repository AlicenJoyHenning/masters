#!/bin/bash
# Script to take one input (list of accession #s) and download files

# Define the list of accession numbers
Accession_list=("GSM7759620" "GSM7759622" "GSM7759623")

touch mouse_fastq.lst 

# For loop to generate output list with fastq urls
for accession in "${Accession_list[@]}"; do
    # Create a temp text file for storing metadata from the accession number
    touch "$accession.txt"
    ffq "$accession" > "$accession.txt"

    # Isolate lines with valid urls & extract url string
    grep "url" "$accession.txt" | grep "ftp" "$accession.txt" | grep "fastq.gz" | cut -d '"' -f 4 > "$accession.temp.txt"
    grep -v "null" "$accession.temp.txt" >> mouse_fastq.lst

    # Remove temp file 
    rm "$accession.txt" "$accession.temp.txt"
done


# Use the list as input to aria2c to download the files 
cat mouse_fastq.lst|parallel -j 4 aria2c {}


