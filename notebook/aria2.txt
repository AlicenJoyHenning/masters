14/03/2024 
Downloading scRNAseq files 

# File corruption 
First, to check whether file has downloaded correctly, check the checksum for the file wanting to be downloaded. Checksums often accompany software downloaded from the web so that users can ensure the file or files were not modified in transit. If the checksum from the software vendor matches the checksum of the downloaded installation files on your computer, then no errors or modifications were made. Something like: 

md5: 24234234
sha256: 2342nji34

Once you have downloaded a file you can compute a hash of it by travelling to that directory. Windows has inbuilt commands to do this (no third-party utilities required): 

certutil -hashfile [FILENAME] [HASH]

This doesn't check whether file is safe to download, only that it is the correct file byte for byte. A checksum is a sequence of numbers and letters used to check data for errors. If you know the checksum of an original file, you can use a checksum utility to confirm your copy is identical. A checksum verifies with a high degree of confidence that there was no corruption causing a copied file to differ from the original. Cryptographic hashes provide additional properties over simple checksums (all ch = cs, not all cs = ch) 





Aria2
