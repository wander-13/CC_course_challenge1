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
forest.shp <- st_read("data/NATIONAL_FOREST_INVENTORY_WOODLAND_SCOTLAND_2017/NATIONAL_FOREST_INVENTORY_WOODLAND_SCOTLAND_2017.shp")
OSGBgrid.shp <- st_read("data/OSGB_Grids-master/Shapefile/OSGB_Grid_10km.shp")

# Intersecting files
forestintersectOSGB <- st_intersection(forest.shp, OSGBgrid.shp)
