#' Follow the README.md sign up for a Socrata API
#' To use the Socrata API:
#' create your  `token <- c(sec = ..., app = ...)` and keep 
#' it into a separate .R to source()

library(RSocrata)
library(here)
library(tidyverse)

source(here('lectures', 'lesson11_openData', 'tokenSocrata.R'))
#' Google API requirements has changed. As a results, the package
#' ggmap needs revisions. For now, we are stacked witht he dev version
if(!requireNamespace("devtools")) install.packages("devtools")
devtools::install_github("dkahle/ggmap", ref = "tidyup")
library(ggmap)

######################################
####        calls to 311         #####
######################################

#' go to the page of a dataset: https://data.brla.gov/Government/311-Citizen-Requests-for-Service/7ixm-mnvx
#' click on the tab API and copy paste the link for "API Endpoint'
#' 
apiEndpoint <- 'https://data.brla.gov/resource/uqxt-dtpe.csv?'

#' learn how to write queries: https://dev.socrata.com/
#' list of functions: https://dev.socrata.com/docs/functions/

#' our period of interest is during the declaration of the state of emergency
#' https://en.wikipedia.org/wiki/2016_Louisiana_floods
query <- "$where=createdate between '2016-08-12' and '2016-08-22'"


dt_311 <- read.socrata(paste0(apiEndpoint, query), app_token = token[['app']])
dt_311 <- as_tibble(dt_311)

dt_311 <- dt_311 %>%
              mutate(geolocation = str_extract_all(geolocation, '[-,.,0-9]+')) %>% 
              mutate(long = map_chr(geolocation, 1), lat = map_chr(geolocation, 2)) %>% 
              mutate_at(vars(long, lat), as.double) # same as mutate(long = as.double(long), lat = as.double(lat))


#' Register to the Google Maps Static API: 
#' https://console.developers.google.com/projectselector/apis/api/static_maps_backend?supportedpurview=project
#' 1. 'Create' a new project
#' 2. Disable URL signing secret
#' on the left menu select: credentials > create credentials > API key
#' the API key goes in:

ggmap::register_google(key = googleAPIkey)

#Use get_map to query the Google API (we use the LSU coordinate)
brMap <- ggmap::get_map(location = c( lon = -91.1500, lat = 30.5000),  zoom = 10, maptype = 'toner') 

#' In case you cannot connect to the API, I saved for you the object brMap to data/mapTerrainBR.RDS
#' brMap <- readRDS(here::here('data/mapTerrainBR.RDS')) 

ggmap::ggmap(brMap) +
  geom_point(data = filter(dt_311, parenttype == "DRAINAGE, EROSION, FLOODING OR HOLES"),
             aes(x = long, y = lat), color = 'darkred', alpha = .33) +
  ggtitle('Position of calls to 311 Baton Rouge area')


######################################
####   Layer of fire dep. calls  #####
######################################

# fire incidents endpoint
fireIncidens <- 'https://data.brla.gov/resource/4w4d-4es6.csv?'
query <- "$where=disp_date between '2016-08-12' and '2016-08-22'"

#' Task: Use read.scorata to query the API and download fire incidents records. 
#' Filter only calls for inci_descript: 
#' 'severe weather or natural disaster, other' OR 'water evacuation'



######################################
####    LOOTING 911 calls        #####
######################################


# police incidents endpoint
crimeIncidents <- 'https://data.brla.gov/resource/5rji-ddnu.csv?'
query <- "$where=offense_date between '2016-08-12' and '2016-08-22'"

#' Task: Use read.scorata to query the API and download police incidents records. 
#' Filter only calls for offense_desc: 'looting'



######################################
####    Layer of inundate areas  #####
######################################
library(rgdal)
library(ggpolypath)
shpFile <- here('data', 'Estimated_Flood_Inundation_Area/Estimated_Flood_Inundation_Area.shp')
indundationArea <- readOGR(shpFile)
ogrInfo(shpFile)
indundationArea <- spTransform(indundationArea, CRS("+proj=longlat +datum=WGS84"))
indundationArea <- fortify(indundationArea)

m <- ggmap::ggmap(brMap) +  
      geom_polypath(data = indundationArea, aes(x = long, y = lat, group=group), fill = 'blue', alpha=.2) 

#' It can take a while to load the map in the viewer. 
#' You might want to save it as .png to retrieve them faster:
ggsave('shapemapFlood.png', m, path = here('lectures','lesson11_openData/'))








