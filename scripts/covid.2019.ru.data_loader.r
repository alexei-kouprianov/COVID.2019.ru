################################################################
# Nested under:
# covid.2019.ru.main.r
#
# # If needed, install:
# install.packages("maps")

################################################################
# Loading libraries, setting locale for time

library(maps)
library(TeachingDemos)
library(rgdal)
library(rmarkdown)
library(rjson)

# library(png)
Sys.setlocale("LC_TIME", "en_US.UTF-8")

################################################################
# Reading data

daily.timestamp <- read.table("../downloads/stopcoronavirus.timestamp.moment.20200429.txt")

covid.2019.ru <- read.table("../data/momentary.txt", h=TRUE, sep="\t")
covid.2019.ru.da <- read.table("../data/momentary.da.txt", h=TRUE, sep="\t")
covid.2019.breaks <- read.table("../misc/breaks.txt", h=TRUE, sep="\t")
covid.2019.coord <- read.table("../misc/coord.txt", h=TRUE, sep="\t")
covid.2019.population <- read.table("../misc/population.txt", h=TRUE, sep="\t")

ru.shape <- readOGR("../misc/ESRI.shapefile")
ru.shape.LOCUS <- ru.shape$LOCUS
rm(ru.shape)

# cc.logo <- readPNG("../misc/240px-Cc.logo.circle.svg.png")
# cc_by.logo <- readPNG("../misc/Cc-by_new.svg.png")
