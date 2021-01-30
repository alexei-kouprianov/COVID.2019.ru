# cd /home/tinea/Documents/H_et_S/Projects/github/COVID.2019.ru/scripts/

################################################################
################################################################
## 
## This script was created to increase the portability 
## of the project. It works slower than the regular
## data processing and plotting scripts but it does everything
## all alone.
##
## It includes parts of the code from :
## (1) covid.2019.ru.libraries.r
## (2) covid.2019.converter.r
## (3) covid.2019.ru.main.20201104.r
## (4) covid.2019.ru.plots.20201104.r
##
################################################################
################################################################

################################################################
################################################################
##
## Loading libraries, setting locale for time
##
################################################################
################################################################

library(maps)
library(TeachingDemos)
library(rgdal)
library(rmarkdown)
library(rjson)
library(xlsx)

Sys.setlocale("LC_TIME", "en_US.UTF-8")

################################################################
################################################################
## Preparing data for the old analytic scripts
## (Spring -- Summer of 2020); kept for compatibility purposes
##
################################################################
################################################################

daily.data.raw <- fromJSON(file="../downloads/stopcoronavirus.storage.moment.20200429.json")
daily.timestamp <- read.table("../downloads/stopcoronavirus.timestamp.moment.20200429.txt")
loci <- read.table("../misc/loci.txt", h=TRUE, sep="\t")
covid.2019.ru <- read.table("../data/momentary.txt", h=TRUE, sep="\t")

title <- NULL
code <- NULL
is_city <- NULL
coord_x <- NULL
coord_y <- NULL
sick <- NULL
healed <- NULL
died <- NULL
sick_incr <- NULL
healed_incr <- NULL
died_incr <- NULL

for(i in 1:length(daily.data.raw)){
title <- c(title, daily.data.raw[[i]]$title)
code <- c(code, daily.data.raw[[i]]$code)
is_city <- c(is_city, daily.data.raw[[i]]$is_city)
coord_x <- c(coord_x, daily.data.raw[[i]]$coord_x)
coord_y <- c(coord_y, daily.data.raw[[i]]$coord_y)
sick <- c(sick, daily.data.raw[[i]]$sick)
healed <- c(healed, daily.data.raw[[i]]$healed)
died <- c(died, daily.data.raw[[i]]$died)
sick_incr <- c(sick_incr, daily.data.raw[[i]]$sick_incr)
healed_incr <- c(healed_incr, daily.data.raw[[i]]$healed_incr)
died_incr <- c(died_incr, daily.data.raw[[i]]$died_incr)
}

daily.data.raw.df <- cbind.data.frame(
title,
code, 
is_city,
coord_x, 
coord_y, 
sick, 
healed, 
died, 
sick_incr, 
healed_incr, 
died_incr
)

daily.data.raw.df.s <- daily.data.raw.df[order(daily.data.raw.df$title),]

cumulated.df <- data.frame(
rep(daily.timestamp$V1, nrow(daily.data.raw.df.s)*3),
c(rep("detected", nrow(daily.data.raw.df.s)),
rep("recovered", nrow(daily.data.raw.df.s)),
rep("deceased", nrow(daily.data.raw.df.s))
),
rep(daily.data.raw.df.s$title, 3), 
c(daily.data.raw.df.s$sick, daily.data.raw.df.s$healed, daily.data.raw.df.s$died)
)

colnames(cumulated.df) <- c("TIMESTAMP", "STATUS", "REGION", "NUMBER")

increment.df <- data.frame(
rep(daily.timestamp$V1, nrow(daily.data.raw.df.s)*3),
c(rep("detected", nrow(daily.data.raw.df.s)),
rep("recovered", nrow(daily.data.raw.df.s)),
rep("deceased", nrow(daily.data.raw.df.s))
),
rep(daily.data.raw.df.s$title, 3), 
c(daily.data.raw.df.s$sick_incr, daily.data.raw.df.s$healed_incr, daily.data.raw.df.s$died_incr)
)

colnames(increment.df) <- c("TIMESTAMP", "STATUS", "REGION", "NUMBER")

increment.df.0 <- increment.df[order(increment.df$REGION, increment.df$STATUS),]
increment.df.0 <- cbind.data.frame(increment.df.0, loci)
increment.df.0 <- increment.df.0[,c(1,2,5,6,3,4)]
increment.df.0 <- subset(increment.df.0, increment.df.0$NUMBER > 0)
increment.df.0 <- increment.df.0[order(increment.df.0$STATUS, -increment.df.0$NUMBER),]

colnames(increment.df.0) <- c("TIMESTAMP", "EVENT", "LOCUS.0", "LOCUS", "LOCUS.ORIG", "NUMBER")

increment.df.0$UID <- NA
increment.df.0$ORIGIN <- NA
increment.df.0$SRC <- "https://стопкоронавирус.рф/ robot-trimmed and post-processed"
increment.df.0$COMMENT <- NA
increment.df.0$DB.OPERATOR <- "Alexei Kouprianov"

covid.2019.ru <- rbind.data.frame(covid.2019.ru, increment.df.0)

# Writing TDT files

write.table(covid.2019.ru, "../data/momentary.txt", row.names=FALSE, sep="\t")
write.table(increment.df, "../downloads/increment.txt", row.names=FALSE, sep="\t")
write.table(increment.df.0, "../downloads/increment.0.txt", row.names=FALSE, sep="\t")

# title
# code
# is_city
# coord_x
# coord_y
# sick
# healed
# died
# sick_incr
# healed_incr
# died_incr

###################################################################
###################################################################
##
## Data transformation
##
###################################################################
###################################################################

###################################################################
###################################################################
##
## ATTENTION! Do not execute this part of code mindlessly!
##
## Uncomment the following section only in case you need to recover
##
## covid.2019.ru.dyn.tot.primary
##
## from ../data/primary_dataset_backup.json
##
###################################################################
###################################################################

# # primary_dataset_backup.json.ls <- fromJSON(file="../data/primary_dataset_backup.json")
# #
# # dataset.recovered.primary.ls <- NULL
# # dataset.recovered.primary.ls <- as.list(dataset.recovered.primary.ls)
# #
# # for(i in 1:length(primary_dataset_backup.json.ls)){
# # 	ISOdatetime.recovered <- ISOdatetime(
# # 	year = primary_dataset_backup.json.ls[[i]]$TIME$year + 1900,
# # 	month = primary_dataset_backup.json.ls[[i]]$TIME$mon + 1,
# # 	day = primary_dataset_backup.json.ls[[i]]$TIME$mday,
# # 	hour = primary_dataset_backup.json.ls[[i]]$TIME$hour,
# # 	min = primary_dataset_backup.json.ls[[i]]$TIME$min,
# # 	sec = primary_dataset_backup.json.ls[[i]]$TIME$sec,
# # 	tz = "MSK")
# #
# # dataset.recovered.primary.ls[[i]] <- cbind.data.frame(
# # 	ISOdatetime.recovered, 
# # 	primary_dataset_backup.json.ls[[i]]$i,
# # 	primary_dataset_backup.json.ls[[i]]$r,
# # 	primary_dataset_backup.json.ls[[i]]$d
# # 	)
# #
# # colnames(dataset.recovered.primary.ls[[i]]) <- c("TIME", "i", "r", "d")
# #
# # }
# #
# # names(dataset.recovered.primary.ls) <- names(primary_dataset_backup.json.ls)
# #
# # covid.2019.ru.dyn.tot.primary <- dataset.recovered.primary.ls

###################################################################
###################################################################
##
## Uncomment the preceding section only in case you need to recover
##
## covid.2019.ru.dyn.tot.primary
##
## from ../data/primary_dataset_backup.json
##
###################################################################
###################################################################

# Loading population table and daily increments;

pop <- read.table("../misc/population.txt", h=TRUE, sep="\t")
increment <- read.table("../downloads/increment.txt", h=TRUE, sep="\t")
REGION.RosStat.df <- read.table("../misc/REGION.RosStat.txt", h=TRUE, sep="\t")

# Transformning variables;

increment$TIME <- strptime(increment$TIMESTAMP, "%Y-%m-%d %H:%M:%S")
increment$REGION <- as.character(increment$REGION)
increment$REGION <- factor(increment$REGION, levels = as.character(pop$REGION.INCR))

