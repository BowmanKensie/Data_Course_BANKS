#Assignment 2
csv_files <- list.files(path ="Data",pattern= ".csv")
csv_files
length(csv_files)
length(1:10)
df <- read.csv("./Data/wingspan_vs_mass.csv")
head(df,n=5)
#find all files that start with "b"
bfiles <- list.files(path ="Data",
           pattern ="^b",
           recursive= TRUE,
           full.names = TRUE)
readLines("Data/data-shell/creature/basillisk.dat",
          n=1)
readLines("Data/data-shell/data/pdb/benaldehyde.pdf",
          n=1)
readLines("Data/Messy_Take1.b_df.csv",
          n=1)
bfiles
for(i in bfiles){
  print(readLines(i,n=1))
}

csv_files <- list.files(path ="Data",
                        pattern = ".csv"
                        recursive= TRUE, 
                        full.names= TRUE){
  print(readLines(i,n=1))
}

