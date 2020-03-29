################################################################
# Loading libraries, setting locale for time

library(maps)
library(png)
Sys.setlocale("LC_TIME", "en_US.UTF-8")

################################################################
# Reading data

covid.2019.ru <- read.table("../data/momentary.txt", h=TRUE, sep="\t")
covid.2019.breaks <- read.table("../misc/breaks.txt", h=TRUE, sep="\t")
covid.2019.coord <- read.table("../misc/coord.txt", h=TRUE, sep="\t")
# cc.logo <- readPNG("../misc/240px-Cc.logo.circle.svg.png")
# cc_by.logo <- readPNG("../misc/Cc-by_new.svg.png")

################################################################
# Disaggregating

covid.2019.ru.da <- NULL

for(i in 1:nrow(covid.2019.ru)){
	for(j in 1:covid.2019.ru[i,]$NUMBER){
	covid.2019.ru.da <- rbind.data.frame(covid.2019.ru.da, covid.2019.ru[i,])
	}
}

################################################################
# Trimming timestamps

covid.2019.ru$TIME <- strptime(covid.2019.ru$TIMESTAMP, "%Y-%m-%d %H:%M:%S")
covid.2019.ru.da$TIME <- strptime(covid.2019.ru.da$TIMESTAMP, "%Y-%m-%d %H:%M:%S")
covid.2019.breaks$TIME <- strptime(covid.2019.breaks$TIMESTAMP, "%Y-%m-%d %H:%M:%S")

################################################################
# Subsetting

# The quick from the dead
covid.2019.ru.i <- droplevels(subset(covid.2019.ru, covid.2019.ru$EVENT == "detected"))
covid.2019.ru.h <- subset(covid.2019.ru, covid.2019.ru$EVENT == "healed")

covid.2019.ru.da.i <- droplevels(subset(covid.2019.ru.da, covid.2019.ru.da$EVENT == "detected"))
covid.2019.ru.da.h <- subset(covid.2019.ru.da, covid.2019.ru.da$EVENT == "healed")

################################################################
# Data transformations

# Timeseries list;
covid.2019.ru.i.ts <- NULL

for(i in 1:length(levels(covid.2019.ru.i$TIMESTAMP))){
covid.2019.ru.i.ts[[i]] <- subset(covid.2019.ru.i, covid.2019.ru.i$TIMESTAMP == levels(covid.2019.ru.i$TIMESTAMP)[i])
}

# Noncumulated true time timeseries list;
covid.2019.ru.i.moment_ts <- NULL

for(i in 1:length(covid.2019.breaks$TIME)){
covid.2019.ru.i.moment_ts[[i]] <- subset(covid.2019.ru.da.i, 
covid.2019.ru.da.i$TIME < covid.2019.breaks$TIME[i] &
covid.2019.ru.da.i$TIME > covid.2019.breaks$TIME[i-1])
}

# Cumulated true time timeseries list for a map;
covid.2019.ru.i.cumul_ts <- NULL

for(i in 1:length(covid.2019.breaks$TIME)){
covid.2019.ru.i.cumul_ts[[i]] <- subset(covid.2019.ru.da.i, covid.2019.ru.da.i$TIME < covid.2019.breaks$TIME[i])
}

# Barplot regions list;
covid.2019.ru.i.reg <- NULL

for(i in 1:length(levels(covid.2019.ru.i$LOCUS))){
covid.2019.ru.i.reg[[i]] <- subset(covid.2019.ru.i, covid.2019.ru.i$LOCUS == levels(covid.2019.ru.i$LOCUS)[i])
}

# Mapping regions list;
covid.2019.ru.i.reg.0 <- NULL

for(i in 1:length(levels(covid.2019.ru.i$LOCUS.0))){
covid.2019.ru.i.reg.0[[i]] <- subset(covid.2019.ru.i, covid.2019.ru.i$LOCUS.0 == levels(covid.2019.ru.i$LOCUS.0)[i])
}

# Dynamics data frame;
covid.2019.ru.i.dyn <- NULL

for(i in 1:length(levels(covid.2019.ru.i$TIMESTAMP))){
covid.2019.ru.i.dyn <- rbind.data.frame(covid.2019.ru.i.dyn,
cbind.data.frame(
covid.2019.ru.i.ts[[i]]$TIME[1],
sum(covid.2019.ru.i.ts[[i]]$NUMBER))
)
}

colnames(covid.2019.ru.i.dyn) <- c("TIME","NUMBER")
covid.2019.ru.i.dyn$CUMSUM <- cumsum(covid.2019.ru.i.dyn$NUMBER)

# Barplot regions data frame;
covid.2019.ru.i.reg.df <- NULL

for(i in 1:length(levels(covid.2019.ru.i$LOCUS))){
covid.2019.ru.i.reg.df <- rbind.data.frame(covid.2019.ru.i.reg.df,
cbind.data.frame(covid.2019.ru.i.reg[[i]]$LOCUS[1],
sum(covid.2019.ru.i.reg[[i]]$NUMBER))
)
}