pop$REGION.RosStat <- as.character(pop$REGION.RosStat)
pop$REGION.RosStat <- factor(pop$REGION.RosStat, levels = as.character(REGION.RosStat.df$REGION.RosStat.levels))

# Appending new increments by regions to primary dynamics list of data frames 'covid.2019.ru.dyn.tot.primary';

incr.ls <- NULL
incr.ls <- as.list(incr.ls)

for(i in 1:length(levels(increment$REGION))){
	incr.ls[[i]] <- cbind.data.frame(
		subset(increment, increment$REGION == levels(increment$REGION)[i] & increment$STATUS == "detected")$TIME,
		subset(increment, increment$REGION == levels(increment$REGION)[i] & increment$STATUS == "detected")$NUMBER,
		subset(increment, increment$REGION == levels(increment$REGION)[i] & increment$STATUS == "recovered")$NUMBER,
		subset(increment, increment$REGION == levels(increment$REGION)[i] & increment$STATUS == "deceased")$NUMBER
		)
	names(incr.ls[[i]]) <- names(covid.2019.ru.dyn.tot.primary[[i]])
	covid.2019.ru.dyn.tot.primary[[i]] <- rbind.data.frame(covid.2019.ru.dyn.tot.primary[[i]], incr.ls[[i]])
	rownames(covid.2019.ru.dyn.tot.primary[[i]]) <- 1:nrow(covid.2019.ru.dyn.tot.primary[[i]])
}

# Saving primary dynamics list of data frames to a json file;

covid.2019.ru.dyn.tot.primary.json <- toJSON(covid.2019.ru.dyn.tot.primary)
write(covid.2019.ru.dyn.tot.primary.json, "../data/primary_dataset_backup.json")

# Compiling derived dynamics list of data frames;

covid.2019.ru.dyn.tot.derived <- covid.2019.ru.dyn.tot.primary

for(i in 1:length(covid.2019.ru.dyn.tot.derived)){

	i.7 <- c(NA,NA,NA)
	for(k in 4:(nrow(covid.2019.ru.dyn.tot.derived[[i]])-3)){
		i.7 <- c(i.7, mean(covid.2019.ru.dyn.tot.derived[[i]]$i[(k-3):(k+3)], na.rm=TRUE))
		}
	covid.2019.ru.dyn.tot.derived[[i]]$i.7 <- c(i.7, NA, NA, NA)

	d.7 <- c(NA,NA,NA)
	for(k in 4:(nrow(covid.2019.ru.dyn.tot.derived[[i]])-3)){
		d.7 <- c(d.7, mean(covid.2019.ru.dyn.tot.derived[[i]]$d[(k-3):(k+3)], na.rm=TRUE))
		}
	covid.2019.ru.dyn.tot.derived[[i]]$d.7 <- c(d.7, NA, NA, NA)

	R.RPN <- rep(NA,8) 
	for(k in 9:(nrow(covid.2019.ru.dyn.tot.derived[[i]]))){
	R.RPN <- c(R.RPN, sum(covid.2019.ru.dyn.tot.derived[[i]]$i[(k):(k-3)], na.rm=TRUE)/sum(covid.2019.ru.dyn.tot.derived[[i]]$i[(k-4):(k-7)], na.rm=TRUE))
	}
	R.RPN <- c(R.RPN)
	covid.2019.ru.dyn.tot.derived[[i]]$R.RPN <- R.RPN

	covid.2019.ru.dyn.tot.derived[[i]]$i.7.var <- abs(covid.2019.ru.dyn.tot.derived[[i]]$i - covid.2019.ru.dyn.tot.derived[[i]]$i.7)/covid.2019.ru.dyn.tot.derived[[i]]$i.7

}

# Russia primary dynamics data frame 'covid.2019.ru.dyn';

RU.TIME <- covid.2019.ru.dyn.tot.primary[[1]]$TIME
RU.i <- covid.2019.ru.dyn.tot.primary[[1]]$i
RU.r <- covid.2019.ru.dyn.tot.primary[[1]]$r
RU.d <- covid.2019.ru.dyn.tot.primary[[1]]$d

for(i in 2:length(covid.2019.ru.dyn.tot.primary)){
	RU.i <- RU.i + covid.2019.ru.dyn.tot.primary[[i]]$i
	RU.r <- RU.r + covid.2019.ru.dyn.tot.primary[[i]]$r
	RU.d <- RU.d + covid.2019.ru.dyn.tot.primary[[i]]$d
}

covid.2019.ru.dyn <- cbind.data.frame(
RU.TIME,
RU.i,
RU.r,
RU.d
)

colnames(covid.2019.ru.dyn) <- c("TIME","i","r","d")

# Regional summary data frame 'pop.derived';

DETECTED <- NULL

for(i in 1:length(covid.2019.ru.dyn.tot.primary[[i]]$i)){
DETECTED <- c(DETECTED, sum(covid.2019.ru.dyn.tot.primary[[i]]$i))
}

DETECTED.7 <- NULL

for(i in 1:length(covid.2019.ru.dyn.tot.primary)){
DETECTED.7 <- c(DETECTED.7, sum(tail(covid.2019.ru.dyn.tot.primary[[i]]$i, 7)))
}

DETECTED.1 <- NULL

for(i in 1:length(covid.2019.ru.dyn.tot.primary)){
DETECTED.1 <- c(DETECTED.1, sum(tail(covid.2019.ru.dyn.tot.primary[[i]]$i, 1)))
}

ACTIVE <- NULL

for(i in 1:length(covid.2019.ru.dyn.tot.primary)){
ACTIVE <- c(ACTIVE, (sum(covid.2019.ru.dyn.tot.primary[[i]]$i) - (sum(covid.2019.ru.dyn.tot.primary[[i]]$r) + sum(covid.2019.ru.dyn.tot.primary[[i]]$d))))
}

i.7.var.rmean.7 <- NULL

for(i in 1:length(covid.2019.ru.dyn.tot.derived)){
i.7.var.rmean.7 <- c(i.7.var.rmean.7, mean(tail(covid.2019.ru.dyn.tot.derived[[i]]$i.7.var, 10)[1:7]))
}

pop.derived <- cbind.data.frame(pop, DETECTED, DETECTED.7, DETECTED.1, ACTIVE, i.7.var.rmean.7)

pop.derived$DETECTED.100K <- pop.derived$DETECTED / (pop.derived$POPULATION.20200101 / 100000)
pop.derived$DETECTED.7.100K <- pop.derived$DETECTED.7 / (pop.derived$POPULATION.20200101 / 100000)
pop.derived$ACTIVE.100K <- pop.derived$ACTIVE / (pop.derived$POPULATION.20200101 / 100000)

# Report variables [hidden from default ls()];

.report.bad.base <- (summary(pop.derived$DETECTED.1)[5] %/% 100)*100
.report.timestamp <- tail(RU.TIME, 1)
.report.RUS.i.cum <- round(tail(cumsum(RU.i)/1000, 1), 1)
.report.RUS.d.cum <- tail(cumsum(RU.d), 1)
.report.RUS.i.today <- round(tail(RU.i, 1)/1000, 1)
.report.RUS.d.today <- tail(RU.d, 1)
.report.RUS.i.14.100 <- round(sum(tail(RU.i, 14)) / (146748590 / 100000), 2)
.report.incr.abs.t <- subset(pop.derived, pop.derived$DETECTED.1 >= .report.bad.base)[, c("REGION.INCR","DETECTED.1")]
   .report.incr.abs.t <- .report.incr.abs.t[order(-.report.incr.abs.t$DETECTED.1),]
   .report.incr.abs.t$PRINT <- paste(.report.incr.abs.t[,1], .report.incr.abs.t[,2], sep=" : ")
.report.Moscow <- round(tail(cumsum(covid.2019.ru.dyn.tot.primary[[46]]$i/1000), 1), 1)
.report.SPb <- round(tail(cumsum(covid.2019.ru.dyn.tot.primary[[68]]$i/1000), 1), 1)

save.image()

# Rendering textual report;

render("../Rmd/daily.report.Rmd")

# plot(covid.2019.ru.dyn.tot.primary[[68]]$TIME, covid.2019.ru.dyn.tot.primary[[68]]$i, type="h")

