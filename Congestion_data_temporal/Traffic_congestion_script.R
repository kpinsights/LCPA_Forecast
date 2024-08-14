library(leaflet)
library(leaflet.providers)
library(dplyr)
library(terra)
library(osmdata)
library(sf)
library(googletraffic)
library(rmapshaper)
library(ggplot2)
library(tmap)
library(googleway)
library(lubridate)  
library(ggmap)     
library(raster)
library(tmaptools)
library(leaflet.extras)
library(webshot)
library(webshot2)
library(htmlwidgets)
library(gstat)
library(grid)
library(later)


#load("Final_Proj_data.RData")

run_task <- function() {
  google_key = Sys.getenv("google_maps_api_key")
  congestion_raster = gt_make_raster_from_polygon(polygon =
                                                  toronto_center_traffic_polygon,
                                                  zoom = 17,
                                                  google_key = google_key,
                                                  webshot_zoom = 2,
                                                  webshot_delay = NULL,
                                                  print_progress = TRUE)
  filename <- paste0("congestion_raster_", format(Sys.time(), "%Y-%m-%d_%H-%M"), ".tif")
  writeRaster(congestion_raster, filename = filename, format = "GTiff")
  
  # Schedule the next run (30 min intervals)
  later(run_task, delay = 1800)  # delay is in seconds 
}

run_task()