colnames(covid.2019.ru.i.reg.df) <- c("LOCUS","NUMBER")
covid.2019.ru.i.reg.ordered.df <- covid.2019.ru.i.reg.df[order(-covid.2019.ru.i.reg.df$NUMBER),]

# Mapping regions data frame;
covid.2019.ru.i.reg.0.df <- NULL

for(i in 1:length(levels(covid.2019.ru.i$LOCUS.0))){
covid.2019.ru.i.reg.0.df <- rbind.data.frame(covid.2019.ru.i.reg.0.df,
cbind.data.frame(covid.2019.ru.i.reg.0[[i]]$LOCUS.0[1],
sum(covid.2019.ru.i.reg.0[[i]]$NUMBER))
)
}

colnames(covid.2019.ru.i.reg.0.df) <- c("LOCUS","NUMBER")

# Momentary data

RUS <- NULL

for(i in 1:length(covid.2019.ru.i.moment_ts)){
RUS <- c(RUS, nrow(covid.2019.ru.i.moment_ts[[i]]))
}

# Singling out Moscow and St. Petersburg

Mos <- NULL

for(i in 1:length(covid.2019.ru.i.moment_ts)){
Mos <- c(Mos, nrow(subset(covid.2019.ru.i.moment_ts[[i]], covid.2019.ru.i.moment_ts[[i]]$LOCUS.0 == "Moscow")))
}

SPb <- NULL

for(i in 1:length(covid.2019.ru.i.moment_ts)){
SPb <- c(SPb, nrow(subset(covid.2019.ru.i.moment_ts[[i]], covid.2019.ru.i.moment_ts[[i]]$LOCUS.0 == "St. Petersburg")))
}

covid.2019.ru.i.dyn.tt <- cbind.data.frame(
  covid.2019.breaks$TIME,
  RUS,
  Mos,
  SPb
)

colnames(covid.2019.ru.i.dyn.tt) <- c("TIME","RUS","Mos","SPb")

covid.2019.ru.i.dyn.tt$RUS.CS <- cumsum(covid.2019.ru.i.dyn.tt$RUS)
covid.2019.ru.i.dyn.tt$Mos.CS <- cumsum(covid.2019.ru.i.dyn.tt$Mos)
covid.2019.ru.i.dyn.tt$SPb.CS <- cumsum(covid.2019.ru.i.dyn.tt$SPb)

################################################################
# Basic plots

# Cumulated growth
png("../plots/COVID.2019.cumulated.png", height=750, width=1000, res=120, pointsize=10)
par(mar=c(6,5,4,2)+.1)

plot(covid.2019.ru.i.dyn$TIME, covid.2019.ru.i.dyn$CUMSUM, type="l",
ylim=c(0, max(covid.2019.ru.i.dyn$CUMSUM)),
xlab="", 
ylab="Total COVID-2019 cases detected", 
main="Russian Federation",
axes=FALSE)

points(covid.2019.ru.i.dyn$TIME, covid.2019.ru.i.dyn$NUMBER, type="h", col=2, lwd=3)

axis.POSIXct(1, 
at=seq(min(covid.2019.breaks$TIME), max(covid.2019.breaks$TIME), by="week"), 
format = "%Y-%m-%d", 
las=2)
axis(2)

dev.off()

# Cumulated growth, by regions

png("../plots/COVID.2019.cumulated.by_regions.png", height=750, width=1000, res=120, pointsize=10)
par(mar=c(6,5,4,2)+.1)

plot(covid.2019.ru.i.dyn.tt$TIME, covid.2019.ru.i.dyn.tt$Mos.CS, 
type="l", col=2, xlab="", 
ylab="Total COVID-2019 cases detected", 
main="Russian Federation",
axes=FALSE)

points(covid.2019.ru.i.dyn.tt$TIME, covid.2019.ru.i.dyn.tt$SPb.CS, type="l",col=4)
points(covid.2019.ru.i.dyn.tt$TIME, (covid.2019.ru.i.dyn.tt$RUS.CS - (covid.2019.ru.i.dyn.tt$Mos.CS + covid.2019.ru.i.dyn.tt$SPb.CS)), type="l",col=3)

legend("topleft", lt=1, col=c(2,4,3), legend=c("Moscow","St. Petersburg","The rest of Russia"), bty="n")

axis.POSIXct(1, 
at=seq(min(covid.2019.breaks$TIME), max(covid.2019.breaks$TIME), by="week"), 
format = "%Y-%m-%d", 
las=2)
axis(2)

dev.off()

# Cumulated growth, log scale
png("../plots/COVID.2019.cumulated.log10.png", height=750, width=1000, res=120, pointsize=10)
par(mar=c(6,5,4,2)+.1)

plot(covid.2019.ru.i.dyn$TIME, log10(covid.2019.ru.i.dyn$CUMSUM), type="l",
ylim=c(0, max(log10(covid.2019.ru.i.dyn$CUMSUM))),
xlab="", 
ylab="Total COVID-2019 cases detected (logarithmic scale)", 
main="Russian Federation",
axes=FALSE)

points(covid.2019.ru.i.dyn$TIME, log10(covid.2019.ru.i.dyn$NUMBER), type="h", col=2, lwd=3)