################################################################
################################################################
##
## Plots
##
################################################################
################################################################

################################################################
################################################################
## Updating folders tree
################################################################
################################################################

dir.create("../plots/")
dir.create("../plots/regions/")
dir.create("../plots/regions/linear/")
dir.create("../plots/regions/increments/")
dir.create("../plots/regions/increments/i/")
dir.create("../plots/regions/increments/d/")
dir.create("../plots/regions/increments/i.7.var/")

################################################################
################################################################
## Russia
################################################################
################################################################

# Pending graphs:
# # 04.COVID.2019.cumulated.by_regions.png
# # 05.COVID.2019.cumulated.log.10.by_regions.png
# # 06.COVID.2019.cumulated.log10.1M.png
# 07.COVID.2019.growth_ratio.png
# 08.COVID.2019.hist.rdi.png
# 09.COVID.2019.hist.dt.png
# 14.1.COVID.2019.map.density.regions.rdi7dt.png
# # # 31.COVID.2019.fitting.rmc.partial.01.log10.png
# # # 32.COVID.2019.fitting.rmc.partial.02.RUS.Prov.log10.png
# # # 33.COVID.2019.fitting.rmc.partial.03.Mos.log10.png
# # # 34.COVID.2019.fitting.rmc.partial.04.SPb.log10.png

################################################################
# Overview Linear

png("../plots/01.COVID.2019.cumulated.TARD.png", height=750, width=1000, res=120, pointsize=10)
par(mar=c(6,5,4,5)+.1, lwd=2)

plot(covid.2019.ru.dyn$TIME, cumsum(covid.2019.ru.dyn$i), 
type="n", 
main="Russian Federation",
xlab="",
ylab="COVID-2019 cases detected",
axes=FALSE
)

# Increments detcted;
lines(covid.2019.ru.dyn$TIME, covid.2019.ru.dyn$i, type="h", col="darkred")

# Cumulated detected;
lines(covid.2019.ru.dyn$TIME, cumsum(covid.2019.ru.dyn$i), col="white", lwd=5)
lines(covid.2019.ru.dyn$TIME, cumsum(covid.2019.ru.dyn$i), col="darkred", lwd=2)

# Active;
lines(covid.2019.ru.dyn$TIME, cumsum(covid.2019.ru.dyn$i)-(cumsum(covid.2019.ru.dyn$r)+cumsum(covid.2019.ru.dyn$d)), col="white", lwd=5)
lines(covid.2019.ru.dyn$TIME, cumsum(covid.2019.ru.dyn$i)-(cumsum(covid.2019.ru.dyn$r)+cumsum(covid.2019.ru.dyn$d)), col=2, lwd=2)

# Cumulated recovered;
lines(covid.2019.ru.dyn$TIME, cumsum(covid.2019.ru.dyn$r), col="white", lwd=5)
lines(covid.2019.ru.dyn$TIME, cumsum(covid.2019.ru.dyn$r), col="darkgreen", lwd=2)

# Cumulated deaths;
lines(covid.2019.ru.dyn$TIME, cumsum(covid.2019.ru.dyn$d), col="white", lwd=5)
lines(covid.2019.ru.dyn$TIME, cumsum(covid.2019.ru.dyn$d), col=1, lwd=2)

legend(
"topleft",
lty=1,
lwd=2,
col=c("darkred","red","darkgreen","black"),
legend=c("Total cases (vertical bars = new ones)","Active cases","Recovered","Deceased"),
bty="n"
)

# Grid for months;
abline(v = seq(min(covid.2019.ru.dyn$TIME), max(covid.2019.ru.dyn$TIME), by = "month"), lty = 3, col = 8, lwd=.75)

axis(2)

axis.POSIXct(1,
at = seq(min(covid.2019.ru.dyn$TIME), max(covid.2019.ru.dyn$TIME), by = "week"),
format = "%Y-%m-%d",
las = 2)

dev.off()

################################################################
# Overview Y-logarithmic

png("../plots/02.COVID.2019.cumulated.TARD.log10.png", height=750, width=1000, res=120, pointsize=10)
par(mar=c(6,5,4,5)+.1, lwd=2)

plot(covid.2019.ru.dyn$TIME, log10(cumsum(covid.2019.ru.dyn$i)), 
type="n", 
ylim=c(0, log10(tail(cumsum(covid.2019.ru.dyn$i), 1))),
main="Russian Federation",
xlab="",
ylab="COVID-2019 cases detected (logarithmic scale)",
axes=FALSE
)

# Increments detcted;
lines(covid.2019.ru.dyn$TIME, log10(covid.2019.ru.dyn$i), type="h", col="darkred")

# Cumulated detected;
lines(covid.2019.ru.dyn$TIME, log10(cumsum(covid.2019.ru.dyn$i)), col="white", lwd=5)
lines(covid.2019.ru.dyn$TIME, log10(cumsum(covid.2019.ru.dyn$i)), col="darkred", lwd=2)

# Active;
lines(covid.2019.ru.dyn$TIME, log10(cumsum(covid.2019.ru.dyn$i)-(cumsum(covid.2019.ru.dyn$r)+cumsum(covid.2019.ru.dyn$d))), col="white", lwd=5)
lines(covid.2019.ru.dyn$TIME, log10(cumsum(covid.2019.ru.dyn$i)-(cumsum(covid.2019.ru.dyn$r)+cumsum(covid.2019.ru.dyn$d))), col=2, lwd=2)

# Cumulated recovered;
lines(covid.2019.ru.dyn$TIME, log10(cumsum(covid.2019.ru.dyn$r)), col="white", lwd=5)
lines(covid.2019.ru.dyn$TIME, log10(cumsum(covid.2019.ru.dyn$r)), col="darkgreen", lwd=2)

# Cumulated deaths;
lines(covid.2019.ru.dyn$TIME, log10(cumsum(covid.2019.ru.dyn$d)), col="white", lwd=5)
lines(covid.2019.ru.dyn$TIME, log10(cumsum(covid.2019.ru.dyn$d)), col=1, lwd=2)

abline(h=log10(50), lty=3, lwd=.75)

legend(
"topleft",
lty=1,
lwd=2,
col=c("darkred","red","darkgreen","black"),
legend=c("Total cases (vertical bars = new ones)","Active cases","Recovered","Deceased"),
bty="n"
)

# Grid for months;
abline(v = seq(min(covid.2019.ru.dyn$TIME), max(covid.2019.ru.dyn$TIME), by = "month"), lty = 3, col = 8, lwd=.75)

axis(2, at=log10(c(1,10,100,1000,10000,100000,1000000,10000000)), labels=c("1","10","100","1K","10K","100K","1M","10M"))
axis(2, at=log10(c(1:9, seq(10,100,10), seq(200,1000,100), seq(2000,10000,1000), seq(20000,100000,10000), seq(200000,1000000,100000), seq(2000000,10000000,1000000))), labels=FALSE)

axis.POSIXct(1,
at = seq(min(covid.2019.ru.dyn$TIME), max(covid.2019.ru.dyn$TIME), by = "week"),
format = "%Y-%m-%d",
las = 2)

dev.off()

################################################################
# Case Fatality Ratio

png("../plots/03.COVID.2019.CaseFatalityRatio.dyn.png", height=750, width=1000, res=120, pointsize=10)
par(mar=c(6,5,4,5)+.1)

plot(
covid.2019.ru.dyn$TIME[49:nrow(covid.2019.ru.dyn)], 
cumsum(covid.2019.ru.dyn$d)[49:nrow(covid.2019.ru.dyn)]/(cumsum(covid.2019.ru.dyn$r[49:nrow(covid.2019.ru.dyn)]) + cumsum(covid.2019.ru.dyn$d[49:nrow(covid.2019.ru.dyn)])), 
type="l", 
ylim=c(0, max(cumsum(covid.2019.ru.dyn$d[49:nrow(covid.2019.ru.dyn)])/(cumsum(covid.2019.ru.dyn$r[49:nrow(covid.2019.ru.dyn)]) + cumsum(covid.2019.ru.dyn$d[49:nrow(covid.2019.ru.dyn)])))),
main=paste("Russian Federation, Case Fatality Ratio / ", tail(covid.2019.ru.dyn$TIM, 1)),
xlab="",
ylab="Case Fatality Ratio",
axes=FALSE
)

