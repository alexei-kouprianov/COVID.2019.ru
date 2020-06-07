# This script assembles a dataset for Cheliabinsk disaggregated data;
# Requires wgetting Cheliabinsk data and cheliabinsk.extractor.pl for input files;

# Loading data;

ch.EMISS <- read.table("../data/cheliabinsk.EMISS.2020.txt", sep="\t")

AGE <- read.table("../downloads/cheliabinsk.AGE.txt", sep="\t", blank.lines.skip = FALSE)
CONDITION <- read.table("../downloads/cheliabinsk.CONDITION.txt", sep="\t", blank.lines.skip = FALSE)
COUNT <- read.table("../downloads/cheliabinsk.COUNT.txt", sep="\t", blank.lines.skip = FALSE)
COUNT1 <- read.table("../downloads/cheliabinsk.COUNT1.txt", sep="\t", blank.lines.skip = FALSE)
NAME <- read.table("../downloads/cheliabinsk.NAME.txt", sep="\t", blank.lines.skip = FALSE)
RECOVERED <- read.table("../downloads/cheliabinsk.RECOVERED.txt", sep="\t", blank.lines.skip = FALSE)
SOURCE <- read.table("../downloads/cheliabinsk.SOURCE.txt", sep="\t", blank.lines.skip = FALSE)

# Substituting and setting levels;

CONDITION$V1 <- tolower(CONDITION$V1)
CONDITION$V1 <- gsub("^ ", "", CONDITION$V1)
CONDITION$V1 <- gsub(",", "", CONDITION$V1)
CONDITION$V1 <- factor(CONDITION$V1, levels=c(
"клиники нет", 
"легкая", 
"средняя", 
"тяжелая", 
"крайне тяжелая", 
"тяжелая орит", 
"тяжелая ивл", 
"выбыл", 
"уточняется"))

RECOVERED$V1 <- tolower(RECOVERED$V1)
RECOVERED$V1 <- factor(RECOVERED$V1, levels=c(
"выписан", "продолжает лечение", "умер", "выбыл", "уточняется"
))

SOURCE$V1 <- gsub("^ ", "", SOURCE$V1)
SOURCE$V1 <- gsub("^Кон", "кон", SOURCE$V1)
SOURCE$V1 <- gsub("Москв.", "Москва", SOURCE$V1)
SOURCE$V1 <- gsub("^Не ", "не ", SOURCE$V1)
SOURCE$V1 <- gsub("^При", "при", SOURCE$V1)
SOURCE$V1 <- gsub("Респ", "респ", SOURCE$V1)
SOURCE$V1 <- gsub("тен", "тный", SOURCE$V1)
SOURCE$V1 <- gsub("^Уто", "уто", SOURCE$V1)

# Converting AGE to truly numeric;

AGE$V1 <- gsub("10 мес", ".83", AGE$V1, perl=TRUE)
AGE$V1 <- gsub("2 мес", ".17", AGE$V1, perl=TRUE)
AGE$V1 <- gsub("уточняется", "NA", AGE$V1, perl=TRUE)
AGE$V1 <- as.numeric(AGE$V1)

# Building a dataframe;

ch <- cbind.data.frame(NAME, 
AGE, 
CONDITION, 
SOURCE, 
RECOVERED)

colnames(ch) <- c(
"TIMESTAMP", 
"NAME", 
"COUNT.ORIG", 
"COUNT.MINE", 
"AGE", 
"CONDITION", 
"SOURCE", 
"RECOVERED")

# Saving backup data frame;

write.table(ch, "../data/cheliabinsk.current.txt", sep="\t", row.names=FALSE)
# write.table(ch, "../data/cheliabinsk.20200606.txt", sep="\t", row.names=FALSE)

# Subsetting;

ch.deaths <- subset(ch, ch$RECOVERED == "умер")
ch.recovered <- subset(ch, ch$RECOVERED == "выписан")
ch.active <- subset(ch, ch$RECOVERED == "продолжает лечение")

# Control plots;

dir.create("../plots/regions/special/Cheliabinsk/", recursive=TRUE)

