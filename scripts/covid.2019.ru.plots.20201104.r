################################################################
################################################################
## Updating folders tree
################################################################
################################################################

dir.create("../plots/regions/")
dir.create("../plots/regions/linear/")
dir.create("../plots/regions/increments/")
dir.create("../plots/regions/increments/i/")
dir.create("../plots/regions/increments/d/")

################################################################
################################################################
## Russia
################################################################
################################################################

# covid.2019.ru.dyn

# 03.COVID.2019.CaseFatalityRatio.dyn.png
# 04.COVID.2019.cumulated.by_regions.png
# 05.COVID.2019.cumulated.log.10.by_regions.png
# 06.COVID.2019.cumulated.log10.1M.png
# 07.COVID.2019.growth_ratio.png
# 08.COVID.2019.hist.rdi.png
# 09.COVID.2019.hist.dt.png
# 10.COVID.2019.map.regions.png
# 11.COVID.2019.map.regions.per_100K.png
# 12.COVID.2019.map.density.regions.png
# 13.COVID.2019.map.density.regions.per_100K.png
# 14.1.COVID.2019.map.density.regions.rdi7dt.png
# 14.2.COVID.2019.map.density.regions.i.7.var.png
# 15.COVID.2019.barplot.regions.png
# 16.COVID.2019.barplot.regions.log.10.png
# 17.COVID.2019.barplot.regions.per_100K.png
# 18.COVID.2019.barplot.regions.per_100K.active.png
# 19.COVID.2019.barplot.regions.per_100K.detected_for_the_past_7d.png
# 31.COVID.2019.fitting.rmc.partial.01.log10.png
# 32.COVID.2019.fitting.rmc.partial.02.RUS.Prov.log10.png
# 33.COVID.2019.fitting.rmc.partial.03.Mos.log10.png
# 34.COVID.2019.fitting.rmc.partial.04.SPb.log10.png
# 90.COVID.2019.SPb.d_smooth.png
# 90.COVID.2019.SPb.i_smooth.png
# 90.COVID.2019.SPb.ratio_ir.png

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

# Increments detcted
lines(covid.2019.ru.dyn$TIME, covid.2019.ru.dyn$i, type="h", col="darkred")

# Cumulated detected
lines(covid.2019.ru.dyn$TIME, cumsum(covid.2019.ru.dyn$i), col="white", lwd=5)
lines(covid.2019.ru.dyn$TIME, cumsum(covid.2019.ru.dyn$i), col="darkred", lwd=2)

# Active
lines(covid.2019.ru.dyn$TIME, cumsum(covid.2019.ru.dyn$i)-(cumsum(covid.2019.ru.dyn$r)+cumsum(covid.2019.ru.dyn$d)), col="white", lwd=5)
lines(covid.2019.ru.dyn$TIME, cumsum(covid.2019.ru.dyn$i)-(cumsum(covid.2019.ru.dyn$r)+cumsum(covid.2019.ru.dyn$d)), col=2, lwd=2)

# Cumulated recovered
lines(covid.2019.ru.dyn$TIME, cumsum(covid.2019.ru.dyn$r), col="white", lwd=5)
lines(covid.2019.ru.dyn$TIME, cumsum(covid.2019.ru.dyn$r), col="darkgreen", lwd=2)

# Cumulated deaths
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

# Grid for months
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

# Increments detcted
lines(covid.2019.ru.dyn$TIME, log10(covid.2019.ru.dyn$i), type="h", col="darkred")

# Cumulated detected
lines(covid.2019.ru.dyn$TIME, log10(cumsum(covid.2019.ru.dyn$i)), col="white", lwd=5)
lines(covid.2019.ru.dyn$TIME, log10(cumsum(covid.2019.ru.dyn$i)), col="darkred", lwd=2)