# Grid for months;
abline(v = seq(min(covid.2019.ru.dyn$TIME), max(covid.2019.ru.dyn$TIME), by = "month"), lty = 3, col = 8, lwd=.75)
abline(h=seq(0,1,.01), lty=3, col=8)

lines(
covid.2019.ru.dyn$TIME[49:nrow(covid.2019.ru.dyn)],
covid.2019.ru.dyn$d[49:nrow(covid.2019.ru.dyn)] /
sqrt(
covid.2019.ru.dyn$r[49:nrow(covid.2019.ru.dyn)]
*
covid.2019.ru.dyn$i[49:nrow(covid.2019.ru.dyn)]
),
lty=3
)

lines(
covid.2019.ru.dyn$TIME[49:nrow(covid.2019.ru.dyn)], 
cumsum(covid.2019.ru.dyn$d[49:nrow(covid.2019.ru.dyn)])/cumsum(covid.2019.ru.dyn$i[49:nrow(covid.2019.ru.dyn)]), 
col=2)

lines(
covid.2019.ru.dyn$TIME[49:nrow(covid.2019.ru.dyn)], 
sqrt(
(cumsum(covid.2019.ru.dyn$d[49:nrow(covid.2019.ru.dyn)])/(cumsum(covid.2019.ru.dyn$r[49:nrow(covid.2019.ru.dyn)]) + cumsum(covid.2019.ru.dyn$d[49:nrow(covid.2019.ru.dyn)]))) *
(cumsum(covid.2019.ru.dyn$d[49:nrow(covid.2019.ru.dyn)])/cumsum(covid.2019.ru.dyn$i[49:nrow(covid.2019.ru.dyn)]))
), 
lty=3,
col=2)

legend("topright",
lty=c(1,1,3,3),
col=c(1,2,2,1),
bty="n",
legend=c(
	paste("(1) Closed cases : ", round(100*cumsum(covid.2019.ru.dyn$d)[nrow(covid.2019.ru.dyn)]/(cumsum(covid.2019.ru.dyn$r)[nrow(covid.2019.ru.dyn)] + cumsum(covid.2019.ru.dyn$d)[nrow(covid.2019.ru.dyn)])
		, 2), "% for now", sep=""),
	paste("(2) All cases : ", round(100*cumsum(covid.2019.ru.dyn$d)[nrow(covid.2019.ru.dyn)]/cumsum(covid.2019.ru.dyn$i)[nrow(covid.2019.ru.dyn)]
		, 2), "% for now", sep=""),
	paste("Geometric mean of (1) and (2) : ",
		round(100 * sqrt(
		(cumsum(covid.2019.ru.dyn$d)[nrow(covid.2019.ru.dyn)]/(cumsum(covid.2019.ru.dyn$r)[nrow(covid.2019.ru.dyn)] + cumsum(covid.2019.ru.dyn$d)[nrow(covid.2019.ru.dyn)])) *
		(cumsum(covid.2019.ru.dyn$d)[nrow(covid.2019.ru.dyn)]/cumsum(covid.2019.ru.dyn$i)[nrow(covid.2019.ru.dyn)])
		), 2), "% for now", sep=""),
	paste("Dead / geom. mean of new cases and recovered : ", round(
		100*
		tail(
		covid.2019.ru.dyn$d[49:nrow(covid.2019.ru.dyn)] /
		sqrt(
		covid.2019.ru.dyn$r[49:nrow(covid.2019.ru.dyn)]
		*
		covid.2019.ru.dyn$i[49:nrow(covid.2019.ru.dyn)]
		), 1), 2), "% for now", sep="")
	)
)

axis.POSIXct(1, 
at=seq(min(covid.2019.ru.dyn$TIME), max(covid.2019.ru.dyn$TIME), by="week"), 
format = "%Y-%m-%d", 
las=2)
axis(2)

dev.off()

################################################################
# Density maps

ru.shape <- readOGR("../misc/ESRI.shapefile")

################################################################
# Map / regions as areas / colour intensity proportional
# to the total number of cases;

png("../plots/10.COVID.2019.map.density.regions.png", height=750, width=1000, res=120, pointsize=10)
par(fg="white", bg=rgb(0,.1,.2,1))

plot(ru.shape[order(ru.shape$LOCUS),], xlim=c(20,180), col="white", border="white")
plot(ru.shape[order(ru.shape$LOCUS),], xlim=c(20,180), 
col=rgb(.3,0,0,(log10(pop.derived$DETECTED)/max(log10(pop.derived$DETECTED)))^4), 
border=rgb(.3,0,0,((log10(pop.derived$DETECTED)/max(log10(pop.derived$DETECTED)))^4)/4), 
add=TRUE)

mtext(paste("Total COVID-2019 cases, as of", tail(RU.TIME, 1), "\nThe lighter, the less"), 
side=1, line=1) 
mtext("Russian Federation", font=2, cex=1.2, side=3, line=0)

dev.off()

################################################################
# Map / regions as areas / colour intensity proportional
# to the total number of cases per 100K inhabitants;

png("../plots/11.COVID.2019.map.density.regions.per_100K.png", height=750, width=1000, res=120, pointsize=10)
par(fg="white", bg=rgb(0,.1,.2,1))

plot(ru.shape[order(ru.shape$LOCUS),], xlim=c(20,180), col="white", border="white")
plot(ru.shape[order(ru.shape$LOCUS),], xlim=c(20,180), 
col=rgb(.3,0,0,(pop.derived$DETECTED.100K/max(pop.derived$DETECTED.100K))), 
border=rgb(.3,0,0,((pop.derived$DETECTED.100K/max(pop.derived$DETECTED.100K)))/4), 
add=TRUE)

mtext(paste("Total COVID-2019 cases per 100K, as of", tail(RU.TIME, 1), "\nThe lighter, the less"), 
side=1, line=1) 
mtext("Russian Federation", font=2, cex=1.2, side=3, line=0)

dev.off()

################################################################
# Map / regions as areas / colour intensity proportional
# to the number of cases registered within past seven days
# per 100K inhabitants;

png("../plots/12.COVID.2019.map.density.regions.7_days_increment.per_100K.png", height=750, width=1000, res=120, pointsize=10)
par(fg="white", bg=rgb(0,.1,.2,1))

plot(ru.shape[order(ru.shape$LOCUS),], xlim=c(20,180), col="white", border="white")
plot(ru.shape[order(ru.shape$LOCUS),], xlim=c(20,180), 
col=rgb(.3,0,0,(pop.derived$DETECTED.7.100K/max(pop.derived$DETECTED.7.100K))), 
border=rgb(.3,0,0,((pop.derived$DETECTED.7.100K/max(pop.derived$DETECTED.7.100K)))/4), 
add=TRUE)

mtext(paste("COVID-2019 new cases over past 7 days per 100K, as of", tail(RU.TIME, 1), "\nThe lighter, the less"), 
side=1, line=1) 
mtext("Russian Federation", font=2, cex=1.2, side=3, line=0)

dev.off()

################################################################
# Map / regions as areas / colour intensity proportional
# to the total number of active cases per 100K inhabitants;

png("../plots/13.COVID.2019.map.density.regions.active.per_100K.png", height=750, width=1000, res=120, pointsize=10)
par(fg="white", bg=rgb(0,.1,.2,1))

plot(ru.shape[order(ru.shape$LOCUS),], xlim=c(20,180), col="white", border="white")
plot(ru.shape[order(ru.shape$LOCUS),], xlim=c(20,180), 
col=rgb(.3,0,0,(pop.derived$ACTIVE.100K/max(pop.derived$ACTIVE.100K))), 
border=rgb(.3,0,0,((pop.derived$ACTIVE.100K/max(pop.derived$ACTIVE.100K)))/4), 
add=TRUE)

mtext(paste("COVID-2019 active cases per 100K, as of", tail(RU.TIME, 1), "\nThe lighter, the less"), 
side=1, line=1) 
mtext("Russian Federation", font=2, cex=1.2, side=3, line=0)

dev.off()

################################################################
# Map / regions as areas / colour intensity proportional
# to the total number of active cases per 100K inhabitants;

