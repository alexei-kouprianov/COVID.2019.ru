# setwd("/home/tinea/Documents/H_et_S/Projects/github/COVID.2019.ru/scripts/")

increment <- read.table("../downloads/increment.txt", h=TRUE, sep="\t")
increment$TIME <- strptime(increment$TIMESTAMP, "%Y-%m-%d %H:%M:%S")
increment$REGION <- as.character(increment$REGION)
increment$REGION <- factor(increment$REGION, levels=as.character(pop$REGION.INCR))

incr.ls <- NULL
incr.ls <- as.list(incr.ls)

for(i in 1:length(levels(increment$REGION))){
	incr.ls [[i]] <- cbind.data.frame(
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

save.image()
