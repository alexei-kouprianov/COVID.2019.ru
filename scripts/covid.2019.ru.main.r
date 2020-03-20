################################################################
# Loading libraries, setting locale for time

library(maps)
Sys.setlocale("LC_TIME", "en_US.UTF-8")

################################################################
# Reading data

covid.2019.ru <- read.table("../data/momentary.txt", h=TRUE, sep="\t")
covid.2019.breaks <- read.table("../misc/breaks.txt", h=TRUE, sep="\t")
covid.2019.coord <- read.table("../misc/coord.txt", h=TRUE, sep="\t")

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

# Timeseries list
covid.2019.ru.i.ts <- NULL

for(i in 1:length(levels(covid.2019.ru.i$TIMESTAMP))){
covid.2019.ru.i.ts[[i]] <- subset(covid.2019.ru.i, covid.2019.ru.i$TIMESTAMP == levels(covid.2019.ru.i$TIMESTAMP)[i])
}

# Cumulated true time timeseries list
covid.2019.ru.i.true_ts <- NULL

for(i in 1:length(covid.2019.breaks$TIME)){
covid.2019.ru.i.true_ts[[i]] <- subset(covid.2019.ru.da.i, covid.2019.ru.da.i$TIME < covid.2019.breaks$TIME[i])
}

# Barplot regions list
covid.2019.ru.i.reg <- NULL

for(i in 1:length(levels(covid.2019.ru.i$LOCUS))){
covid.2019.ru.i.reg[[i]] <- subset(covid.2019.ru.i, covid.2019.ru.i$LOCUS == levels(covid.2019.ru.i$LOCUS)[i])
}

# Mapping regions list
covid.2019.ru.i.reg.0 <- NULL

for(i in 1:length(levels(covid.2019.ru.i$LOCUS.0))){
covid.2019.ru.i.reg.0[[i]] <- subset(covid.2019.ru.i, covid.2019.ru.i$LOCUS.0 == levels(covid.2019.ru.i$LOCUS.0)[i])
}

# Dynamics data frame
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

# Barplot regions data frame
covid.2019.ru.i.reg.df <- NULL

for(i in 1:length(levels(covid.2019.ru.i$LOCUS))){
covid.2019.ru.i.reg.df <- rbind.data.frame(covid.2019.ru.i.reg.df,
cbind.data.frame(covid.2019.ru.i.reg[[i]]$LOCUS[1],
sum(covid.2019.ru.i.reg[[i]]$NUMBER))
)
}

colnames(covid.2019.ru.i.reg.df) <- c("LOCUS","NUMBER")
covid.2019.ru.i.reg.ordered.df <- covid.2019.ru.i.reg.df[order(-covid.2019.ru.i.reg.df$NUMBER),]

# Mapping regions data frame
covid.2019.ru.i.reg.0.df <- NULL

for(i in 1:length(levels(covid.2019.ru.i$LOCUS.0))){
covid.2019.ru.i.reg.0.df <- rbind.data.frame(covid.2019.ru.i.reg.0.df,
cbind.data.frame(covid.2019.ru.i.reg.0[[i]]$LOCUS.0[1],
sum(covid.2019.ru.i.reg.0[[i]]$NUMBER))
)
}

colnames(covid.2019.ru.i.reg.0.df) <- c("LOCUS","NUMBER")

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
axis(2, at=log10(c(1,10,100)), labels=c(1,10,100))
axis(2, at=log10(c(1:10, seq(10,100,10), seq(100,1000,100))), labels=FALSE)

dev.off()

# Regions barplot
png("../plots/COVID.2019.barplot.regions.png", height=750, width=1000, res=120, pointsize=10)
par(mar=c(10,5,4,2)+.1)

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

points(covid.2019.coord$LON, covid.2019.coord$LAT, cex=sqrt(covid.2019.ru.i.reg.0.df$NUMBER/2), pch=21, bg=2)

dev.off()

################################################################
# # Do not execute this part of the code mindlessly!
# # Map animated
# dir.create("../plots/map.animated/")
#
# for(i in 1:length(covid.2019.ru.i.true_ts)){
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
# points(covid.2019.coord$LON, covid.2019.coord$LAT, cex=sqrt(as.data.frame(table(covid.2019.ru.i.true_ts[[i]]$LOCUS.0))$Freq/2), pch=21, bg=2)
#
# dev.off()
# }
#
# # ffmpeg command line: 
# #
# # ffmpeg -r 2 -f image2 -s 1000x750 -i COVID.2019.map.regions.%03d.png -vcodec libx264 -crf 25 -pix_fmt yuv420p COVID.2019.ru.map.animated.mp4