png("../plots/14.COVID.2019.map.density.regions.i.7.var.rmean.7.png", height=750, width=1000, res=120, pointsize=10)
par(fg="white", bg=rgb(0,.1,.2,1))

plot(ru.shape[order(ru.shape$LOCUS),], xlim=c(20,180), col="white", border="white")
plot(ru.shape[order(ru.shape$LOCUS),], xlim=c(20,180), 
col=rgb(.3,0,0,(1-pop.derived$i.7.var.rmean.7/max(pop.derived$i.7.var.rmean.7))^8), 
border=rgb(.3,0,0,(((1-(pop.derived$i.7.var.rmean.7/max(pop.derived$i.7.var.rmean.7)))^8)/4)), 
add=TRUE)

mtext(paste("COVID-2019 mean excessive smoothing over past 7 days, as of", tail(RU.TIME, 1), "\nThe lighter, the better"), 
side=1, line=1) 
mtext("Russian Federation", font=2, cex=1.2, side=3, line=0)

dev.off()

################################################################

png("../plots/41.COVID.2019.hist.i.7.var.rmean.7.png", height=750, width=1000, res=120, pointsize=10)
par(mar=c(6,5,4,5)+.1, mgp=c(1.7,.5,-.5))

hist.ad_hoc <- hist(pop.derived$i.7.var.rmean.7, 
breaks=seq(0, ceiling(max(pop.derived$i.7.var.rmean.7)/.005)*.005, .005),
col=8,
main=paste("Russian Federation /", tail(RU.TIME, 1)),
xlab="COVID-2019 mean excessive smoothing over past 7 days"
)

rug(pop.derived$i.7.var.rmean.7, col=rgb(0,0,0,.4))

abline(v=summary(pop.derived$i.7.var.rmean.7)[c(2, 5)], lty=3, col=3)
abline(v=summary(pop.derived$i.7.var.rmean.7)[3], lty=5, col=3)
abline(v=summary(pop.derived$i.7.var.rmean.7)[4], lty=5, col=2)
abline(v=(median(pop.derived$i.7.var.rmean.7) + c(-1,1)*1.5*IQR((pop.derived$i.7.var.rmean.7))), lty=3, col=4)

axis(1, at=seq(0, (ceiling(max(pop.derived$i.7.var.rmean.7)/.01)*.01), .01), labels=FALSE, tcl=-.25)
axis(1, at=seq(0, (floor(max(pop.derived$i.7.var.rmean.7)/.1)*.1), .1), labels=FALSE, tcl=-.5)
axis(2, at=1:max(hist.ad_hoc$counts), labels=FALSE, tcl=-.25)

legend(
"topright", bty="n",
lty=c(5, 5, 3, 3),
lwd=1.5,
col=c(2, 3, 3, 4),
legend=c(
paste("Mean (", round(summary(pop.derived$i.7.var.rmean.7)[4], 4), ")", sep=""),
paste("Median (", round(summary(pop.derived$i.7.var.rmean.7)[3], 4), ")", sep=""),
paste("1st and 3rd Quartiles (", round(summary(pop.derived$i.7.var.rmean.7)[2], 4), " and ", round(summary(pop.derived$i.7.var.rmean.7)[5], 4), ")", sep=""),
paste("Median +/- 1.5 IQR (", round(median(pop.derived$i.7.var.rmean.7) - 1.5*IQR((pop.derived$i.7.var.rmean.7)), 4), " and ", round(median(pop.derived$i.7.var.rmean.7) + 1.5*IQR((pop.derived$i.7.var.rmean.7)), 4), ")", sep="")
)
)

dev.off()

png("../plots/42.COVID.2019.boxplot.i.7.var.rmean.7.png", height=750, width=500, res=120, pointsize=10)
par(mar=c(1,5,3,5)+.1, mgp=c(1.7,.5,-.5))

boxplot.ad_hoc <- boxplot(pop.derived$i.7.var.rmean.7, pch=20, cex=.7, col=8, frame=FALSE,
main=paste("Russian Federation /", tail(RU.TIME, 1)),
ylab="COVID-2019 mean excessive smoothing over past 7 days")
text(x=1,
y=tail(pop.derived[order(pop.derived$i.7.var.rmean.7),c("LOCUS","i.7.var.rmean.7")]$i.7.var.rmean.7, length(boxplot.ad_hoc$out)),
labels=tail(pop.derived[order(pop.derived$i.7.var.rmean.7),c("LOCUS","i.7.var.rmean.7")]$LOCUS, length(boxplot.ad_hoc$out)),
pos=c(2,4),
cex=.7)

dev.off()

################################################################
# Regions barplot;

png("../plots/15.COVID.2019.barplot.regions.png", height=1200, width=750, res=120, pointsize=10)
par(mar=c(3.5,6,4,1)+.1, mgp=c(1.7,.5,-.5), cex.axis=.6)

barplot(
height = pop.derived[order(pop.derived$DETECTED),]$DETECTED, 
names.arg = pop.derived[order(pop.derived$DETECTED),]$LOCUS, 
horiz=TRUE,
ylab="", 
xlab=paste("Total COVID-2019 cases, as of",max(covid.2019.ru.dyn$TIME)), 
main="Russian Federation",
las=1, 
axes=FALSE)

axis(1, at = seq(0, 4*10^5, 1*10^5), labels=c("0", paste(seq(100, 400, 100), "K", sep="")))
axis(3, at = seq(0, 4*10^5, 1*10^5), labels=c("0", paste(seq(100, 400, 100), "K", sep="")))

dev.off()

################################################################
# Regions barplot logarithmic;

png("../plots/16.COVID.2019.barplot.regions.log.10.png", height=1200, width=750, res=120, pointsize=10)
par(mar=c(3.5,6,4,1)+.1, mgp=c(1.7,.5,-.5), cex.axis=.6)

barplot(
height = log10(pop.derived[order(pop.derived$DETECTED),]$DETECTED), 
names.arg = pop.derived[order(pop.derived$DETECTED),]$LOCUS, 
horiz=TRUE,
ylab="", 
xlab=paste("Total COVID-2019 cases, as of",max(covid.2019.ru.dyn$TIME)), 
main="Russian Federation",
las=1, 
axes=FALSE)

axis(1, at=log10(c(1,10,100,1000,10000,100000,1000000)), labels=c(1,10,100,"1K","10K","100K","1M"))
axis(1, at=log10(c(1:9, seq(10,100,10), seq(200,1000,100), seq(2000,10000,1000), seq(20000,100000,10000), seq(200000,1000000,100000), seq(2000000,10000000,1000000))), labels=FALSE)

axis(3, at=log10(c(1,10,100,1000,10000,100000,1000000)), labels=c(1,10,100,"1K","10K","100K","1M"))
axis(3, at=log10(c(1:9, seq(10,100,10), seq(200,1000,100), seq(2000,10000,1000), seq(20000,100000,10000), seq(200000,1000000,100000), seq(2000000,10000000,1000000))), labels=FALSE)

dev.off()

################################################################
# Regions barplot cases per 100K;

png("../plots/17.COVID.2019.barplot.regions.per_100K.png", height=1200, width=750, res=120, pointsize=10)
par(mar=c(3.5,6,4,1)+.1, mgp=c(1.7,.5,-.5), cex.axis=.6)

barplot(
height = pop.derived[order(pop.derived$DETECTED.100K),]$DETECTED.100K, 
names.arg = pop.derived[order(pop.derived$DETECTED.100K),]$LOCUS, 
horiz=TRUE,
ylab="", 
xlab=paste("Total COVID-2019 cases per 100K, as of",max(covid.2019.ru.dyn$TIME)), 
main="Russian Federation",
las=1)

axis(3)

dev.off()

################################################################
# Regions barplot active cases per 100K;

png("../plots/18.COVID.2019.barplot.regions.per_100K.active.png", height=1200, width=750, res=120, pointsize=10)
par(mar=c(3.5,6,4,1)+.1, mgp=c(1.7,.5,-.5), cex.axis=.6)

