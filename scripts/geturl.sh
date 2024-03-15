#!/bin/bash

# Define the list of accession numbers
Accession_list=("GSM5747736","GSM5747737","GSM5747738","GSM5747739","GSM5747740","GSM5747741","GSM5747742","GSM5747743","GSM5747744","GSM5747745","GSM5747746")

# Iterate through the list
for accession in "${Accession_list[@]}"; do
    # Create a text file with the accession number
    echo "Creating file for accession $accession"
    touch "$accession.txt"

    # Store the url and md5 metadata to the text file
    ffq "$accession" > "$accession.txt"
    grep "md5\|fastq.gz" "$accession.txt" > "$accession.temp.txt"
    grep -v "null" "$accession.temp.txt" > "$accession.metadata.txt"

    # Remove temporary file 
    rm "$accession.txt" "$accession.temp.txt"
done
