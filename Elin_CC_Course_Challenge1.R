# CC_Course_Challenge1
# By: Elin Swank
# 11/02/2023
#
# Data set Licenses:
# Scottish Wildlife Trust (2018). The Scottish Squirrel Database. Occurrence dataset [https://doi.org/10.15468/fqg0h3] under license CC-BY-4.0
# Forestry Commission (2018). National Forest Inventory Woodland Scotland 2017. Available at the Forestry Commission Open Data portal under Open Governement licence: Crown copyright and database right 2018 Ordnance Survey [100021242]
# Charles Roper (2015). OSGB Grids in shapefile format. Available on Github under a CC-0 (public domain) license.
################################################################################

# Load Libraries
library(sf)
library(tidyverse)

# Attempt to recreate forestcoverOS.csv
# import forest inventory and OS data 
forest_shp <- st_read("data/NATIONAL_FOREST_INVENTORY_WOODLAND_SCOTLAND_2017/NATIONAL_FOREST_INVENTORY_WOODLAND_SCOTLAND_2017.shp")
OSGBgrid_shp <- st_read("data/OSGB_Grids-master/Shapefile/OSGB_Grid_10km.shp")

# Intersecting files
forestintersectOSGB <- st_intersection(forest_shp, OSGBgrid_shp)
# checking results
# print(forestintersectOSGB)

################################################################################
# troubleshooting discrepancies in provided data set and created one
forest_area <- aggregate(st_area(forestintersectOSGB),
                         by = list(forestintersectOSGB$TILE_NAME),
                         sum)
colnames(forest_area) <- c("TILE_NAME", "Total_Area_m^2")
forest_area$`Total_Area_m^2` <- as.numeric(forest_area$`Total_Area_m^2`)
unique(forest_area$TILE_NAME)
################################################################################
# checking results compared to provided dataset
# import provided datset
forestCC <- read.csv("data/forestcoverOS.csv")

# comparing column values
which(!as.numeric(forestCC$total.area) == as.numeric(forest_area$`Total_Area_m^2`))
merger <- merge(forest_area, forestCC, by = "TILE_NAME")
merger$compare <-  mapply(function(x, y) {isTRUE(all.equal(x, y))}, merger$`Total_Area_m^2`, merger$total.area)
# returns many unequal results
merger$compare2 <- near(merger$`Total_Area_m^2`, merger$total.area)
################################################################################