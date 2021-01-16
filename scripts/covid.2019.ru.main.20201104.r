# setwd("/home/tinea/Documents/H_et_S/Projects/github/COVID.2019.ru/scripts/")

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
tail(covid.2019.ru.dyn.tot.primary[[68]], 10)
