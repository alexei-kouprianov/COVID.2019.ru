# Loading libraries

library(maps)

# Reading data

covid.2019.ru <- read.table("../data/momentary.txt", h=TRUE, sep="\t")
covid.2019.breaks <- read.table("../misc/breaks.txt", h=TRUE, sep="\t")

# Trimming timestamps

covid.2019.ru$TIME <- strptime(covid.2019.ru$TIMESTAMP, "%Y-%m-%d %H:%M:%S")
covid.2019.breaks$TIME <- strptime(covid.2019.breaks$TIMESTAMP, "%Y-%m-%d %H:%M:%S")

# Subsetting

covid.2019.ru.i <- droplevels(subset(covid.2019.ru, covid.2019.ru$EVENT == "detected"))
covid.2019.ru.h <- subset(covid.2019.ru, covid.2019.ru$EVENT == "healed")

covid.2019.ru.i.ts <- NULL

for(i in 1:length(levels(covid.2019.ru.i$TIMESTAMP))){
covid.2019.ru.i.ts[[i]] <- subset(covid.2019.ru.i, covid.2019.ru.i$TIMESTAMP == levels(covid.2019.ru.i$TIMESTAMP)[i])
}

covid.2019.ru.i.reg <- NULL

for(i in 1:length(levels(covid.2019.ru.i$LOCUS))){
covid.2019.ru.i.reg[[i]] <- subset(covid.2019.ru.i, covid.2019.ru.i$LOCUS == levels(covid.2019.ru.i$LOCUS)[i])
}

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

covid.2019.ru.i.reg.df <- NULL

for(i in 1:length(levels(covid.2019.ru.i$LOCUS))){
covid.2019.ru.i.reg.df <- rbind.data.frame(covid.2019.ru.i.reg.df,
cbind.data.frame(covid.2019.ru.i.reg[[i]]$LOCUS[1],
sum(covid.2019.ru.i.reg[[i]]$NUMBER))
)
}

colnames(covid.2019.ru.i.reg.df) <- c("LOCUS","NUMBER")

covid.2019.ru.i.reg.df <- covid.2019.ru.i.reg.df[order(-covid.2019.ru.i.reg.df$NUMBER),]

# Basic plots

png("../plots/COVID.2019.cumulated.png", height=750, width=1000, res=120, pointsize=10)
par(mar=c(6,5,4,2)+.1)

plot(covid.2019.ru.i.dyn$TIME, covid.2019.ru.i.dyn$CUMSUM, type="l",
ylim=c(0, max(covid.2019.ru.i.dyn$CUMSUM)),
xlab="", ylab="Open COVID-2019 cases", main="Russian Federation",
axes=FALSE)

points(covid.2019.ru.i.dyn$TIME, covid.2019.ru.i.dyn$NUMBER, type="h", col=2)

axis.POSIXct(1, at=covid.2019.breaks$TIME, las=2)
axis(2)

dev.off()

png("../plots/COVID.2019.barplot.regions.png", height=750, width=1000, res=120, pointsize=10)
par(mar=c(10,5,4,2)+.1)

barplot(covid.2019.ru.i.reg.df$NUMBER, 
names.arg=covid.2019.ru.i.reg.df$LOCUS, 
xlab="", 
ylab=paste("Total COVID-2019 cases, as of",covid.2019.ru.i$TIMESTAMP[length(covid.2019.ru.i$TIMESTAMP)]), main="Russian Federation",
las=2)

dev.off()
