options(noaakey="bVtVKFmKsRiZVQPprMYmKEWfDSLsceCo")

library(httr)
library(jsonlite)
library(dplyr)
library(ggplot2)
library(maps)
library(tidyverse)

current_year <- 2026
base_url <- "https://gis.ngdc.noaa.gov/arcgis/rest/services/web_mercator/hazards/MapServer/6/query"

resp <- GET(base_url, query=list(
  where="1=1",
  outFields="*",
  returnGeometry=FALSE,
  f="json"
))

volcano_raw <- content(resp, as="text", encoding="UTF-8")
volcano_json <- fromJSON(volcano_raw)

eruptions <- bind_rows(volcano_json$features$attributes)

eruption_filt <- eruptions |> 
  dplyr::filter(YEAR>=2002) |>  
  mutate(
    date=as.Date(paste(YEAR, MO, DAY, sep="-")),
    VEI=as.integer(VEI)
  )

#excludes current year because the eruption total would be off since the year isn't over
eruptions_all <- eruptions |> 
  dplyr::filter(YEAR>=1600, YEAR<current_year) |>  
  mutate(
    date=as.Date(paste(YEAR, MO, DAY, sep="-")),
    VEI=as.integer(VEI)
  )

#bins the data by year after 2002
eruptions_by_year <- eruption_filt |> 
  dplyr::group_by(YEAR) |> 
  dplyr::summarise(count = n())

#bins the data by year after 1600
eruptions_all_by_year <- eruptions_all |> 
  dplyr::group_by(YEAR) |> 
  dplyr::summarise(count = n())

#adds zeros for the years with no eruptions
eruptions_filled <- eruptions_all_by_year |> 
  complete(YEAR = full_seq(YEAR, 1), fill = list(count = 0))

rm(volcano_json,
   resp, eruptions_all,
   eruptions,
   volcano_raw,
   eruptions_all_by_year)