barplot(
height = pop.derived[order(pop.derived$ACTIVE.100K),]$ACTIVE.100K, 
names.arg = pop.derived[order(pop.derived$ACTIVE.100K),]$LOCUS, 
horiz=TRUE,
ylab="", 
xlab=paste("Active COVID-2019 cases per 100K, as of",max(covid.2019.ru.dyn$TIME)), 
main="Russian Federation",
las=1)

axis(3)

dev.off()

################################################################
# Regions barplot cases detected for the past 7 days per 100K;

png("../plots/19.COVID.2019.barplot.regions.per_100K.detected_for_the_past_7d.png", height=1200, width=750, res=120, pointsize=10)
par(mar=c(3.5,6,4,1)+.1, mgp=c(1.7,.5,-.5), cex.axis=.6, cex.lab=.9)

barplot(
height = pop.derived[order(pop.derived$DETECTED.7.100K),]$DETECTED.7.100K, 
names.arg = pop.derived[order(pop.derived$DETECTED.7.100K),]$LOCUS, 
horiz=TRUE,
ylab="", 
xlab=paste("Sum of COVID-2019 cases detected for the past 7 days per 100K, as of",max(covid.2019.ru.dyn$TIME)), 
main="Russian Federation",
las=1)

axis(3)

dev.off()

################################################################
################################################################
## Regions
################################################################
################################################################

################################################################
# Increments
################################################################

################################################################
# Detected

for(i in 1:length(covid.2019.ru.dyn.tot.primary)){

png(file = paste("../plots/regions/increments/i/COVID.2019.momentary.", gsub(" ", "_", names(covid.2019.ru.dyn.tot.primary)[i]), ".i.png", sep=""), height=750, width=1000, res=120, pointsize=10)
par(mar=c(6,5,4,5)+.1)

plot(
covid.2019.ru.dyn.tot.primary[[i]]$TIME,
covid.2019.ru.dyn.tot.primary[[i]]$i,
type="h",
main=names(covid.2019.ru.dyn.tot.primary)[i],
xlab="",
ylab="COVID-19 cases detected per day", 
col="darkred",
lwd=1.5,
axes=FALSE)

abline(v = seq(min(covid.2019.ru.dyn.tot.primary[[i]]$TIME), max(covid.2019.ru.dyn.tot.primary[[i]]$TIME), by = "month"), lty = 3, col = 8)

axis(2)

axis.POSIXct(1,
at = seq(min(covid.2019.ru.dyn.tot.primary[[i]]$TIME), max(covid.2019.ru.dyn.tot.primary[[i]]$TIME), by = "week"),
format = "%Y-%m-%d",
las = 2)

dev.off()

}

################################################################
# Deaths

for(i in 1:length(covid.2019.ru.dyn.tot.primary)){

png(file = paste("../plots/regions/increments/d/COVID.2019.momentary.", gsub(" ", "_", names(covid.2019.ru.dyn.tot.primary)[i]), ".d.png", sep=""), height=750, width=1000, res=120, pointsize=10)
par(mar=c(6,5,4,5)+.1)

plot(
covid.2019.ru.dyn.tot.primary[[i]]$TIME,
covid.2019.ru.dyn.tot.primary[[i]]$d,
type="h",
main=names(covid.2019.ru.dyn.tot.primary)[i],
xlab="",
ylab="COVID-19 deaths reported per day", 
col="black",
lwd=1.5,
axes=FALSE)

abline(v = seq(min(covid.2019.ru.dyn.tot.primary[[i]]$TIME), max(covid.2019.ru.dyn.tot.primary[[i]]$TIME), by = "month"), lty = 3, col = 8)

axis(2)

axis.POSIXct(1,
at = seq(min(covid.2019.ru.dyn.tot.primary[[i]]$TIME), max(covid.2019.ru.dyn.tot.primary[[i]]$TIME), by = "week"),
format = "%Y-%m-%d",
las = 2)

dev.off()

}

################################################################
# Overview
################################################################

################################################################
# Linear

for(i in 1:length(covid.2019.ru.dyn.tot.primary)){

png(file = paste("../plots/regions/linear/COVID.2019.cumulated.linear.", gsub(" ", "_", names(covid.2019.ru.dyn.tot.primary)[i]), ".png", sep=""), height=750, width=1000, res=120, pointsize=10)
par(mar=c(6,5,4,5)+.1, lwd=2)

plot(covid.2019.ru.dyn.tot.primary[[i]]$TIME, cumsum(covid.2019.ru.dyn.tot.primary[[i]]$i), 
type="n", 
main=paste("Russian Federation /", names(covid.2019.ru.dyn.tot.primary)[i]),
xlab="",
ylab="COVID-2019 cases detected",
axes=FALSE
)

# Shadows for all regions;
for(j in 1:length(covid.2019.ru.dyn.tot.primary)){
 lines(covid.2019.ru.dyn.tot.primary[[j]]$TIME, cumsum(covid.2019.ru.dyn.tot.primary[[j]]$i), lwd=1.5, col=rgb(0,0,0,.15))
}

# Increments detcted;
lines(covid.2019.ru.dyn.tot.primary[[i]]$TIME, covid.2019.ru.dyn.tot.primary[[i]]$i, type="h", col="darkred")

# Cumulated detected;
lines(covid.2019.ru.dyn.tot.primary[[i]]$TIME, cumsum(covid.2019.ru.dyn.tot.primary[[i]]$i), col="white", lwd=5)
lines(covid.2019.ru.dyn.tot.primary[[i]]$TIME, cumsum(covid.2019.ru.dyn.tot.primary[[i]]$i), col="darkred", lwd=2)

# Active;
lines(covid.2019.ru.dyn.tot.primary[[i]]$TIME, cumsum(covid.2019.ru.dyn.tot.primary[[i]]$i)-(cumsum(covid.2019.ru.dyn.tot.primary[[i]]$r)+cumsum(covid.2019.ru.dyn.tot.primary[[i]]$d)), col="white", lwd=5)
lines(covid.2019.ru.dyn.tot.primary[[i]]$TIME, cumsum(covid.2019.ru.dyn.tot.primary[[i]]$i)-(cumsum(covid.2019.ru.dyn.tot.primary[[i]]$r)+cumsum(covid.2019.ru.dyn.tot.primary[[i]]$d)), col=2, lwd=2)

# Cumulated recovered;
lines(covid.2019.ru.dyn.tot.primary[[i]]$TIME, cumsum(covid.2019.ru.dyn.tot.primary[[i]]$r), col="white", lwd=5)
lines(covid.2019.ru.dyn.tot.primary[[i]]$TIME, cumsum(covid.2019.ru.dyn.tot.primary[[i]]$r), col="darkgreen", lwd=2)

# Cumulated deaths;
lines(covid.2019.ru.dyn.tot.primary[[i]]$TIME, cumsum(covid.2019.ru.dyn.tot.primary[[i]]$d), col="white", lwd=5)
lines(covid.2019.ru.dyn.tot.primary[[i]]$TIME, cumsum(covid.2019.ru.dyn.tot.primary[[i]]$d), col=1, lwd=2)

legend(
"topleft",
lty=1,
lwd=2,
col=c("darkred","red","darkgreen","black"),
legend=c("Total cases (vertical bars = new ones)","Active cases","Recovered","Deceased"),
bty="n"
)

# Grid for months;
abline(v = seq(min(covid.2019.ru.dyn.tot.primary[[i]]$TIME), max(covid.2019.ru.dyn.tot.primary[[i]]$TIME), by = "month"), lty = 3, col = 8, lwd=.75)

axis(2)

axis.POSIXct(1,
at = seq(min(covid.2019.ru.dyn.tot.primary[[i]]$TIME), max(covid.2019.ru.dyn.tot.primary[[i]]$TIME), by = "week"),
format = "%Y-%m-%d",
las = 2)

dev.off()

}

################################################################
# Y-logarithmic

