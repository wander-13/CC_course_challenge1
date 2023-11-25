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

# Checking data for discrepancies
class(forest_shp)
str(forest_shp)
st_crs(forest_shp)               # data use same coordinate reference system (crs)
unique(duplicated(forest_shp))     # no duplicated values
anyNA(forest_shp)                  # no NA values

# Validating geometries
unique(st_is_valid(forest_shp))               # some invalid geometries

# Repairing geometries
forest_shp <- st_make_valid(forest_shp)

# Importing provided dataset for comparison
forestcoverOS <- read_csv("data/forestcoverOS.csv")

# Creating data set for comparison with provided data
# intersecting files
forestcovertile <- st_intersection(forest_shp, OSGBgrid_shp)

# Plotting data
# plot(forest_shp, col = "lightblue", main = "Intersection")   # R got hung up and was terminated
# plot(OSGBgrid_shp, col = "lightgreen", add = TRUE)
# plot(forestcovertile, col = "red", add = TRUE)

# duplicated tile names
tileduplicates <- filter(forestcovertile, duplicated(forestcovertile$TILE_NAME))
# note: some entries are true for England and Scotland

# extracting Scotland only tiles
scotsforesttile <- filter(forestcovertile, SCOTLAND == "t")

# checking data
unique(scotsforesttile$ENGLAND)
# Note: some tiles are true for more than Scotland

# Remove 
# Calculate cover area
# Country effects
# Geometry effects