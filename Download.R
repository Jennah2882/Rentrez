library(rentrez)

#Create a vector of unique NCBI sequence IDs
ncbi_ids <- c("HQ433692.1","HQ433694.1","HQ433691.1")

#Retrieving data from the NCBI database where "db= nuccore" specifies we are 
#looking at the nucleotide database, id references the names of sequences 
#previously specified, and retype lets us specify which format the sequence 
#data will be returned as.
Bburg<-entrez_fetch(db = "nuccore", id = ncbi_ids, rettype = "fasta")

#Use strsplit to split the Bburg object into sequences
Sequences <- strsplit(Bburg, "\n(?=>)", perl = TRUE)

#Un-listing
Sequences <- unlist(Sequences)

#Separating headers and sequences using regular expressions
Header <- gsub("(^>.*sequence)\\n[ATCG].*", "\\1", Sequences)
Seq <- gsub("^>.*sequence\\n([ATCG].*)", "\\1", Sequences)

#Create data frame
Sequences <- data.frame(Name = Header, Sequence = Seq)

#Remove newline characters from the sequences
Sequences$Sequence <- gsub("\n", "", Sequences$Sequence)
print(Sequences)

#Write the data frame to a CSV file
write.csv(Sequences, "Sequences.csv", row.names = FALSE)