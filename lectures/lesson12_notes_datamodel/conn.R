library(tidyverse)
if (!require(DBI)) {install.packages('DBI'); library(DBI)}
con <- DBI::dbConnect(RMySQL::MySQL(), 
                      host = "ba-isdsclass-dev2.lsu.edu",
                      user = "student",
                      password = "student",
                      dbname = "hotelreviews")

#test whether you can query the db 
print('If you get an error, try reinstalling `openssl``, restart R and rerun the script.')

