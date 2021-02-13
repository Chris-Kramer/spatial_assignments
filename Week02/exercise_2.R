##-----------------------------------------------##
##    Author: Adela Sobotkova                    ##
##    Institute of Culture and Society           ##
##    Aarhus University, Aarhus, Denmark         ##
##    adela@cas.au.dk                             ##
##-----------------------------------------------##

#### Goals ####

# - Understand the provided datasets
# - Learn how to reproject spatial data
# - Limit your data into an area of interest
# - Create a new map

# We highlighted all parts of the R script in which you are supposed to add your
# own code with: 

# /Start Code/ #

print("Hello World") # This would be your code contribution

# /End Code/ #

#### Required R libraries ####

# We will use the sf, raster, and tmap packages.
# Additionally, we will use the spData and spDataLarge packages that provide new datasets. 
# These packages have been preloaded to the worker2 workspace.

library(sf)
library(raster)
library(tmap)
library(spData)
library(spDataLarge)

#### Data sets #### 

# We will use two data sets: `srtm` and `zion`.
# The first one is an elevation raster object for the Zion National Park area, and the second one is an sf object with polygons representing borders of the Zion National Park.

srtm <- raster(system.file("raster/srtm.tif", package = "spDataLarge"))
zion <- read_sf(system.file("vector/zion.gpkg", package = "spDataLarge"))

# Additionally, the last exercise (IV) will used the masked version of the `lc_data` dataset.

study_area <- read_sf("data/study_area.gpkg")
lc_data <- raster("data/example_landscape.tif")
lc_data_masked <- mask(crop(lc_data, study_area), study_area)

#### Exercise I ####

# 1. Display the `zion` object and view its structure.
# What can you say about the content of this file?
  # It is an shapefile

# What type of data does it store? 
  # It contains metadata, such as, whn it was edited, what state it is in. What region, who created and the parkname.

# What is the coordinate system used?
  #+proj=utm +zone=12 +ellps=GRS80 +units=m +no_defs
  # THe CRS is UTM Zone 12, Nothern Hemisphere.

# How many attributes does it contain?
  #12
# What is its geometry?
  # It contains a polygon, that displays the boundaries of the zion national park.

# 2. Display the `srtm` object and view its structure.
# What can you say about the content of this file? 
  # It is a raster, where each cell is given a numeric value, that corresponds to the elevation of the area.

# What type of data does it store?
  # The elevation of an area

# What is the coordinate system used? 
  # +proj=longlat +datum=WGS84 +no_defs

# How many attributes does it contain?
  # 3: ID, from (lowest elevation), to (highest elevation). 

# How many dimensions does it have? 
  #2: 457 (widt) and 465 (height)

# What is the data resolution?
  # 0.0008333333 0.0008333333
# Your solution (type answer to the questions as code comments and the code used)

# /Start Code/ #

#Q2
head(zion) #Content of file
st_crs(zion) # get CRS
length(zion) #Get amount of attributes

#Q1
head(srtm) #Content of file
crs(srtm) # get CRS
ratify(srtm) #Get attributes
dim(srtm) #Get dimensions
res(srtm) #get resolution

# /End Code/ #


#### Exercise II ####

# 1. Reproject the `srtm` dataset into the coordinate reference system used in the `zion` object. 
# Create a new object `srtm2`
# Vizualize the results using the `plot()` function.

# 2. Reproject the `zion` dataset into the coordinate reference system used in the `srtm` object.
# Create a new object `zion2`
# Vizualize the results using the `plot()` function.


# Your solution

# /Start Code/ #
# Q1
srtm2 <- srtm
crs(srtm2) <- "+proj=utm +zone=12 +ellps=GRS80 +units=m +no_defs"
plot(srtm2, 
     main = "Elevation: Zion National Park")

#Q2
zion2 <- zion
st_crs(zion2) <- "+proj=longlat +datum=WGS84 +no_defs"
plot(zion2["geom"],
     main = "Zion National Park")
# /End Code/ #
