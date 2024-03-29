# Downloading scRNAseq files 
14/03/2024 

## 1. Finding sequencing files & assessing file corruption: FFQ 
First, to check whether file has downloaded correctly, check the checksum for the file wanting to be downloaded. Checksums often accompany software downloaded from the web so that users can ensure the file or files were not modified in transit. If the checksum from the software vendor matches the checksum of the downloaded installation files on your computer, then no errors or modifications were made. 

Once you have downloaded a file you can compute a hash of it by travelling to that directory. Windows has inbuilt commands to do this (no third-party utilities required): 

certutil -hashfile [FILENAME] [HASH]

> NOTE : This doesn't check whether file is safe to download, only that it is the correct file byte for byte. A checksum is a sequence of numbers and letters used to check data for errors. If you know the checksum of an original file, you can use a checksum utility to confirm your copy is identical. A checksum verifies with a high degree of confidence that there was no corruption causing a copied file to differ from the original. Cryptographic hashes provide additional properties over simple checksums (all ch = cs, not all cs = ch) 

This has been directly applied to sequencing data through FFQ 

> ```ffq``` receives an accession and returns the metadata for that accession as well as the metadata for all downstream accessions following the connections between GEO (GSE/ GSM), SRA (SRR), EMBL-EBI (ENCSR), DDBJ, and Biosample (SAMN). I plan to use this to download my GEO datasets. 

This requires pip to be installed ```sudo apt install python3-pip```. Then ```pip install ffq``` gave the error: 
> × This environment is externally managed
>╰─> To install Python packages system-wide, try apt install
>    python3-xyz, where xyz is the package you are trying to
>    install.
>    
>    If you wish to install a non-Debian-packaged Python package,
>    create a virtual environment using python3 -m venv path/to/venv.
>    Then use path/to/venv/bin/python and path/to/venv/bin/pip. Make
>    sure you have python3-full installed.
>    
>    If you wish to install a non-Debian packaged Python application,
>    it may be easiest to use pipx install xyz, which will manage a
>    virtual environment for you. Make sure you have pipx installed.   
>    See /usr/share/doc/python3.11/README.venv for more information.

Then ```apt install python3-ffq``` gave error: 
> E: Could not open lock file /var/lib/dpkg/lock-frontend - open (13: Permission denied)
> E: Unable to acquire the dpkg frontend lock (/var/lib/dpkg/lock-frontend), are you root?

Then ```sudo apt install python3-ffq``` gave the error: 
> Reading package lists... Done
> Building dependency tree... Done
> Reading state information... Done
> Package ffp is not available, but is referred to by another package.
> This may mean that the package is missing, has been obsoleted, or
> is only available from another source

OUTPUT : 
                                            
 "filename": "SRR25918342_1.fastq.gz",
                                            "md5": "dd6ed54176467493de245658438c8244",
                                            "url": "ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR259/042/SRR25918342/SRR25918342_1.fastq.gz"
                                            "filename": "SRR25918342_2.fastq.gz",
                                            "md5": "4202fa10b482de661f240ea91eecc9d6",
                                            "url": "ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR259/042/SRR25918342/SRR25918342_2.fastq.gz"
                                            "filename": "MC07_S7_I1_001.fastq.gz.1",
                                            "url": "s3://sra-pub-src-15/SRR25918342/MC07_S7_I1_001.fastq.gz.1"
                                            "filename": "MC07_S7_I2_001.fastq.gz.1",
                                            "url": "s3://sra-pub-src-15/SRR25918342/MC07_S7_I2_001.fastq.gz.1"
                                            "filename": "MC07_S7_R1_001.fastq.gz.1",
                                            "url": "s3://sra-pub-src-15/SRR25918342/MC07_S7_R1_001.fastq.gz.1"
                                            "filename": "MC07_S7_R2_001.fastq.gz.1",
                                            "url": "s3://sra-pub-src-15/SRR25918342/MC07_S7_R2_001.fastq.gz.1"                                         


E: Package 'ffp' has no installation candidate
                                        
## 2. Downloading from online sources: Aria2
aria2 is a command line tool used to download files from the internet using HTTP/HTTPS, FTP, SFTP, BitTorrent and Metalink [more info here](https://aria2.github.io/) 

### Using parallel execution in bash 
While using the ```aria2c <url from ffq>``` command to download fastq files worked quickly (_for the mice files_), creating a script to download the files would be ideal instead of having to manually enter the urls each time. A [first attempt](https://github.com/AlicenJoyHenning/masters/blob/main/scripts/bash/downloadfastq.sh) was made at this that was able to download the files but did so sequentially- ~1 hour to download the first, then ~1 hour for the next and do  on until all are downloaded. My question is : 

![parallel bash](https://github.com/AlicenJoyHenning/masters/assets/129797527/09f364ce-c87e-4eba-a892-dcd3558a4fb5)

From there, a second script was made that worked and downloaded all the macaque datasets relatively quickly. 