for(i in 1:length(covid.2019.ru.dyn.tot.primary)){

png(file = paste("../plots/regions/COVID.2019.cumulated.log10.", gsub(" ", "_", names(covid.2019.ru.dyn.tot.primary)[i]), ".png", sep=""), height=750, width=1000, res=120, pointsize=10)
par(mar=c(6,5,4,5)+.1, lwd=2)

plot(covid.2019.ru.dyn$TIME, log10(cumsum(covid.2019.ru.dyn$i)), 
type="n", 
ylim=c(0, log10(tail(cumsum(covid.2019.ru.dyn$i), 1))),
main=paste("Russian Federation /", names(covid.2019.ru.dyn.tot.primary)[i]),
xlab="",
ylab="COVID-2019 cases detected (logarithmic scale)",
axes=FALSE
)

# Shadows for all regions;
for(j in 1:length(covid.2019.ru.dyn.tot.primary)){
 lines(covid.2019.ru.dyn.tot.primary[[j]]$TIME, log10(cumsum(covid.2019.ru.dyn.tot.primary[[j]]$i)), lwd=1.5, col=rgb(0,0,0,.15))
}

# Increments detcted;
lines(covid.2019.ru.dyn.tot.primary[[i]]$TIME, log10(covid.2019.ru.dyn.tot.primary[[i]]$i), type="h", col="darkred")

# Cumulated detected;
lines(covid.2019.ru.dyn.tot.primary[[i]]$TIME, log10(cumsum(covid.2019.ru.dyn.tot.primary[[i]]$i)), col="white", lwd=5)
lines(covid.2019.ru.dyn.tot.primary[[i]]$TIME, log10(cumsum(covid.2019.ru.dyn.tot.primary[[i]]$i)), col="darkred", lwd=2)

# Active;
lines(covid.2019.ru.dyn.tot.primary[[i]]$TIME, log10(cumsum(covid.2019.ru.dyn.tot.primary[[i]]$i)-(cumsum(covid.2019.ru.dyn.tot.primary[[i]]$r)+cumsum(covid.2019.ru.dyn.tot.primary[[i]]$d))), col="white", lwd=5)
lines(covid.2019.ru.dyn.tot.primary[[i]]$TIME, log10(cumsum(covid.2019.ru.dyn.tot.primary[[i]]$i)-(cumsum(covid.2019.ru.dyn.tot.primary[[i]]$r)+cumsum(covid.2019.ru.dyn.tot.primary[[i]]$d))), col=2, lwd=2)

# Cumulated recovered;
lines(covid.2019.ru.dyn.tot.primary[[i]]$TIME, log10(cumsum(covid.2019.ru.dyn.tot.primary[[i]]$r)), col="white", lwd=5)
lines(covid.2019.ru.dyn.tot.primary[[i]]$TIME, log10(cumsum(covid.2019.ru.dyn.tot.primary[[i]]$r)), col="darkgreen", lwd=2)

# Cumulated deaths;
lines(covid.2019.ru.dyn.tot.primary[[i]]$TIME, log10(cumsum(covid.2019.ru.dyn.tot.primary[[i]]$d)), col="white", lwd=5)
lines(covid.2019.ru.dyn.tot.primary[[i]]$TIME, log10(cumsum(covid.2019.ru.dyn.tot.primary[[i]]$d)), col=1, lwd=2)

abline(h=log10(50), lty=3, lwd=.75)

legend(
"topleft",
lty=1,
lwd=2,
col=c("darkred","red","darkgreen","black"),
legend=c("Total cases (vertical bars = new ones)","Active cases","Recovered","Deceased"),
bty="n"
)

# Grid for months;
abline(v = seq(min(covid.2019.ru.dyn.tot.primary[[i]]$TIME), max(covid.2019.ru.dyn.tot.primary[[i]]$TIME), by = "month"), lty = 3, col = 8, lwd=.75)

axis(2, at=log10(c(1,10,100,1000,10000,100000,1000000)), labels=c("1","10","100","1K","10K","100K","1M"))
axis(2, at=log10(c(1:9, seq(10,100,10), seq(200,1000,100), seq(2000,10000,1000), seq(20000,100000,10000), seq(200000,1000000,100000))), labels=FALSE)

axis.POSIXct(1,
at = seq(min(covid.2019.ru.dyn.tot.primary[[i]]$TIME), max(covid.2019.ru.dyn.tot.primary[[i]]$TIME), by = "week"),
format = "%Y-%m-%d",
las = 2)

dev.off()

}

################################################################
# Excessive smoothing

for(i in 1:length(covid.2019.ru.dyn.tot.derived)){

	png(file = paste("../plots/regions/increments/i.7.var/COVID.2019.momentary.i.7.var.", gsub(" ", "_", names(covid.2019.ru.dyn.tot.primary)[i]), ".png", sep=""), height=750, width=1000, res=120, pointsize=10)
	par(mar=c(6,5,4,5)+.1, lwd=2)

	plot(covid.2019.ru.dyn.tot.derived[[i]]$TIME, covid.2019.ru.dyn.tot.derived[[i]]$i.7.var, 
	type="n", 
	ylim=c(0, 5),
	main=paste("Russian Federation /", names(covid.2019.ru.dyn.tot.derived)[i]),
	xlab="",
	ylab="COVID-2019 new cases detected, residuals vs. 7-days rolling mean",
	axes=FALSE
	)

	# Shadows for all regions;
	for(j in 1:length(covid.2019.ru.dyn.tot.derived)){
		lines(covid.2019.ru.dyn.tot.derived[[j]]$TIME, covid.2019.ru.dyn.tot.derived[[j]]$i.7.var, lwd=1.5, col=rgb(0,0,0,.1))
		}

	# Excessive smoothing index;
	lines(covid.2019.ru.dyn.tot.derived[[i]]$TIME, covid.2019.ru.dyn.tot.derived[[i]]$i.7.var, col="white", lwd=5)
	lines(covid.2019.ru.dyn.tot.derived[[i]]$TIME, covid.2019.ru.dyn.tot.derived[[i]]$i.7.var, col="darkred", lwd=2)

	# Grid for months;
	abline(v = seq(min(covid.2019.ru.dyn.tot.primary[[i]]$TIME), max(covid.2019.ru.dyn.tot.primary[[i]]$TIME), by = "month"), lty = 3, col = 8, lwd=.75)

	axis(2)

	axis.POSIXct(1,
	at = seq(min(covid.2019.ru.dyn.tot.primary[[i]]$TIME), max(covid.2019.ru.dyn.tot.primary[[i]]$TIME), by = "week"),
	format = "%Y-%m-%d",
	las = 2)

	dev.off()

	}

################################################################
# RosPotrebNadzor reproduction number

for(i in 1:length(covid.2019.ru.dyn.tot.derived)){

	png(file = paste("../plots/regions/increments/R.RPN/COVID.2019.momentary.R.RPN.", gsub(" ", "_", names(covid.2019.ru.dyn.tot.primary)[i]), ".png", sep=""), height=750, width=1000, res=120, pointsize=10)
	par(mar=c(6,5,4,5)+.1, lwd=2)

	plot(covid.2019.ru.dyn.tot.derived[[i]]$TIME, covid.2019.ru.dyn.tot.derived[[i]]$R.RPN, 
	type="n", 
	ylim=c(0, 7),
	main=paste("Russian Federation /", names(covid.2019.ru.dyn.tot.derived)[i]),
	xlab="",
	ylab="COVID-2019 : RosPotrebNadzor's Reproduction Number",
	axes=FALSE
	)

	# Shadows for all regions;
	for(j in 1:length(covid.2019.ru.dyn.tot.derived)){
		lines(covid.2019.ru.dyn.tot.derived[[j]]$TIME, covid.2019.ru.dyn.tot.derived[[j]]$R.RPN, lwd=1.5, col=rgb(0,0,0,.1))
		}

	abline(h=1, lwd=2, col="white")
	abline(h=1, lwd=.75)

	# Cumulated detected;
	lines(covid.2019.ru.dyn.tot.derived[[i]]$TIME, covid.2019.ru.dyn.tot.derived[[i]]$R.RPN, col="white", lwd=5)
	lines(covid.2019.ru.dyn.tot.derived[[i]]$TIME, covid.2019.ru.dyn.tot.derived[[i]]$R.RPN, col="darkred", lwd=2)

	# Grid for months;
	abline(v = seq(min(covid.2019.ru.dyn.tot.primary[[i]]$TIME), max(covid.2019.ru.dyn.tot.primary[[i]]$TIME), by = "month"), lty = 3, col = 8, lwd=.75)

	axis(2)

	axis.POSIXct(1,
	at = seq(min(covid.2019.ru.dyn.tot.primary[[i]]$TIME), max(covid.2019.ru.dyn.tot.primary[[i]]$TIME), by = "week"),
	format = "%Y-%m-%d",
	las = 2)

	dev.off()

	}