png("../plots/regions/special/Cheliabinsk/barplot.Cheliabinsk.terminal_states.png", height=750, width=1000, res=120, pointsize=10)
par(mar=c(10,5,4,2)+.1)

plot.ch.RECOVERED <- plot(ch$RECOVERED, las=2, ylim=c(0,(max(table(ch$RECOVERED))+100)),
main=paste("Челябинск, COVID+, конечные состояния на", Sys.Date()))
text(plot.ch.RECOVERED, table(ch$RECOVERED), labels=table(ch$RECOVERED), pos=3)

dev.off()

png("../plots/regions/special/Cheliabinsk/barplot.Cheliabinsk.patients_all.png", height=750, width=1000, res=120, pointsize=10)
par(mar=c(8,5,4,2)+.1)

plot.ch.CONDITION <- plot(ch$CONDITION, las=2, ylim=c(0,(max(table(ch$CONDITION))+100)),
main=paste("Челябинск, COVID+, состояния больных на", Sys.Date()))
text(plot.ch.CONDITION, table(ch$CONDITION), labels=table(ch$CONDITION), pos=3)

dev.off()

png("../plots/regions/special/Cheliabinsk/hist.Cheliabinsk.age_pyramid.png", height=750, width=1000, res=120, pointsize=10)
par(mar=c(6,5,4,2)+.1)

hist.AGE <- hist(AGE$V1, breaks=-.5:(max(AGE$V1, na.rm=TRUE)+.5), border=8, col=8,
xlab="Возраст, лет",
main=paste("Челябинск, COVID+, возрастная пирамида на", Sys.Date()))
hist(ch.recovered$AGE, breaks=-.5:(max(AGE$V1, na.rm=TRUE)+.5), border="darkgreen", col="darkgreen", add=TRUE)
hist.deaths.AGE <- hist(ch.deaths$AGE, breaks=-.5:(max(AGE$V1, na.rm=TRUE)+.5), border=2, col=2, add=TRUE)
legend("topright", pch=15, col=c("grey","darkgreen","red"), legend=c("всего","выписаны","умерли"), bty="n")

dev.off()

png("../plots/regions/special/Cheliabinsk/barplot.Cheliabinsk.patients_active.png", height=750, width=1000, res=120, pointsize=10)
par(mar=c(8,5,4,2)+.1)

plot.ch.active.CONDITION <- plot(ch.active$CONDITION, las=2, ylim=c(0,(max(table(ch.active$CONDITION))+100)),
main=paste("Челябинск, COVID+, состояния больных, \nпродолжающих лечение на", Sys.Date()))
text(plot.ch.active.CONDITION, table(ch.active$CONDITION), labels=table(ch.active$CONDITION), pos=3)

dev.off()

png("../plots/regions/special/Cheliabinsk/linechart.Cheliabinsk.mortality_by_age.png", height=750, width=1000, res=120, pointsize=10)
par(mar=c(6,5,4,2)+.1)

ch.h.tot <- subset(hist.AGE$counts, hist.deaths.AGE$counts > 0)
ch.h.d <- subset(hist.deaths.AGE$counts, hist.deaths.AGE$counts > 0)
ch.h.counts <- subset(hist.AGE$mids, hist.deaths.AGE$counts > 0)

plot(hist.AGE$mids, hist.deaths.AGE$counts/hist.AGE$counts, 
type="o", pch=20,
xlab="Возраст, лет",
ylab="Доля умерших",
main=paste("Челябинск, COVID+, смертность по возрастам на", Sys.Date()),
frame=FALSE
)

polygon(
x = c(ch.h.counts, ch.h.counts[length(ch.h.counts):1]),
y = c(ch.h.d/ch.h.tot-1.96*sqrt((ch.h.d/ch.h.tot)*((1-ch.h.d/ch.h.tot)/ch.h.tot)),
(ch.h.d/ch.h.tot+1.96*sqrt((ch.h.d/ch.h.tot)*((1-ch.h.d/ch.h.tot)/ch.h.tot)))[length(ch.h.counts):1]
),
col=rgb(0,0,0,.1), border=rgb(0,0,0,.25)
)

dev.off()