# Active
lines(covid.2019.ru.dyn$TIME, log10(cumsum(covid.2019.ru.dyn$i)-(cumsum(covid.2019.ru.dyn$r)+cumsum(covid.2019.ru.dyn$d))), col="white", lwd=5)
lines(covid.2019.ru.dyn$TIME, log10(cumsum(covid.2019.ru.dyn$i)-(cumsum(covid.2019.ru.dyn$r)+cumsum(covid.2019.ru.dyn$d))), col=2, lwd=2)

# Cumulated recovered
lines(covid.2019.ru.dyn$TIME, log10(cumsum(covid.2019.ru.dyn$r)), col="white", lwd=5)
lines(covid.2019.ru.dyn$TIME, log10(cumsum(covid.2019.ru.dyn$r)), col="darkgreen", lwd=2)

# Cumulated deaths
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

# Grid for months
abline(v = seq(min(covid.2019.ru.dyn$TIME), max(covid.2019.ru.dyn$TIME), by = "month"), lty = 3, col = 8, lwd=.75)

axis(2, at=log10(c(1,10,100,1000,10000,100000,1000000,10000000)), labels=c("1","10","100","1K","10K","100K","1M","10M"))
axis(2, at=log10(c(1:9, seq(10,100,10), seq(200,1000,100), seq(2000,10000,1000), seq(20000,100000,10000), seq(200000,1000000,100000), seq(2000000,10000000,1000000))), labels=FALSE)

axis.POSIXct(1,
at = seq(min(covid.2019.ru.dyn$TIME), max(covid.2019.ru.dyn$TIME), by = "week"),
format = "%Y-%m-%d",
las = 2)

dev.off()

# pop

# > colnames(pop)
#  [1] "LOCUS"               "LAT"                 "LON"                
#  [4] "POPULATION"          "COORD.BASED"         "REGION.RUS.LONG"    
#  [7] "REGION.RUS"          "POPULATION.20200101" "FED.DISCTRICT"      
# [10] "REGION.INCR"        
# >

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

# Regions barplot cases detected for the past 7 days per 100K;
png("../plots/19.COVID.2019.barplot.regions.per_100K.detected_for_the_past_7d.png", height=1200, width=750, res=120, pointsize=10)
par(mar=c(3.5,6,4,1)+.1, mgp=c(1.7,.5,-.5), cex.axis=.6, cex.lab=.9)

barplot(
height = pop.derived[order(pop.derived$DETECTED.7),]$DETECTED.7, 
names.arg = pop.derived[order(pop.derived$DETECTED.7),]$LOCUS, 
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

# Shadows for all regions
for(j in 1:length(covid.2019.ru.dyn.tot.primary)){
 lines(covid.2019.ru.dyn.tot.primary[[j]]$TIME, cumsum(covid.2019.ru.dyn.tot.primary[[j]]$i), lwd=1.5, col=rgb(0,0,0,.15))
}

# Increments detcted
lines(covid.2019.ru.dyn.tot.primary[[i]]$TIME, covid.2019.ru.dyn.tot.primary[[i]]$i, type="h", col="darkred")

# Cumulated detected
lines(covid.2019.ru.dyn.tot.primary[[i]]$TIME, cumsum(covid.2019.ru.dyn.tot.primary[[i]]$i), col="white", lwd=5)
lines(covid.2019.ru.dyn.tot.primary[[i]]$TIME, cumsum(covid.2019.ru.dyn.tot.primary[[i]]$i), col="darkred", lwd=2)

# Active
lines(covid.2019.ru.dyn.tot.primary[[i]]$TIME, cumsum(covid.2019.ru.dyn.tot.primary[[i]]$i)-(cumsum(covid.2019.ru.dyn.tot.primary[[i]]$r)+cumsum(covid.2019.ru.dyn.tot.primary[[i]]$d)), col="white", lwd=5)
lines(covid.2019.ru.dyn.tot.primary[[i]]$TIME, cumsum(covid.2019.ru.dyn.tot.primary[[i]]$i)-(cumsum(covid.2019.ru.dyn.tot.primary[[i]]$r)+cumsum(covid.2019.ru.dyn.tot.primary[[i]]$d)), col=2, lwd=2)

# Cumulated recovered
lines(covid.2019.ru.dyn.tot.primary[[i]]$TIME, cumsum(covid.2019.ru.dyn.tot.primary[[i]]$r), col="white", lwd=5)
lines(covid.2019.ru.dyn.tot.primary[[i]]$TIME, cumsum(covid.2019.ru.dyn.tot.primary[[i]]$r), col="darkgreen", lwd=2)

# Cumulated deaths
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

# Grid for months
abline(v = seq(min(covid.2019.ru.dyn.tot.primary[[i]]$TIME), max(covid.2019.ru.dyn.tot.primary[[i]]$TIME), by = "month"), lty = 3, col = 8, lwd=.75)

axis(2)

axis.POSIXct(1,
at = seq(min(covid.2019.ru.dyn.tot.primary[[i]]$TIME), max(covid.2019.ru.dyn.tot.primary[[i]]$TIME), by = "week"),
format = "%Y-%m-%d",
las = 2)

dev.off()

}

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

