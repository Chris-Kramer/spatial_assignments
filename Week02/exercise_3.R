##-----------------------------------------------##
##    Author: Adela Sobotkova                    ##
##    Institute of Culture and Society           ##
##    Aarhus University, Aarhus, Denmark         ##
##    adela@cas.au.dk                             ##
##-----------------------------------------------##

#### Goals ####

# - Learn about Classification methods

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

# We will use a single data set:  `nz`. It is contained by the libraries
# It is an sf object with polygons representing the 16 regions of New Zealand.

#### Existing code ####

# Here are some examples of plotting population in  New Zealand.
# Your role is to create a map based on the suggestions below, 
# selecting the most meaningful classification style.

# Look at NZ population distribution
hist(nz$Population)
nz$
# This line of code applies the 'pretty' style rounding legend numbers. Try different numbers of classes.
pretty_style <- tm_shape(nz) + tm_polygons(col = "Population", style = "pretty", n = 4)

# "Jenks" style further smooths over the gaps
jenk_style <- tm_shape(nz) + tm_polygons(col = "Population", style = "jenks", n = 5)

# quantile style divides into 5 even groups
quantile_style <- tm_shape(nz) + tm_polygons(col = "Population", style = "quantile", n=5)

# Equal interval style divides the distribution into even groups
equal_style <- tm_shape(nz) + tm_polygons(col = "Population", style = "equal", n = 5)

# Write maps above to objects and plot them side by side 
# with tmap_arrange() for better comparison
tmap_arrange(pretty_style, jenk_style, quantile_style, equal_style)


#### Exercise I ####

# 1. What are the advantages and disadvantages of each classification method?
  #Pretty: The legend is easy to read and understand. The problem is, that it looks like people are evenly distributed across the entire map.
  #Jenks: The legend is a bit hard to comprehend, but it makes it clear, that there are significant differences in the distribution.
  #Quantile: There is still problems with the legend. But shows that there are huge differences with where people live. However, it smooths out differences in places with high density.
  #Equal: Have the same problems as pretty, but the legend is hard to read. 

# 2. Choose the best classification and create a map with easily legible legend and all other essentials.
# (Select a suitable color palette from http://colorbrewer2.org/, north arrow, scale, map title, 
# legend title, reasonable number of breaks in the classification )
# 3. Which method and how many classes did you end up using to display
# your data? Why did you select that method?
  # I Used pretty, since the income distribution wasn't that different. There aren't any places, where there was a huge income disparity. 
  # Therefore it made most sence to have an even distribution across each income leve. 

# 4. What principles did you use in arranging the parts of your map layout the way you
# did and how did you apply these principles?
  #I put the legend and the arrow up top, since these are important for knowing what you are looking at. Moreover, I made the legend bigger because it is important.
  #I moved the credits down at the bottom, since it is relatively unimportant.
  #I used the palette "Greens", since income is sequential. If I knew the median Income of New Zealand I would probably have used an divergent paletter.
  #I used the green colors since income is a positive thing. The higher income the more green it should be, since it is positive (I personally view green as a symbol of something positive)
# Your solution

# /Start Code/ #
tm_shape(nz) + 
  tm_polygons(col = "Median_income",
              title = "Median Income",
              style = "pretty",
              palette = "Greens") + 
  tm_compass(position = c("RIGHT", "top"),
             type = "4star", 
             size = 3) +
  tm_legend(text.size = 1.5) +
  tm_credits(text = "Christoffer M. Kramer, 13-02-2021") +
  tm_layout(main.title = "Median Income in New Zealand",
            title.size = 3,
            bg.color = "light blue",
            inner.margins = c(0.05, 0.05, 0.05, 0.05))

# /End Code/ #