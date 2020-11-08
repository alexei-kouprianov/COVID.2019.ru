# setwd("/home/tinea/Documents/H_et_S/Projects/github/COVID.2019.ru/scripts/")

pop <- read.table("../misc/population.txt", h=TRUE, sep="\t")
increment <- read.table("../downloads/increment.txt", h=TRUE, sep="\t")
increment$TIME <- strptime(increment$TIMESTAMP, "%Y-%m-%d %H:%M:%S")
increment$REGION <- as.character(increment$REGION)
increment$REGION <- factor(increment$REGION, levels=as.character(pop$REGION.INCR))

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

write_json(covid.2019.ru.dyn.tot.primary, "../data/primary_dataset_backup.json")

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

DETECTED <- NULL

for(i in 1:length(covid.2019.ru.dyn.tot.primary[[i]]$i)){
DETECTED <- c(DETECTED, sum(covid.2019.ru.dyn.tot.primary[[i]]$i))
}

DETECTED.7 <- NULL

for(i in 1:length(covid.2019.ru.dyn.tot.primary)){
DETECTED.7 <- c(DETECTED.7, sum(tail(covid.2019.ru.dyn.tot.primary[[i]]$i, 7)))
}

ACTIVE <- NULL

for(i in 1:length(covid.2019.ru.dyn.tot.primary[[i]]$i)){
ACTIVE <- c(ACTIVE, (sum(covid.2019.ru.dyn.tot.primary[[i]]$i) - (sum(covid.2019.ru.dyn.tot.primary[[i]]$r) + sum(covid.2019.ru.dyn.tot.primary[[i]]$d))))
}

pop.derived <- cbind.data.frame(pop, DETECTED, DETECTED.7, ACTIVE)

pop.derived$DETECTED.100K <- pop.derived$DETECTED / (pop.derived$POPULATION.20200101 / 100000)
pop.derived$DETECTED.7.100K <- pop.derived$DETECTED.7 / (pop.derived$POPULATION.20200101 / 100000)
pop.derived$ACTIVE.100K <- pop.derived$ACTIVE / (pop.derived$POPULATION.20200101 / 100000)

save.image()

# tail(covid.2019.ru.dyn.tot.primary[[68]], 25)
# plot(covid.2019.ru.dyn.tot.primary[[68]]$TIME, covid.2019.ru.dyn.tot.primary[[68]]$i, type="h")
