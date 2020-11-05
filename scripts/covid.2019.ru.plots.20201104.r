

for(i in 1:length(covid.2019.ru.dyn.tot.primary)){

png(file = paste("/home/tinea/Documents/H_et_S/Projects/github/COVID.2019.ru/plots/regions/increments/i/COVID.2019.momentary.", gsub(" ", "_", names(covid.2019.ru.dyn.tot.primary)[i]), ".i.png", sep=""), height=750, width=1000, res=120, pointsize=10)
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

for(i in 1:length(covid.2019.ru.dyn.tot.primary)){

png(file = paste("/home/tinea/Documents/H_et_S/Projects/github/COVID.2019.ru/plots/regions/increments/d/COVID.2019.momentary.", gsub(" ", "_", names(covid.2019.ru.dyn.tot.primary)[i]), ".d.png", sep=""), height=750, width=1000, res=120, pointsize=10)
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