# Shadows for all regions
for(j in 1:length(covid.2019.ru.dyn.tot.primary)){
 lines(covid.2019.ru.dyn.tot.primary[[j]]$TIME, log10(cumsum(covid.2019.ru.dyn.tot.primary[[j]]$i)), lwd=1.5, col=rgb(0,0,0,.15))
}

# Increments detcted
lines(covid.2019.ru.dyn.tot.primary[[i]]$TIME, log10(covid.2019.ru.dyn.tot.primary[[i]]$i), type="h", col="darkred")

# Cumulated detected
lines(covid.2019.ru.dyn.tot.primary[[i]]$TIME, log10(cumsum(covid.2019.ru.dyn.tot.primary[[i]]$i)), col="white", lwd=5)
lines(covid.2019.ru.dyn.tot.primary[[i]]$TIME, log10(cumsum(covid.2019.ru.dyn.tot.primary[[i]]$i)), col="darkred", lwd=2)

# Active
lines(covid.2019.ru.dyn.tot.primary[[i]]$TIME, log10(cumsum(covid.2019.ru.dyn.tot.primary[[i]]$i)-(cumsum(covid.2019.ru.dyn.tot.primary[[i]]$r)+cumsum(covid.2019.ru.dyn.tot.primary[[i]]$d))), col="white", lwd=5)
lines(covid.2019.ru.dyn.tot.primary[[i]]$TIME, log10(cumsum(covid.2019.ru.dyn.tot.primary[[i]]$i)-(cumsum(covid.2019.ru.dyn.tot.primary[[i]]$r)+cumsum(covid.2019.ru.dyn.tot.primary[[i]]$d))), col=2, lwd=2)

# Cumulated recovered
lines(covid.2019.ru.dyn.tot.primary[[i]]$TIME, log10(cumsum(covid.2019.ru.dyn.tot.primary[[i]]$r)), col="white", lwd=5)
lines(covid.2019.ru.dyn.tot.primary[[i]]$TIME, log10(cumsum(covid.2019.ru.dyn.tot.primary[[i]]$r)), col="darkgreen", lwd=2)

# Cumulated deaths
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

# Grid for months
abline(v = seq(min(covid.2019.ru.dyn.tot.primary[[i]]$TIME), max(covid.2019.ru.dyn.tot.primary[[i]]$TIME), by = "month"), lty = 3, col = 8, lwd=.75)

axis(2, at=log10(c(1,10,100,1000,10000,100000,1000000)), labels=c("1","10","100","1K","10K","100K","1M"))
axis(2, at=log10(c(1:9, seq(10,100,10), seq(200,1000,100), seq(2000,10000,1000), seq(20000,100000,10000), seq(200000,1000000,100000))), labels=FALSE)

axis.POSIXct(1,
at = seq(min(covid.2019.ru.dyn.tot.primary[[i]]$TIME), max(covid.2019.ru.dyn.tot.primary[[i]]$TIME), by = "week"),
format = "%Y-%m-%d",
las = 2)

dev.off()

}
