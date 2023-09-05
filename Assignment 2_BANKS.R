#Assignment 2
#list all .csv files stored in "csv_files"
csv_files <- list.files(path= "Data",pattern = ".csv")
csv_files
#This is how many files match the ".csv" description
length(csv_files)
#This shows that there are 32 files that match the ".csv" description, now I'm going to find number 10
length(1:10)
#Now I'm opening the wingspand vs mass file and storing it as an R object called "df"
df <- read.csv("./Data/wingspan_vs_mass.csv")
#Then we are going to inspect the first 5 lines
head(df,n=5)
#We are now going to see if any files begin with the letter "b"
bfiles <- list.files(path ="Data",
                     pattern ="^b",
                     recursive = TRUE,
                     full.names = TRUE)
#This command will show the first line of each "b" file
readLines("Data/data-shell/creatures/basilisk.dat",
          n=1)
readLines("Data/data-shell/data/pdb/benzaldehyde.pdb",
          n=1)
readLines("Data/Messy_Take2/b_df.csv",
          n=1)
#Now im going to make a for-loop that displays the first line of these "b" files in one place
bfiles
for (i in bfiles) {
  print(readLines(i,n=1))
}
#Lastly I will make a for-loop that lists the first line of each file that ends in ".csv"
csv_files <- list.files(path= "Data",
                        pattern = ".csv",
                        recursive= TRUE,
                        full.names = TRUE)
csv_files
for (i in csv_files) {
  print(readLines(i,n=1))
}
#This is the end of Assignment 2 :)