################################################################
# St. Petersburg newly detected increments with 7 day rolling mean

png(file = "../plots/90.COVID.2019.SPb.i_smooth.png", height=750, width=1000, res=120, pointsize=10)
par(mar=c(6,5,4,5)+.1)

plot(covid.2019.ru.dyn.tot.derived[[68]]$TIME, covid.2019.ru.dyn.tot.derived[[68]]$i, 
type="n", 
main=paste("Russian Federation /", names(covid.2019.ru.dyn.tot.derived)[68]),
xlab="",
ylab="COVID-2019 cases detected",
axes=FALSE
)

# Increments detcted;
lines(covid.2019.ru.dyn.tot.derived[[68]]$TIME, covid.2019.ru.dyn.tot.derived[[68]]$i, type="h", col="darkred")

# 7-days rolling mean;
lines(covid.2019.ru.dyn.tot.derived[[68]]$TIME, covid.2019.ru.dyn.tot.derived[[68]]$i.7, col="white", lwd=3)
lines(covid.2019.ru.dyn.tot.derived[[68]]$TIME, covid.2019.ru.dyn.tot.derived[[68]]$i.7, col="red", lwd=1.5)

# Grid for months;
abline(v = seq(min(covid.2019.ru.dyn.tot.primary[[68]]$TIME), max(covid.2019.ru.dyn.tot.primary[[68]]$TIME), by = "month"), lty = 3, col = 8, lwd=.75)

axis(2)

axis.POSIXct(1,
at = seq(min(covid.2019.ru.dyn.tot.primary[[68]]$TIME), max(covid.2019.ru.dyn.tot.primary[[68]]$TIME), by = "week"),
format = "%Y-%m-%d",
las = 2)

dev.off()

################################################################
# St. Petersburg deaths increments with 7 day rolling mean

png(file = "../plots/91.COVID.2019.SPb.d_smooth.png", height=750, width=1000, res=120, pointsize=10)
par(mar=c(6,5,4,5)+.1)

plot(covid.2019.ru.dyn.tot.derived[[68]]$TIME, covid.2019.ru.dyn.tot.derived[[68]]$d, 
type="n", 
main=paste("Russian Federation /", names(covid.2019.ru.dyn.tot.derived)[68]),
xlab="",
ylab="COVID-2019 deaths",
axes=FALSE
)

# Increments deaths;
lines(covid.2019.ru.dyn.tot.derived[[68]]$TIME, covid.2019.ru.dyn.tot.derived[[68]]$d, type="h", col="black")

# 7-days rolling mean;
lines(covid.2019.ru.dyn.tot.derived[[68]]$TIME, covid.2019.ru.dyn.tot.derived[[68]]$d.7, col="white", lwd=3)
lines(covid.2019.ru.dyn.tot.derived[[68]]$TIME, covid.2019.ru.dyn.tot.derived[[68]]$d.7, col="red", lwd=1.5)

# Grid for months;
abline(v = seq(min(covid.2019.ru.dyn.tot.primary[[68]]$TIME), max(covid.2019.ru.dyn.tot.primary[[68]]$TIME), by = "month"), lty = 3, col = 8, lwd=.75)

axis(2)

axis.POSIXct(1,
at = seq(min(covid.2019.ru.dyn.tot.primary[[68]]$TIME), max(covid.2019.ru.dyn.tot.primary[[68]]$TIME), by = "week"),
format = "%Y-%m-%d",
las = 2)

dev.off()

################################################################
# St. Petersburg recovered / detected ratio

png(file = "../plots/92.COVID.2019.SPb.ratio_ir.png", height=750, width=1000, res=120, pointsize=10)
par(mar=c(6,5,4,5)+.1)

plot(covid.2019.ru.dyn.tot.derived[[68]]$TIME, covid.2019.ru.dyn.tot.derived[[68]]$r / covid.2019.ru.dyn.tot.derived[[68]]$i, 
type="n", 
main=paste("Russian Federation /", names(covid.2019.ru.dyn.tot.derived)[68]),
xlab="",
ylab="Ratio of COVID-2019 cases recovered to detected",
axes=FALSE
)

# Grid for months;
abline(v = seq(min(covid.2019.ru.dyn.tot.primary[[68]]$TIME), max(covid.2019.ru.dyn.tot.primary[[68]]$TIME), by = "month"), lty = 3, col = 8, lwd=.75)
abline(h = .5, lty=3)

text(covid.2019.ru.dyn.tot.primary[[68]]$TIME[14], .5, labels="y = 0.5", pos = 3)

lines(covid.2019.ru.dyn.tot.derived[[68]]$TIME, covid.2019.ru.dyn.tot.derived[[68]]$r / covid.2019.ru.dyn.tot.derived[[68]]$i)

axis(2)

axis.POSIXct(1,
at = seq(min(covid.2019.ru.dyn.tot.primary[[68]]$TIME), max(covid.2019.ru.dyn.tot.primary[[68]]$TIME), by = "week"),
format = "%Y-%m-%d",
las = 2)

dev.off()

################################################################
################################################################
# Export to XLSX files in RosStat format
################################################################
################################################################

# Creating empty objects to collect COVID-19 cases;

CONFIRMED.df <- NULL
RECOVERED.df <- NULL
DEATHS.df <- NULL

# Collecting COVID-19 cases by regions into Regions x Dates data frames;

for(i in 1:length(covid.2019.ru.dyn.tot.primary)){
CONFIRMED.df <- rbind.data.frame(CONFIRMED.df, cbind.data.frame(pop$REGION.RosStat[i], t(covid.2019.ru.dyn.tot.primary[[i]]$i)))
RECOVERED.df <- rbind.data.frame(RECOVERED.df, cbind.data.frame(pop$REGION.RosStat[i], t(covid.2019.ru.dyn.tot.primary[[i]]$r)))
DEATHS.df <- rbind.data.frame(DEATHS.df, cbind.data.frame(pop$REGION.RosStat[i], t(covid.2019.ru.dyn.tot.primary[[i]]$d)))
}

# Assigning column names to data frames;

colnames(CONFIRMED.df) <- c("REGION", as.character(covid.2019.ru.dyn.tot.primary[[1]]$TIME))
colnames(RECOVERED.df) <- c("REGION", as.character(covid.2019.ru.dyn.tot.primary[[1]]$TIME))
colnames(DEATHS.df) <- c("REGION", as.character(covid.2019.ru.dyn.tot.primary[[1]]$TIME))

# Sorting data frames RosStat style;

CONFIRMED.df <- CONFIRMED.df[order(CONFIRMED.df$REGION),]
RECOVERED.df <- RECOVERED.df[order(RECOVERED.df$REGION),]
DEATHS.df <- DEATHS.df[order(DEATHS.df$REGION),]

# Removing the previous version of the XLSX file;

file.remove("../data/xlsx/data.xlsx")

# Printing the new XLSX file;

write.xlsx(CONFIRMED.df, file = "../data/xlsx/data.xlsx", sheetName = "CONFIRMED", row.names = FALSE)
write.xlsx(RECOVERED.df, file = "../data/xlsx/data.xlsx", sheetName = "RECOVERED", row.names = FALSE, append = TRUE)
write.xlsx(DEATHS.df, file = "../data/xlsx/data.xlsx", sheetName = "DEATHS", row.names = FALSE, append = TRUE)

################################################################
################################################################
# Console output
################################################################
################################################################

covid.2019.ru.dyn.tot.primary.SPb <- cbind.data.frame(
		tail(covid.2019.ru.dyn.tot.primary[[68]], 10),
		tail(
			cumsum(covid.2019.ru.dyn.tot.primary[[68]]$i) - 
			(cumsum(covid.2019.ru.dyn.tot.primary[[68]]$r) + 
			cumsum(covid.2019.ru.dyn.tot.primary[[68]]$d)), 10)
	)

colnames(covid.2019.ru.dyn.tot.primary.SPb) <- c(colnames(covid.2019.ru.dyn.tot.primary[[68]]), "a")

print(covid.2019.ru.dyn.tot.primary.SPb)
