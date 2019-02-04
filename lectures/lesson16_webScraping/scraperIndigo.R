library(rvest)
library(tidyverse)

URL <- 'https://www.indeed.com/cmp/Exxonmobil'
session <- html_session(url) 
employers <- c("Exxon", "Shell", "LSU")

formSubmission <- function(employer) {
  form <- html_form(session)[[1]]
  form <- set_values(form, q = employer)
  submit_form(session, form)
  
}

formSubmitted <- formSubmission(employers[1])

#the below function is to extract the url with the correct name
compURLExtr <- function(formSubmitted) {
  formSubmitted %>% 
  html_node('#cmp-root') %>% 
    html_node('div.cmp-SearchResultContainer') %>% 
    html_node('div.cmp-CompanyWidget-details') %>% 
    html_nodes('a.cmp-CompanyWidget-name') %>% html_attr('href') %>% 
    paste0('https://www.indeed.com', .)
}
companyURL <- compURLExtr(formSubmitted)

extractRating <- function(companyURL) {
companyPage <- html_session(companyURL) #read the page
data_frame(
name = companyPage %>% html_nodes('div.cmp-company-name') %>% html_text(),
rating = companyPage %>% html_node('span.cmp-header-rating-average') %>% html_text()
)
}

extractRating(companyURL)



#To sum up, URL and employers are the elements we need to iterate on:
URL <- 'https://www.indeed.com/cmp/Exxonmobil' 
employers <- c("Exxon", "Shell", "LSU")

#And these are the functions we need to run sequentially (we can embed them in `scraper`):
scraper <- function(url = 'https://www.indeed.com/cmp/Exxonmobil' , employers) {
session <- html_session(url) 
formSubmitted <- formSubmission(employers)
companyURL <- compURLExtr(formSubmitted)
extractRating(companyURL)
}

#run the scraper for each company name
map_df(employers, ~ scraper(employers = .x))




