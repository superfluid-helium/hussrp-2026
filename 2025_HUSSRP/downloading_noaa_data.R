options(noaakey="bVtVKFmKsRiZVQPprMYmKEWfDSLsceCo")

library(httr)
library(jsonlite)
library(dplyr)
library(ggplot2)
library(maps)
library(tidyverse)

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
  dplyr::filter(YEAR>=2002, YEAR<= 2025) |>  
  mutate(
    date=as.Date(paste(YEAR, MO, DAY, sep="-")),
    VEI=as.integer(VEI)
  )

eruptions_all <- eruptions |> 
  dplyr::filter(YEAR>=1600) |>  
  mutate(
    date=as.Date(paste(YEAR, MO, DAY, sep="-")),
    VEI=as.integer(VEI)
  )

eruptions_by_year <- eruption_filt |> 
  dplyr::group_by(YEAR) |> 
  dplyr::summarise(count = n())

eruptions_all_by_year <- eruptions_all |> 
  dplyr::group_by(YEAR) |> 
  dplyr::summarise(count = n())

eruptions_filled <- eruptions_all_by_year |> 
  complete(YEAR = full_seq(YEAR, 1), fill = list(count = 0))
