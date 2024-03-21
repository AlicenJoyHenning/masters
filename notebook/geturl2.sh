: #!/bin/bash

# Define the list of accession numbers
Accession_list=("GSM5747736" "GSM5747737" "GSM5747738" "GSM5747739" "GSM5747740" "GSM5747741" "GSM5747742" "GSM5747743" "GSM5747744" "GSM5747745" "GSM5747746")

# Create the output file
output_file="metadata_output.txt"
echo "Sample_Accession, Sequencing_Run_Accession, Filename, MD5" > "$output_file"

# Iterate through the list
for accession in "${Accession_list[@]}"; do
    # Store the url and md5 metadata to a temporary file
    ffq "$accession" > "$accession.txt"
    grep -E "SRR[0-9]+_1\.fastq\.gz|SRR[0-9]+_2\.fastq\.gz|md5" "$accession.txt" > "$accession.temp.txt"

    # Extract necessary information and append to the output file
    while read -r line; do
        if [[ $line =~ (SRR[0-9]+)_[12]\.fastq\.gz ]]; then
            sequencing_run="${BASH_REMATCH[1]}"
            echo "${accession}, ${sequencing_run}, $line" >> "$output_file"
        elif [[ $line =~ "md5" ]]; then
            md5=$(echo "$line" | awk '{print $NF}')
            echo ",, $md5" >> "$output_file"
        fi
    done < "$accession.temp.txt"

    # Remove temporary file 
    rm "$accession.txt" "$accession.temp.txt"
done
