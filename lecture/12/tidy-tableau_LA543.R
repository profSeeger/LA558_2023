install.packages(c("tidycensus", "tidyverse", "sf" ))
library(tidycensus)
library(tidyverse)
library(sf)

v21 <- load_variables(2021, "acs5", cache = TRUE)
View(v21)

langList = c(
  "Total" = "C16001_001",
  "Only English" = "C16001_002",
  "Spanish" = "C16001_003", 
  "Chinese" = "C16001_021",
  "Arabic" = "C16001_033"
)

county = c(
  "Boone","Story","Polk","Webster", "Hardin", "Hamilton", "Dallas", "Crawford"
)

iowa_558Lang <- get_acs(
  geography = "county",
  variables = langList,
  state = "IA",
  county = county,
  output = "wide",
  geometry = TRUE
)

iowa_558Lang = iowa_558Lang %>%
  mutate(SpanishP = SpanishE / TotalE * 100)

iowa_558Lang 

plot(iowa_558Lang["SpanishP"])

st_write(iowa_558Lang, "iowa_558Lang2.shp")
