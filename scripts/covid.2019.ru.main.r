# Loading libraries

library(maps)

# Reading data

covid.2019.ru <- read.table("/home/tinea/Documents/H_et_S/Projects/github/COVID.2019.ru/data/momentary.txt", h=TRUE, sep="\t")

# Trimming timestamps

covid.2019.ru$TIME <- strptime(covid.2019.ru$TIMESTAMP, "%Y-%m-%d %H:%M:%S")

# Subsetting

covid.2019.ru.i <- droplevels(subset(covid.2019.ru, covid.2019.ru$EVENT == "detected"))
covid.2019.ru.h <- subset(covid.2019.ru, covid.2019.ru$EVENT == "healed")

covid.2019.ru.i.ls <- NULL

for(i in 1:length(levels(covid.2019.ru.i$TIMESTAMP))){
covid.2019.ru.i.ls[[i]] <- subset(covid.2019.ru.i, covid.2019.ru.i$TIMESTAMP == levels(covid.2019.ru.i$TIMESTAMP)[i])
}

covid.2019.ru.i.dyn <- NULL

for(i in 1:length(levels(covid.2019.ru.i$TIMESTAMP))){
covid.2019.ru.i.dyn <- rbind.data.frame(covid.2019.ru.i.dyn,
cbind.data.frame(
covid.2019.ru.i.ls[[i]]$TIME[1],
sum(covid.2019.ru.i.ls[[i]]$NUMBER))
)
}

colnames(covid.2019.ru.i.dyn) <- c("TIME","NUMBER")
covid.2019.ru.i.dyn$CUMSUM <- cumsum(covid.2019.ru.i.dyn$NUMBER)

# Basic plots

png("../plots/COVID.2019.cumulated.png", height=750, width=1000, res=120, pointsize=10)

plot(covid.2019.ru.i.dyn$TIME, covid.2019.ru.i.dyn$CUMSUM, type="l",
xlab="Timeline", ylab="Open COVID-2019 cases", main="Russian Federation")
points(covid.2019.ru.i.dyn$TIME, covid.2019.ru.i.dyn$NUMBER, type="h", col=2)

dev.off()
