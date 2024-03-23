#!/bin/bash
# Script to check md5 of downloaded fastq files 
# INPUT: null / current directory as input  

directory="./"

# Get fastq sample run accession #'s
for fastq in "$directory"/*.fastq.gz; do 
    accession=$(echo "$fastq" | cut -d '.' -f 2 | cut -d '/' -f 3 | sort)
    echo "$accession" >> accession_number.txt 
done

# Make input for ffq
ffq_input=$(cut -d '_' -f 1 accession_number.txt | uniq) # | tr '\n' ' ')
echo "$ffq_input" >> ffq_input.txt

# Read in input to run ffq 
cat ffq_input.txt | while IFS= read -r line
do 
    echo "$line"
    ffq "$line" >> ffq_output.txt
done

# Get intended md5 #'s from ffq output 
echo "Accession_number, Intended_md5" > intended_md5.txt
while IFS= read -r line; do
    if [[ "$line" =~ "filename" && "$line" =~ "SRR" && "$line" =~ "fastq.gz" ]]; then
        accession=$(echo "$line" | cut -d '"' -f 4 | cut -d '.' -f 1)
        intended_md5=""
    elif [[ "$line" =~ "md5" && ! "$line" =~ "null" ]]; then
        intended_md5=$(echo "$line" | cut -d '"' -f 4)
        if [ -n "$accession" ] && [ -n "$intended_md5" ]; then
            echo "$accession, $intended_md5" >> intended_md5.txt
        fi
    fi
done < ffq_output.txt

# Run md5sum to get downloaded md5sum #'s 
echo "Accession_number, Downloaded_md5," > md5sum_output.txt
for downloaded_file in "$directory"/*.fastq.gz; do
    echo "Parsing md5 for downloaded $downloaded_file..."
    accession=$(echo "$downloaded_file" | cut -d '.' -f 2 | cut -d '/' -f 3)
    downloaded_md5=$(md5sum "$downloaded_file" | cut -d ' ' -f 1)
    echo "$accession, $downloaded_md5," >> md5sum_output.txt
done

# Check 
# Combine outputs based on shared accession number column 
join -t ',' -1 1 -2 1 intended_md5.txt md5sum_output.txt > md5check_temp.txt

# Create new column that checks if md5 numbers are the same 
awk -F "\t" 'NR==1 {print $0, "MATCHED"; next} {print $0, ($2==$3 ? "-" : "X")}' md5check_temp.txt > md5check.txt

# Output text to the terminal to inform user if correct download
awk -F ', ' 'NR > 1 { if ($4 == "X") print $1 " has been incorrectly downloaded" ; else print $1 ": ✔" }' md5check.txt

# Remove temporary text files
rm -f *_*.txt



