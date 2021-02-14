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

axis(1, at = seq(0, 10*10^5, 1*10^5), labels=c("0", paste(seq(100, 1000, 100), "K", sep="")))
axis(3, at = seq(0, 10*10^5, 1*10^5), labels=c("0", paste(seq(100, 1000, 100), "K", sep="")))

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
