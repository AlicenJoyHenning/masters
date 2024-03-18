#!/bin/bash

# Define the list of accession numbers
Accession_list=("GSM7759620" "GSM7759621" "GSM7759622" "GSM7759623")

touch fastq.count.txt
echo "accession, fastq_count" > fastq.count.txt

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
    count=$(grep -c "ftp" "$accession.metadata.txt")
    echo "$accession, $count" >> fastq.count.txt

    # Remove temporary file 
    rm "$accession.txt" "$accession.temp.txt"
done
