###This document is for building and testing the functions before putting code into the Quarto document

###load relevant packages
library(tidyverse)
library(httr)
library(jsonlite)

###first we get the process to work with a particular example URL
###we use the URL provided in the Project1 assignment description pdf

#create a string for the URL
URL_id <- 'https://api.census.gov/data/2022/acs/acs1/pums?get=SEX,PWGTP,MAR&SCHL=24'

#get the info and view the structure
id_info <- GET(URL_id)
str(id_info, max.level = 1)

#we see data is in a 'content' element which is of raw data type, so we parse the data
#we get out a nicely formatted tibble as desired
parsed <- fromJSON(rawToChar(id_info$content))
parsed_data <- parsed[2:nrow(parsed),]
colnames(parsed_data) <- parsed[1,]
parsed_final <- as_tibble(parsed_data)
parsed_final


###Next we write a helper function that takes a URL as a string and returns a nice tibble
helper <- function(URL){
  id_info <- GET(URL)
  parsed <- fromJSON(rawToChar(id_info$content))
  parsed_data <- parsed[2:nrow(parsed),]
  colnames(parsed_data) <- parsed[1,]
  parsed_final <- as_tibble(parsed_data)
  parsed_final
}

#We test the helper function on 2023 public use microdata and see it functions well
helper('https://api.census.gov/data/2023/acs/acs1/pums?get=SEX,PWGTP,MAR&SCHL=24')