axis.POSIXct(1, 
at=seq(min(covid.2019.breaks$TIME), max(covid.2019.breaks$TIME), by="week"), 
format = "%Y-%m-%d", 
las=2)
axis(2, at=log10(c(1,10,100,1000)), labels=c(1,10,100,1000))
axis(2, at=log10(c(1:9, seq(10,100,10), seq(200,1000,100), seq(2000,10000,1000))), labels=FALSE)

dev.off()

# Cumulated growth, log scale, by regions
png("../plots/COVID.2019.cumulated.log.10.by_regions.png", height=750, width=1000, res=120, pointsize=10)
par(mar=c(6,5,4,2)+.1)

plot(covid.2019.ru.i.dyn.tt$TIME, log10(covid.2019.ru.i.dyn.tt$Mos.CS), 
type="l", col=2, 
xlab="", 
ylab="Total COVID-2019 cases detected (logarithmic scale)", 
main="Russian Federation",
axes=FALSE)

points(covid.2019.ru.i.dyn.tt$TIME, log10(covid.2019.ru.i.dyn.tt$SPb.CS), type="l",col=4)
points(covid.2019.ru.i.dyn.tt$TIME, log10(covid.2019.ru.i.dyn.tt$RUS.CS - (covid.2019.ru.i.dyn.tt$Mos.CS + covid.2019.ru.i.dyn.tt$SPb.CS)), type="l",col=3)

rasterImage(cc.logo, 
xleft = covid.2019.ru.i.dyn.tt$TIME[1], 
xright=covid.2019.ru.i.dyn.tt$TIME[1]+dim(cc.logo)[2]*1200, 
ytop = log10(100), 
ybottom=log10(100)-dim(cc.logo)[1]/1600)

axis.POSIXct(1, 
at=seq(min(covid.2019.breaks$TIME), max(covid.2019.breaks$TIME), by="week"), 
format = "%Y-%m-%d", 
las=2)
axis(2, at=log10(c(1,10,100,1000)), labels=c(1,10,100,1000))
axis(2, at=log10(c(1:9, seq(10,100,10), seq(200,1000,100), seq(2000,10000,1000))), labels=FALSE)

legend("topleft", lt=1, col=c(2,4,3), legend=c("Moscow","St. Petersburg","The rest of Russia"), bty="n")

dev.off()

# Regions barplot
png("../plots/COVID.2019.barplot.regions.png", height=750, width=1000, res=120, pointsize=10)
par(mar=c(10,5,4,2)+.1, cex.axis=.7)

barplot(covid.2019.ru.i.reg.ordered.df$NUMBER, 
names.arg=covid.2019.ru.i.reg.ordered.df$LOCUS, 
xlab="", 
ylab=paste("Total COVID-2019 cases, as of",covid.2019.ru.i$TIMESTAMP[length(covid.2019.ru.i$TIMESTAMP)]), 
main="Russian Federation",
las=2)

dev.off()

# Map
png("../plots/COVID.2019.map.regions.png", height=750, width=1000, res=120, pointsize=10)

map(region="Russia", fill=TRUE, col=8) 
mtext(paste("Total COVID-2019 cases, as of",covid.2019.ru.i$TIMESTAMP[length(covid.2019.ru.i$TIMESTAMP)]), 
side=1, line=2) 
mtext("Russian Federation", font=2, cex=1.2, side=3, line=3)

points(covid.2019.coord$LON, covid.2019.coord$LAT, cex=sqrt(covid.2019.ru.i.reg.0.df$NUMBER)/2, pch=21, bg=2)

dev.off()

################################################################
# # Do not execute this part of the code mindlessly!
# # Map animated
# dir.create("../plots/map.animated/")
#
# for(i in 1:length(covid.2019.ru.i.cumul_ts)){
# 	if(i < 10){
# 	png(file=paste("../plots/map.animated/COVID.2019.map.regions.00",i,".png", sep=""), height=750, width=1000, res=120, pointsize=10)
# 	}else if(i < 100){
# 	png(file=paste("../plots/map.animated/COVID.2019.map.regions.0",i,".png", sep=""), height=750, width=1000, res=120, pointsize=10)
# 	}else{
# 	png(file=paste("../plots/map.animated/COVID.2019.map.regions.",i,".png", sep=""), height=750, width=1000, res=120, pointsize=10)
# 	}
#
# map(region="Russia", fill=TRUE, col=8) 
# mtext(paste("Total COVID-2019 cases, as of",covid.2019.breaks$TIMESTAMP[i]), 
# side=1, line=2, cex=2) 
# mtext("Russian Federation", font=2, cex=2, side=3, line=3)
#
# points(covid.2019.coord$LON, covid.2019.coord$LAT, cex=sqrt(as.data.frame(table(covid.2019.ru.i.cumul_ts[[i]]$LOCUS.0))$Freq)/2, pch=21, bg=2)
#
# dev.off()
# }
#
# # ffmpeg command line: 
# #
# # ffmpeg -r 2 -f image2 -s 1000x750 -i COVID.2019.map.regions.%03d.png -vcodec libx264 -crf 25 -pix_fmt yuv420p COVID.2019.ru.map.animated.mp4
