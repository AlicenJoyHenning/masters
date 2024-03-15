#!/bin/bash

# Define the list of accession numbers
Accession_list=("GSM7135569" "GSM7135585" "GSM7103257" "GSM7103264" "GSM7103275" "GSM7103276" "GSM7103277" "GSM7103278" "GSM7103317" "GSM7103319" "GSM7103320" "GSM7103327")

# Iterate through the list
for accession in "${Accession_list[@]}"; do
    # Create a text file with the accession number
    echo "Creating file for accession $accession"
    touch "$accession.txt"

    # Store the url and md5 metadata to the text file
    ffq "$accession" > "$accession.txt"
    grep "md5\|fastq.gz" "$accession.txt" > "$accession.temp.txt"
    grep -v "null" "$accession.temp.txt" > "$accession.metadata.txt"
    
    # Count the number of fastq files in each file
    echo "$accession" > fastq.count.txt
    echo "," <redirection-command-for-same-line> fastq.count.txt
    grep -c "ftp" "$accession.metadata.txt" <redirection-command-for-same-line> fastq.count.txt

    # Remove temporary file 
    rm "$accession.txt" "$accession.temp.txt"
done
