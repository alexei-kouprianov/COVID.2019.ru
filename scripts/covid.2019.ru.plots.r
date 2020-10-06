################################################################
# Nested under:
# covid.2019.ru.main.r
# 
# requires:
# source("covid.2019.ru.data_loader.r")
# source("covid.2019.ru.data_transformations.r")

################################################################
# Basic plots

# Cumulated growth;
# png("../plots/COVID.2019.cumulated.png", height=750, width=1000, res=120, pointsize=10)
# par(mar=c(6,5,4,2)+.1)
#
# plot(covid.2019.ru.i.dyn.tt$TIME, covid.2019.ru.i.dyn.tt$RUS.CS, type="l",
# ylim=c(0, max(covid.2019.ru.i.dyn.tt$RUS.CS)),
# xlab="", 
# ylab="Total COVID-2019 cases detected", 
# main="Russian Federation",
# axes=FALSE)
#
# points(covid.2019.ru.i.dyn.tt$TIME, covid.2019.ru.i.dyn.tt$RUS.newcases, type="h", col=2, lwd=3)
#
# axis.POSIXct(1, 
# at=seq(min(covid.2019.breaks$TIME), max(covid.2019.breaks$TIME), by="week"), 
# format = "%Y-%m-%d", 
# las=2)
# axis(2)
#
# dev.off()

# Cumulated growth, by regions;

png("../plots/04.COVID.2019.cumulated.by_regions.png", height=750, width=1000, res=120, pointsize=10)
par(mar=c(6,5,4,2)+.1)

plot(covid.2019.ru.i.dyn.tt$TIME, (covid.2019.ru.i.dyn.tt$RUS.CS - (covid.2019.ru.i.dyn.tt$Mos.CS + covid.2019.ru.i.dyn.tt$SPb.CS)), 
type="l",col=3, xlab="", 
ylab="Total COVID-2019 cases detected", 
main="Russian Federation",
axes=FALSE)

points(covid.2019.ru.i.dyn.tt$TIME, covid.2019.ru.i.dyn.tt$SPb.CS, type="l",col=4)
points(covid.2019.ru.i.dyn.tt$TIME, covid.2019.ru.i.dyn.tt$Mos.CS, type="l", col=2)

legend("topleft", lt=1, col=c(2,4,3), legend=c("Moscow","St. Petersburg","The rest of Russia"), bty="n")

axis.POSIXct(1, 
at=seq(min(covid.2019.breaks$TIME), max(covid.2019.breaks$TIME), by="week"), 
format = "%Y-%m-%d", 
las=2)
axis(2)

dev.off()

# Cumulated growth, log scale;
# png("../plots/COVID.2019.cumulated.log10.png", height=750, width=1000, res=120, pointsize=10)
# par(mar=c(6,5,4,2)+.1)
#
# plot(covid.2019.ru.i.dyn.tt$TIME, log10(covid.2019.ru.i.dyn.tt$RUS.CS), type="l",
# ylim=c(0, max(log10(covid.2019.ru.i.dyn.tt$RUS.CS))),
# xlab="", 
# ylab="Total COVID-2019 cases detected (logarithmic scale)", 
# main="Russian Federation",
# axes=FALSE)
#
# points(covid.2019.ru.i.dyn.tt$TIME, log10(covid.2019.ru.i.dyn.tt$RUS.newcases), type="h", col=2, lwd=3)
#
# axis.POSIXct(1, 
# at=seq(min(covid.2019.breaks$TIME), max(covid.2019.breaks$TIME), by="week"), 
# format = "%Y-%m-%d", 
# las=2)
# axis(2, at=log10(c(1,10,100,1000)), labels=c(1,10,100,1000))
# axis(2, at=log10(c(1:9, seq(10,100,10), seq(200,1000,100), seq(2000,10000,1000))), labels=FALSE)
#
# dev.off()

# Cumulated growth, log scale, by regions;
png("../plots/05.COVID.2019.cumulated.log.10.by_regions.png", height=750, width=1000, res=120, pointsize=10)
par(mar=c(6,5,4,2)+.1)

plot(covid.2019.ru.i.dyn.tt$TIME,
log10(covid.2019.ru.i.dyn.tt$RUS.CS - (covid.2019.ru.i.dyn.tt$Mos.CS + covid.2019.ru.i.dyn.tt$SPb.CS)),
type="l", col=3, 
xlab="", 
ylab="Total COVID-2019 cases detected (logarithmic scale)", 
main="Russian Federation",
axes=FALSE)

points(covid.2019.ru.i.dyn.tt$TIME, log10(covid.2019.ru.i.dyn.tt$SPb.CS), type="l",col=4)
points(covid.2019.ru.i.dyn.tt$TIME, log10(covid.2019.ru.i.dyn.tt$Mos.CS), type="l",col=2)

# rasterImage(cc.logo, 
# xleft = covid.2019.ru.i.dyn.tt$TIME[1], 
# xright=covid.2019.ru.i.dyn.tt$TIME[1]+dim(cc.logo)[2]*1200, 
# ytop = log10(100), 
# ybottom=log10(100)-dim(cc.logo)[1]/1600)

axis.POSIXct(1, 
at=seq(min(covid.2019.breaks$TIME), max(covid.2019.breaks$TIME), by="week"), 
format = "%Y-%m-%d", 
las=2)
axis(2, at=log10(1*10^(0:5)), labels=c(1,10,100,1000,"10K","100K"))
axis(2, at=log10(c(1:9, seq(10,100,10), seq(200,1000,100), seq(2000,10000,1000), seq(20000,100000,10000), seq(200000,1000000,100000))), labels=FALSE)

legend("topleft", lt=1, col=c(2,4,3), legend=c("Moscow","St. Petersburg","The rest of Russia"), bty="n")

dev.off()

# Regions barplot;
png("../plots/15.COVID.2019.barplot.regions.png", height=1200, width=750, res=120, pointsize=10)
par(mar=c(3.5,6,4,1)+.1, mgp=c(1.7,.5,-.5), cex.axis=.6)

barplot(covid.2019.ru.i.reg.ordered.df$NUMBER, 
names.arg=covid.2019.ru.i.reg.ordered.df$LOCUS, 
horiz=TRUE,
ylab="", 
xlab=paste("Total COVID-2019 cases, as of",covid.2019.ru.i$TIMESTAMP[length(covid.2019.ru.i$TIMESTAMP)]), 
main="Russian Federation",
las=1)

axis(3)

dev.off()

# Regions barplot logarithmic;
png("../plots/16.COVID.2019.barplot.regions.log.10.png", height=1200, width=750, res=120, pointsize=10)
par(mar=c(3.5,6,4,1)+.1, mgp=c(1.7,.5,-.5), cex.axis=.6)

barplot(log10(covid.2019.ru.i.reg.ordered.df$NUMBER), 
names.arg=covid.2019.ru.i.reg.ordered.df$LOCUS, 
horiz=TRUE,
ylab="", 
xlab=paste("Total COVID-2019 cases, as of",covid.2019.ru.i$TIMESTAMP[length(covid.2019.ru.i$TIMESTAMP)],"(logarithmic scale)"), 
main="Russian Federation",
las=1, axes=FALSE)

axis(1, at=log10(c(1,10,100,1000,10000,100000,1000000)), labels=c(1,10,100,"1K","10K","100K","1M"))
axis(1, at=log10(c(1:9, seq(10,100,10), seq(200,1000,100), seq(2000,10000,1000), seq(20000,100000,10000), seq(200000,1000000,100000), seq(2000000,10000000,1000000))), labels=FALSE)

axis(3, at=log10(c(1,10,100,1000,10000,100000,1000000)), labels=c(1,10,100,"1K","10K","100K","1M"))
axis(3, at=log10(c(1:9, seq(10,100,10), seq(200,1000,100), seq(2000,10000,1000), seq(20000,100000,10000), seq(200000,1000000,100000), seq(2000000,10000000,1000000))), labels=FALSE)

dev.off()

# Regions barplot cases per 100K;
png("../plots/17.COVID.2019.barplot.regions.per_100K.png", height=1200, width=750, res=120, pointsize=10)
par(mar=c(3.5,6,4,1)+.1, mgp=c(1.7,.5,-.5), cex.axis=.6)

barplot(covid.2019.ru.i.reg.ordered.PER.100K.df$PER.100K, 
names.arg=covid.2019.ru.i.reg.ordered.PER.100K.df$LOCUS, 
horiz=TRUE,
ylab="", 
xlab=paste("Total COVID-2019 cases per 100K, as of",covid.2019.ru.i$TIMESTAMP[length(covid.2019.ru.i$TIMESTAMP)]), 
main="Russian Federation",
las=1)

axis(3)

dev.off()

# Regions barplot active cases per 100K;
png("../plots/18.COVID.2019.barplot.regions.per_100K.active.png", height=1200, width=750, res=120, pointsize=10)
par(mar=c(3.5,6,4,1)+.1, mgp=c(1.7,.5,-.5), cex.axis=.6)

barplot(height=covid.2019.ru.i.reg.ordered.CS.a.POP$CS.a.POP, 
names.arg=covid.2019.ru.i.reg.ordered.CS.a.POP$LOCUS, 
horiz=TRUE,
ylab="", 
xlab=paste("Active COVID-2019 cases per 100K, as of",covid.2019.ru.i$TIMESTAMP[length(covid.2019.ru.i$TIMESTAMP)]), 
main="Russian Federation",
las=1)

axis(3)

dev.off()

# Regions barplot cases detected for the past 7 days per 100K;
png("../plots/19.COVID.2019.barplot.regions.per_100K.detected_for_the_past_7d.png", height=1200, width=750, res=120, pointsize=10)
par(mar=c(3.5,6,4,1)+.1, mgp=c(1.7,.5,-.5), cex.axis=.6, cex.lab=.9)

barplot(height=covid.2019.ru.i.reg.ordered.last.7.i.POP$last.7.i.POP,
names.arg=covid.2019.ru.i.reg.ordered.last.7.i.POP$LOCUS, 
horiz=TRUE,
ylab="", 
xlab=paste("Sum of COVID-2019 cases detected for the past 7 days per 100K, as of",covid.2019.ru.i$TIMESTAMP[length(covid.2019.ru.i$TIMESTAMP)]), 
main="Russian Federation",
las=1)

axis(3)

dev.off()

# Map total cases;
png("../plots/10.COVID.2019.map.regions.png", height=750, width=1000, res=120, pointsize=10)

map(region="Russia", fill=TRUE, col=8) 
mtext(paste("Total COVID-2019 cases, as of",covid.2019.ru.i$TIMESTAMP[length(covid.2019.ru.i$TIMESTAMP)]), 
side=1, line=2) 
mtext("Russian Federation", font=2, cex=1.2, side=3, line=3)

# points(
# covid.2019.ru.i.reg.0.df$LON, 
# covid.2019.ru.i.reg.0.df$LAT, 
# cex=sqrt(covid.2019.ru.i.reg.0.df$NUMBER)/8, 
# pch=21, bg=2
# )

for(i in 1:nrow(covid.2019.ru.i.reg.0.df)){
 points(
 covid.2019.ru.i.reg.0.df$LON[i], 
 covid.2019.ru.i.reg.0.df$LAT[i], 
 cex=sqrt(covid.2019.ru.i.reg.0.df$NUMBER[i])/32, 
 pch=21, 
 bg=rainbow(ceiling(max(covid.2019.ru.i.reg.0.df$CS.i.diff.7.2log, na.rm=TRUE)), 
 s = 1, v = 1, start = 0, end = 4.5/6)[round(covid.2019.ru.i.reg.0.df$CS.i.diff.7.2log[i])]
 )
}

dev.off()

# Map total cases per 100K;
png("../plots/11.COVID.2019.map.regions.per_100K.png", height=750, width=1000, res=120, pointsize=10)

map(region="Russia", fill=TRUE, col=8) 
mtext(paste("Total COVID-2019 cases per 100K, as of",covid.2019.ru.i$TIMESTAMP[length(covid.2019.ru.i$TIMESTAMP)]), 
side=1, line=2) 
mtext("Russian Federation", font=2, cex=1.2, side=3, line=3)

# points(
# covid.2019.ru.i.reg.0.df$LON, 
# covid.2019.ru.i.reg.0.df$LAT, 
# cex=sqrt(covid.2019.ru.i.reg.0.df$PER.100K)/2, 
# pch=21, bg=2
# )

for(i in 1:nrow(covid.2019.ru.i.reg.0.df)){
 if(covid.2019.ru.i.rt.slice[i] != Inf){
 points(
 covid.2019.ru.i.reg.0.df$LON[i], 
 covid.2019.ru.i.reg.0.df$LAT[i], 
 cex=sqrt(covid.2019.ru.i.reg.0.df$PER.100K[i])/8, 
 pch=21, 
 bg=rainbow(ceiling(max(covid.2019.ru.i.reg.0.df$CS.i.diff.7.2log, na.rm=TRUE)), s = 1, v = 1, start = 0, end = 4.5/6)[round(covid.2019.ru.i.reg.0.df$CS.i.diff.7.2log[i])]
 )
 } else {
 points(
 covid.2019.ru.i.reg.0.df$LON[i], 
 covid.2019.ru.i.reg.0.df$LAT[i], 
 cex=sqrt(covid.2019.ru.i.reg.0.df$PER.100K[i])/4, 
 pch=21, 
 bg=2
 )
 }
}

dev.off()

# Cumulated for 1M regional centres, log10 scale, cut at day 36;

png("../plots/06.COVID.2019.cumulated.log10.1M.png", height=750, width=1000, res=120, pointsize=10)
par(mar=c(6,5,4,2)+.1, lwd=2)

nrow.tt <- nrow(covid.2019.ru.dyn.tot[[1]])

plot(covid.2019.ru.dyn.tot$"Nizhnii Novgorod"$TIME[36:nrow.tt],
log10(covid.2019.ru.dyn.tot$"Nizhnii Novgorod"$CS.i[36:nrow.tt]),
type="n",
ylim=c(0,
 log10(
  max(
   c(
    covid.2019.ru.dyn.tot$"Bashkortostan"$CS.i, 
    covid.2019.ru.dyn.tot$"Cheliabinsk"$CS.i,
    covid.2019.ru.dyn.tot$"Ekaterinburg"$CS.i, 
    covid.2019.ru.dyn.tot$"Kazan"$CS.i, 
    covid.2019.ru.dyn.tot$"Krasnoyarsk"$CS.i, 
    covid.2019.ru.dyn.tot$"Nizhnii Novgorod"$CS.i, 
    covid.2019.ru.dyn.tot$"Novosibirsk"$CS.i, 
    covid.2019.ru.dyn.tot$"Omsk"$CS.i, 
    covid.2019.ru.dyn.tot$"Perm krai"$CS.i, 
    covid.2019.ru.dyn.tot$"Rostov-on-Don"$CS.i, 
    covid.2019.ru.dyn.tot$"Samara"$CS.i, 
    covid.2019.ru.dyn.tot$"Volgograd"$CS.i, 
    covid.2019.ru.dyn.tot$"Voronezh"$CS.i 
   )
  )
 )
),
main="Russian Federation, \nregions with capitals of 1,000 K population and more",
xlab="",
ylab="Total COVID-2019 cases detected (logarithmic scale)", 
axes=FALSE)

for(i in 1:8){
lines(covid.2019.ru.dyn.tot[[billionaires.p[i]]]$TIME[36:nrow.tt], log10(covid.2019.ru.dyn.tot[[billionaires.p[i]]]$CS.i[36:nrow.tt]), col=i, lwd=2) 
}

for(i in 9:13){
lines(covid.2019.ru.dyn.tot[[billionaires.p[i]]]$TIME[36:nrow.tt], log10(covid.2019.ru.dyn.tot[[billionaires.p[i]]]$CS.i[36:nrow.tt]), col=i-8, lty=3, lwd=2) 
}

legend(
"topleft",
lty=c(rep(1,8),rep(3,5)),
lwd=2,
col=c(1:8,1:5),
legend=names(covid.2019.ru.dyn.tot)[billionaires.p],
bty="n"
)

axis.POSIXct(1, 
at=seq(min(covid.2019.breaks$TIME), max(covid.2019.breaks$TIME), by="week"), 
format = "%Y-%m-%d", 
las=2)
axis(2, at=log10(c(1,10,100,1000)), labels=c(1,10,100,1000))
axis(2, at=log10(c(1:9, seq(10,100,10), seq(200,1000,100), seq(2000,10000,1000))), labels=FALSE)

dev.off()

png("../plots/07.COVID.2019.growth_ratio.png", height=750, width=1000, res=120, pointsize=10)
par(mar=c(6,5,4,2)+.1, lwd=2)

plot(covid.2019.ru.i.dyn.tt$TIME[33:(nrow(covid.2019.ru.i.dyn.tt))], 
covid.2019.ru.i.dyn.tt$RUS.Prov.CS.diff[33:(nrow(covid.2019.ru.i.dyn.tt))], 
type="n",
main="Russian Federation",
xlab="",
ylab="The ratio of COVID-2019 cases detected day N to day N-1 (truncated)", 
axes=FALSE)

lines(covid.2019.ru.i.dyn.tt$TIME, covid.2019.ru.i.dyn.tt$RUS.Prov.CS.diff, col=3)
lines(covid.2019.ru.i.dyn.tt$TIME, covid.2019.ru.i.dyn.tt$Mos.CS.diff, col=2)
lines(covid.2019.ru.i.dyn.tt$TIME, covid.2019.ru.i.dyn.tt$SPb.CS.diff, col=4)

legend("topright",
lty=1,
lwd=2,
col=c(2,4,3), 
legend=c("Moscow","St. Petersburg","The rest of Russia"),
bty="n")

axis.POSIXct(1, 
at=seq(min(covid.2019.breaks$TIME), max(covid.2019.breaks$TIME), by="week"), 
format = "%Y-%m-%d", 
las=2)
axis(2)

dev.off()

png("../plots/01.COVID.2019.cumulated.TARD.png", height=750, width=1000, res=120, pointsize=10)
par(mar=c(6,5,4,2)+.1, lwd=2)

plot(covid.2019.ru.i.dyn.tt$TIME, covid.2019.ru.i.dyn.tt$RUS.CS,
ylim=c(0,max(covid.2019.ru.i.dyn.tt$RUS.CS, na.rm=TRUE)),
type="l", col="darkred", #lty=3,
main="Russian Federation",
xlab="",
ylab="COVID-2019 cases", 
axes=FALSE)

lines(covid.2019.ru.i.dyn.tt$TIME, covid.2019.ru.i.dyn.tt$RUS.newcases, type="h", col="darkred")
lines(covid.2019.ru.d.dyn.tt$TIME, covid.2019.ru.d.dyn.tt$DEAD.CS, col="white", lwd=5)
lines(covid.2019.ru.d.dyn.tt$TIME, covid.2019.ru.d.dyn.tt$DEAD.CS)
lines(covid.2019.ru.r.dyn.tt$TIME, covid.2019.ru.r.dyn.tt$RECOVERED.CS, col="white", lwd=5)
lines(covid.2019.ru.r.dyn.tt$TIME, covid.2019.ru.r.dyn.tt$RECOVERED.CS, col=3)
lines(covid.2019.ru.i.dyn.tt$TIME, covid.2019.ru.i.dyn.tt$RUS.CS-(covid.2019.ru.r.dyn.tt$RECOVERED.CS + covid.2019.ru.d.dyn.tt$DEAD.CS), col="white", lwd=5)
lines(covid.2019.ru.i.dyn.tt$TIME, covid.2019.ru.i.dyn.tt$RUS.CS-(covid.2019.ru.r.dyn.tt$RECOVERED.CS + covid.2019.ru.d.dyn.tt$DEAD.CS), col=2)

axis.POSIXct(1, 
at=seq(min(covid.2019.breaks$TIME), max(covid.2019.breaks$TIME), by="week"), 
format = "%Y-%m-%d", 
las=2)
axis(2)

legend("topleft",
lty=1,
col=c("darkred","red","green","black"),
legend=c("Detected (vertical bars = new)","Active","Recovered","Deceased"),
bty="n")

dev.off()

png("../plots/02.COVID.2019.cumulated.TARD.log10.png", height=750, width=1000, res=120, pointsize=10)
par(mar=c(6,5,4,2)+.1, lwd=2)

plot(covid.2019.ru.i.dyn.tt$TIME, log10(covid.2019.ru.i.dyn.tt$RUS.CS),
ylim=c(0,log10(max(covid.2019.ru.i.dyn.tt$RUS.CS, na.rm=TRUE))),
type="l", col="darkred", #lty=3,
main="Russian Federation",
xlab="",
ylab="COVID-2019 cases (logarithmic scale)", 
axes=FALSE)

lines(covid.2019.ru.i.dyn.tt$TIME, log10(covid.2019.ru.i.dyn.tt$RUS.newcases), type="h", col="darkred")
lines(covid.2019.ru.d.dyn.tt$TIME, log10(covid.2019.ru.d.dyn.tt$DEAD.CS), col="white", lwd=5)
lines(covid.2019.ru.d.dyn.tt$TIME, log10(covid.2019.ru.d.dyn.tt$DEAD.CS))
lines(covid.2019.ru.r.dyn.tt$TIME, log10(covid.2019.ru.r.dyn.tt$RECOVERED.CS), col="white", lwd=6)
lines(covid.2019.ru.r.dyn.tt$TIME, log10(covid.2019.ru.r.dyn.tt$RECOVERED.CS), col=3)
lines(covid.2019.ru.i.dyn.tt$TIME, log10(covid.2019.ru.i.dyn.tt$RUS.CS-(covid.2019.ru.r.dyn.tt$RECOVERED.CS + covid.2019.ru.d.dyn.tt$DEAD.CS)), col="white", lwd=5)
lines(covid.2019.ru.i.dyn.tt$TIME, log10(covid.2019.ru.i.dyn.tt$RUS.CS-(covid.2019.ru.r.dyn.tt$RECOVERED.CS + covid.2019.ru.d.dyn.tt$DEAD.CS)), col=2)

axis.POSIXct(1, 
at=seq(min(covid.2019.breaks$TIME), max(covid.2019.breaks$TIME), by="week"), 
format = "%Y-%m-%d", 
las=2)
axis(2, at=log10(1*10^(0:5)), labels=c(1,10,100,1000,"10K","100K"))
axis(2, at=log10(c(1:9, seq(10,100,10), seq(200,1000,100), seq(2000,10000,1000), seq(20000,100000,10000), seq(200000,1000000,100000))), labels=FALSE)

legend("topleft",
lty=1,
col=c("darkred","red","green","black"),
legend=c("Detected (vertical bars = new)","Active","Recovered","Deceased"),
bty="n")

dev.off()

# plot(covid.2019.ru.i.dyn.tt$TIME, log10(covid.2019.ru.i.dyn.tt$RUS.CS), type="n", ylim=c(0,(log10(max(covid.2019.ru.i.dyn.tt$RUS.CS)))))
#
# for(j in 1:length(levels(covid.2019.ru$LOCUS))){
#  lines(covid.2019.ru.i.dyn.tt$TIME, log10(covid.2019.ru.dyn.tot[[j]]$CS), col=rgb(0,0,0,.3))
# }

dir.create("../plots/regions/")

for(i in 1:length(levels(covid.2019.ru$LOCUS))){

png(file=paste("../plots/regions/COVID.2019.cumulated.log10.",gsub(" ", "_", levels(covid.2019.ru$LOCUS)[i]),".png", sep=""), height=750, width=750, res=120, pointsize=10)
par(mar=c(6,5,4,2)+.1, lwd=2)

plot(covid.2019.ru.i.dyn.tt$TIME, log10(covid.2019.ru.i.dyn.tt$RUS.CS), 
type="n", 
ylim=c(0,(log10(max(covid.2019.ru.i.dyn.tt$RUS.CS)))),
main=paste("Russian Federation /",levels(covid.2019.ru$LOCUS)[i]),
xlab="",
ylab="COVID-2019 cases detected (logarithmic scale)",
axes=FALSE
)

for(j in 1:length(levels(covid.2019.ru$LOCUS))){
 lines(covid.2019.ru.dyn.tot[[j]]$TIME, log10(covid.2019.ru.dyn.tot[[j]]$CS.i), lwd=1.5, col=rgb(0,0,0,.15))
}

lines(covid.2019.ru.dyn.tot[[j]]$TIME, log10(covid.2019.ru.dyn.tot[[i]]$i), type="h", col="darkred")

lines(covid.2019.ru.dyn.tot[[j]]$TIME, log10(covid.2019.ru.dyn.tot[[i]]$CS.i), col="white", lwd=3)
lines(covid.2019.ru.dyn.tot[[j]]$TIME, log10(covid.2019.ru.dyn.tot[[i]]$CS.i), col="darkred", lwd=1)
lines(covid.2019.ru.dyn.tot[[j]]$TIME, log10(covid.2019.ru.dyn.tot[[i]]$CS.i-
(covid.2019.ru.dyn.tot[[i]]$CS.r+covid.2019.ru.dyn.tot[[i]]$CS.d)
), col="white", lwd=4)
lines(covid.2019.ru.dyn.tot[[j]]$TIME, log10(covid.2019.ru.dyn.tot[[i]]$CS.i-
(covid.2019.ru.dyn.tot[[i]]$CS.r+covid.2019.ru.dyn.tot[[i]]$CS.d)
), col=2, lwd=2)
lines(covid.2019.ru.dyn.tot[[j]]$TIME, log10(covid.2019.ru.dyn.tot[[i]]$CS.r), col="white", lwd=5)
lines(covid.2019.ru.dyn.tot[[j]]$TIME, log10(covid.2019.ru.dyn.tot[[i]]$CS.r), col="darkgreen", lwd=2)
lines(covid.2019.ru.dyn.tot[[j]]$TIME, log10(covid.2019.ru.dyn.tot[[i]]$CS.d), col="white", lwd=5)
lines(covid.2019.ru.dyn.tot[[j]]$TIME, log10(covid.2019.ru.dyn.tot[[i]]$CS.d), col=1, lwd=2)

abline(h=log10(50), lty=3, lwd=.75)

axis.POSIXct(1, 
at=seq(min(covid.2019.breaks$TIME), max(covid.2019.breaks$TIME), by="week"), 
format = "%Y-%m-%d", 
las=2)
axis(2, at=log10(c(1,10,100,1000,10000)), labels=c(1,10,100,1000,10000))
axis(2, at=log10(c(1:9, seq(10,100,10), seq(200,1000,100), seq(2000,10000,1000), seq(20000,100000,10000))), labels=FALSE)

legend(
"topleft",
lty=1,
lwd=c(1,2,2,2),
col=c("darkred","red","darkgreen","black"),
legend=c("Total cases (vertical bars = new ones)","Active cases","Recovered","Deceased"),
bty="n"
)

dev.off()

}

dir.create("../plots/regions/linear/")

for(i in 1:length(levels(covid.2019.ru$LOCUS))){

png(file=paste("../plots/regions/linear/COVID.2019.cumulated.linear.",gsub(" ", "_", levels(covid.2019.ru$LOCUS)[i]),".png", sep=""), height=750, width=750, res=120, pointsize=10)
par(mar=c(6,5,4,2)+.1, lwd=2)

plot(covid.2019.ru.dyn.tot[[i]]$TIME, covid.2019.ru.dyn.tot[[i]]$CS.i, 
type="n", 
# ylim=c(0,(max(covid.2019.ru.i.dyn.tt$RUS.CS))),
main=paste("Russian Federation /",levels(covid.2019.ru$LOCUS)[i]),
xlab="",
ylab="COVID-2019 cases detected (linear scale)",
axes=FALSE
)

for(j in 1:length(levels(covid.2019.ru$LOCUS))){
 lines(covid.2019.ru.dyn.tot[[j]]$TIME, covid.2019.ru.dyn.tot[[j]]$CS.i, lwd=1.5, col=rgb(0,0,0,.15))
}

lines(covid.2019.ru.dyn.tot[[j]]$TIME, covid.2019.ru.dyn.tot[[i]]$i, type="h", col="darkred")

lines(covid.2019.ru.dyn.tot[[j]]$TIME, covid.2019.ru.dyn.tot[[i]]$CS.i, col="white", lwd=5)
lines(covid.2019.ru.dyn.tot[[j]]$TIME, covid.2019.ru.dyn.tot[[i]]$CS.i, col="darkred", lwd=2)
lines(covid.2019.ru.dyn.tot[[j]]$TIME, (covid.2019.ru.dyn.tot[[i]]$CS.i-
(covid.2019.ru.dyn.tot[[i]]$CS.r+covid.2019.ru.dyn.tot[[i]]$CS.d)
), col="white", lwd=4)
lines(covid.2019.ru.dyn.tot[[j]]$TIME, (covid.2019.ru.dyn.tot[[i]]$CS.i-
(covid.2019.ru.dyn.tot[[i]]$CS.r+covid.2019.ru.dyn.tot[[i]]$CS.d)
), col=2, lwd=2)
lines(covid.2019.ru.dyn.tot[[j]]$TIME, covid.2019.ru.dyn.tot[[i]]$CS.r, col="white", lwd=5)
lines(covid.2019.ru.dyn.tot[[j]]$TIME, covid.2019.ru.dyn.tot[[i]]$CS.r, col="darkgreen", lwd=2)
lines(covid.2019.ru.dyn.tot[[j]]$TIME, covid.2019.ru.dyn.tot[[i]]$CS.d, col="white", lwd=5)
lines(covid.2019.ru.dyn.tot[[j]]$TIME, covid.2019.ru.dyn.tot[[i]]$CS.d, col=1, lwd=2)

abline(h=log10(50), lty=3, lwd=.75)

axis.POSIXct(1, 
at=seq(min(covid.2019.breaks$TIME), max(covid.2019.breaks$TIME), by="week"), 
format = "%Y-%m-%d", 
las=2)

axis(2)

legend(
"topleft",
lty=1,
lwd=2,
col=c("darkred","red","darkgreen","black"),
legend=c("Total cases (vertical bars = new ones)","Active cases","Recovered","Deceased"),
bty="n"
)

dev.off()

}


dir.create("../plots/regions/increments/")

dir.create("../plots/regions/increments/i/")

for(i in 1:length(levels(covid.2019.ru$LOCUS))){

png(file=paste("../plots/regions/increments/i/COVID.2019.momentary.",gsub(" ", "_", levels(covid.2019.ru$LOCUS)[i]),".i.png", sep=""), height=750, width=750, res=120, pointsize=10)
par(mar=c(6,5,4,2)+.1, lwd=2)

plot(covid.2019.ru.i.dyn.tt$TIME, covid.2019.ru.dyn.tot[[i]]$i, type="h", col="darkred",
main=paste("Russian Federation / ",
levels(covid.2019.ru$LOCUS)[i]," (",
sum(covid.2019.ru.dyn.tot[[i]]$i),")", sep=""),
xlab="",
ylab="COVID-2019 new cases detected",
axes=FALSE
)

axis.POSIXct(1, 
at=seq(min(covid.2019.breaks$TIME), max(covid.2019.breaks$TIME), by="week"), 
format = "%Y-%m-%d", 
las=2)
axis(2)

dev.off()
}

dir.create("../plots/regions/increments/i.7/")

for(i in 1:length(levels(covid.2019.ru$LOCUS))){

png(file=paste("../plots/regions/increments/i.7/COVID.2019.momentary.7.",gsub(" ", "_", levels(covid.2019.ru$LOCUS)[i]),".i.png", sep=""), height=750, width=750, res=120, pointsize=10)
par(mar=c(6,5,4,2)+.1, lwd=2)

plot(covid.2019.ru.i.dyn.tt$TIME, covid.2019.ru.dyn.tot[[i]]$i, type="h", col="darkred",
main=paste("Russian Federation / ",
levels(covid.2019.ru$LOCUS)[i]," (",
sum(covid.2019.ru.dyn.tot[[i]]$i),")", sep=""),
xlab="",
ylab="COVID-2019 new cases detected, 7-day rolling mean",
axes=FALSE
)

lines(covid.2019.ru.i.dyn.tt$TIME, covid.2019.ru.dyn.tot[[i]]$i.7, type="l", col="white", lwd=6)
lines(covid.2019.ru.i.dyn.tt$TIME, covid.2019.ru.dyn.tot[[i]]$i.7, type="l", col="red", lwd=3)

legend("topleft",
lty=1,
col=c("darkred","red"),
legend=c("Daily increment", "7-days rolling mean"),
bty="n"
)

axis.POSIXct(1, 
at=seq(min(covid.2019.breaks$TIME), max(covid.2019.breaks$TIME), by="week"), 
format = "%Y-%m-%d", 
las=2)
axis(2)

dev.off()
}


dir.create("../plots/regions/increments/i.7.var/")

for(i in 1:length(levels(covid.2019.ru$LOCUS))){

png(file=paste("../plots/regions/increments/i.7.var/COVID.2019.momentary.7.var",gsub(" ", "_", levels(covid.2019.ru$LOCUS)[i]),".i.png", sep=""), height=750, width=750, res=120, pointsize=10)
par(mar=c(6,5,4,2)+.1, lwd=2)

plot(covid.2019.ru.dyn.tot[[i]]$TIME, covid.2019.ru.dyn.tot[[i]]$i.7.var, 
type="n",
main=paste("Russian Federation / ",
levels(covid.2019.ru$LOCUS)[i]," (",
sum(covid.2019.ru.dyn.tot[[i]]$i),")", sep=""),
ylim=c(0,5),
xlab="",
ylab="COVID-2019 new cases detected, residuals vs. 7-day rolling mean",
axes=FALSE
)

for(j in 1:length(levels(covid.2019.ru$LOCUS))){
lines(covid.2019.ru.dyn.tot[[j]]$TIME, covid.2019.ru.dyn.tot[[j]]$i.7.var, type="l", col=rgb(0,0,0,.05))
}

lines(covid.2019.ru.dyn.tot[[i]]$TIME, covid.2019.ru.dyn.tot[[i]]$i.7.var, type="l", col="white", lwd=5)
lines(covid.2019.ru.dyn.tot[[i]]$TIME, covid.2019.ru.dyn.tot[[i]]$i.7.var, type="l", col="darkred", lwd=2)

axis.POSIXct(1, 
at=seq(min(covid.2019.breaks$TIME), max(covid.2019.breaks$TIME), by="week"), 
format = "%Y-%m-%d", 
las=2)
axis(2)

dev.off()
}

dir.create("../plots/regions/increments/R.RPN/")

for(i in 1:length(levels(covid.2019.ru$LOCUS))){

png(file=paste("../plots/regions/increments/R.RPN/COVID.2019.",gsub(" ", "_", levels(covid.2019.ru$LOCUS)[i]),".R.RPN.png", sep=""), height=750, width=750, res=120, pointsize=10)
par(mar=c(6,5,4,2)+.1, lwd=2)

plot(covid.2019.ru.i.dyn.tt$TIME, covid.2019.ru.dyn.tot[[i]]$R.RPN, type="n",
ylim=c(0,10),
main=paste("Russian Federation / ",
levels(covid.2019.ru$LOCUS)[i]," (",
sum(covid.2019.ru.dyn.tot[[i]]$i),")", sep=""),
xlab="",
ylab="Rospotrebnazor's R: daily increments for days [N,N-3]/[N-4,N-7]",
axes=FALSE
)

for(j in 1:length(levels(covid.2019.ru$LOCUS))){
 lines(covid.2019.ru.dyn.tot[[j]]$TIME, covid.2019.ru.dyn.tot[[j]]$R.RPN, lwd=1.5, col=rgb(0,0,0,.15))
}

lines(covid.2019.ru.i.dyn.tt$TIME, covid.2019.ru.dyn.tot[[i]]$R.RPN, type="l", col="white", lwd=6)
lines(covid.2019.ru.i.dyn.tt$TIME, covid.2019.ru.dyn.tot[[i]]$R.RPN, type="l", col="red", lwd=3)

abline(h=1, lty=3, col=1)

axis.POSIXct(1, 
at=seq(min(covid.2019.breaks$TIME), max(covid.2019.breaks$TIME), by="week"), 
format = "%Y-%m-%d", 
las=2)
axis(2)

dev.off()
}



dir.create("../plots/regions/increments/d/")

for(i in 1:length(levels(covid.2019.ru$LOCUS))){
if(sum(covid.2019.ru.dyn.tot[[i]]$d) > 20){ 

png(file=paste("../plots/regions/increments/d/COVID.2019.momentary.",gsub(" ", "_", levels(covid.2019.ru$LOCUS)[i]),".d.png", sep=""), height=750, width=750, res=120, pointsize=10)
par(mar=c(6,5,4,2)+.1, lwd=2)

plot(covid.2019.ru.i.dyn.tt$TIME, covid.2019.ru.dyn.tot[[i]]$d, type="h", col="black",
main=paste("Russian Federation / ",
levels(covid.2019.ru$LOCUS)[i]," (",
sum(covid.2019.ru.dyn.tot[[i]]$d),")", sep=""),
xlab="",
ylab="COVID-2019 new deaths reported",
axes=FALSE
)

axis.POSIXct(1, 
at=seq(min(covid.2019.breaks$TIME), max(covid.2019.breaks$TIME), by="week"), 
format = "%Y-%m-%d", 
las=2)
axis(2)

dev.off()
} # if()
} # for()

dir.create("../plots/regions/race/")

for(i in 1:length(levels(covid.2019.ru$LOCUS))){
if(nrow(covid.2019.ru.i.dyn.trunc[[i]]) > 1){

png(file=paste("../plots/regions/race/COVID.2019.race.log10.",gsub(" ", "_", levels(covid.2019.ru$LOCUS)[i]),".png", sep=""), height=750, width=750, res=120, pointsize=10)
par(mar=c(6,5,4,2)+.1, lwd=2)

plot(
(1:length(log10(covid.2019.ru.i.dyn.trunc[[Moscow.pos]]$CS.i))), 
log10(covid.2019.ru.i.dyn.trunc[[Moscow.pos]]$CS.i), 
type="o", 
col=rgb(0,0,0,.2),
pch=20, cex=.75,
main=paste("Russian Federation /",names(covid.2019.ru.i.dyn.trunc)[i]),
xlab="Days since N=50 threshold",
ylab="COVID-2019 cases detected (logarithmic scale)",
axes=FALSE
)

abline(v=seq(0,100,5), h=c(log10(10^(0:6)),log10(50*10^(0:6))), lty=3, lwd=1, col=rgb(0,0,0,.3))

curve(log10(50*2^((x-1)/2)), col=4, lty=3, lwd=.5, add=TRUE)
curve(log10(50*2^((x-1)/3)), col=4, lty=3, lwd=.5, add=TRUE)
curve(log10(50*2^((x-1)/4)), col=4, lty=3, lwd=.5, add=TRUE)
curve(log10(50*2^((x-1)/5)), col=4, lty=3, lwd=.5, add=TRUE)
curve(log10(50*2^((x-1)/7)), col=4, lty=3, lwd=.5, add=TRUE)
curve(log10(50*2^((x-1)/10)), col=4, lty=3, lwd=.5, add=TRUE)
curve(log10(50*2^((x-1)/14)), col=4, lty=3, lwd=.5, add=TRUE)
curve(log10(50*2^((x-1)/28)), col=4, lty=3, lwd=.5, add=TRUE)

x.right <- nrow(covid.2019.ru.i.dyn.trunc[[Moscow.pos]])-1

text(20, log10(50*2^((20-1)/2))+.01, col=4, labels="2 days", cex=.75, srt=73, pos=2)
text(30, log10(50*2^((30-1)/3))+.01, col=4, labels="3 days", cex=.75, srt=66, pos=2)
text(45, log10(45*2^((45-1)/4))+.01, col=4, labels="4 days", cex=.75, srt=54, pos=2)
text(60, log10(60*2^((60-1)/5))+.01, col=4, labels="5 days", cex=.75, srt=48, pos=2)
text(x.right, log10(50*2^((x.right-1)/7))+.01, col=4, labels="7 days", cex=.75, srt=34, pos=2)
text(x.right, log10(50*2^((x.right-1)/10))+.01, col=4, labels="10 days", cex=.75, srt=26, pos=2)
text(x.right, log10(50*2^((x.right-1)/14))+.01, col=4, labels="14 days", cex=.75, srt=24, pos=2)
text(x.right, log10(50*2^((x.right-1)/28))+.01, col=4, labels="28 days", cex=.75, srt=11, pos=2)

shadowtext(
x=length(covid.2019.ru.i.dyn.trunc[[Moscow.pos]]$CS.i),
y=log10(covid.2019.ru.i.dyn.trunc[[Moscow.pos]]$CS.i[length(covid.2019.ru.i.dyn.trunc[[Moscow.pos]]$CS.i)]),
labels=names(covid.2019.ru.i.dyn.trunc)[Moscow.pos],
col="black", bg="white", r=.2,
cex=.75,
pos=2
)

for(j in 1:length(levels(covid.2019.ru$LOCUS))){
 lines(
 (1:length(log10(covid.2019.ru.i.dyn.trunc[[j]]$CS.i))), 
 log10(covid.2019.ru.i.dyn.trunc[[j]]$CS.i), 
 col=rgb(0,0,0,.2), 
 type="o", pch=20, cex=.75)
}

lines(
(1:length(log10(covid.2019.ru.i.dyn.trunc[[i]]$CS.i))), 
log10(covid.2019.ru.i.dyn.trunc[[i]]$CS.i), 
col="white", lwd=4,
type="o", pch=20, cex=1)

lines(
(1:length(log10(covid.2019.ru.i.dyn.trunc[[i]]$CS.i))), 
log10(covid.2019.ru.i.dyn.trunc[[i]]$CS.i), 
col="darkred", lwd=1,
type="o", pch=20, cex=.75)

lines(
(1:length(log10(covid.2019.ru.i.dyn.trunc[[i]]$CS.i))), 
log10(covid.2019.ru.i.dyn.trunc[[i]]$CS.i-(covid.2019.ru.i.dyn.trunc[[i]]$CS.r+covid.2019.ru.i.dyn.trunc[[i]]$CS.d)), 
col="white", lwd=4,
type="o", pch=20, cex=1)

lines(
(1:length(log10(covid.2019.ru.i.dyn.trunc[[i]]$CS.i))), 
log10(covid.2019.ru.i.dyn.trunc[[i]]$CS.i-(covid.2019.ru.i.dyn.trunc[[i]]$CS.r+covid.2019.ru.i.dyn.trunc[[i]]$CS.d)), 
col="red", lwd=2,
type="o", pch=20, cex=.75)

if(i != Moscow.pos){

shadowtext(
x=length(covid.2019.ru.i.dyn.trunc[[i]]$CS.i),
y=log10(covid.2019.ru.i.dyn.trunc[[i]]$CS.i[length(covid.2019.ru.i.dyn.trunc[[i]]$CS.i)]),
labels=names(covid.2019.ru.i.dyn.trunc)[i],
col="black", bg="white", r=.2,
pos=4, cex=.75
)

} # if(i != Moscow.pos){};

axis(1)
axis(1, at=1:length(covid.2019.ru.i.dyn.trunc[[Moscow.pos]]$CS.i), labels=FALSE, tcl=-.25)

axis(2, at=log10(c(100,1000,10000,100000)), labels=c(100,"1K","10K","100K"))
axis(2, at=log10(c(seq(50,100,10), seq(200,1000,100), seq(2000,10000,1000), seq(20000,100000,10000), seq(200000,1000000,100000))), labels=FALSE)

legend(
"topleft",
lty=1,
lwd=1:2,
col=c("darkred", "red"),
legend=c("Total cases","Active cases"),
bty="n"
)

dev.off()

} # if(nrow(covid.2019.ru.i.dyn.trunc[[i]] > 2)){};
} # for(i in 1:length(levels(covid.2019.ru$LOCUS))){};

# Relative daily increment dynamics

dir.create("../plots/regions/rdi.race/")

for(i in 1:length(levels(covid.2019.ru$LOCUS))){
if(nrow(covid.2019.ru.i.dyn.trunc[[i]]) > 7){
if(i != Moscow.pos){

png(file=paste("../plots/regions/rdi.race/COVID.2019.rdi.race.log10.",gsub(" ", "_", levels(covid.2019.ru$LOCUS)[i]),".png", sep=""), height=750, width=750, res=120, pointsize=10)
par(mar=c(6,5,4,2)+.1, lwd=2)

plot(1:nrow(covid.2019.ru.i.dyn.trunc[[Moscow.pos]]), 
covid.2019.ru.i.dyn.trunc[[Moscow.pos]]$CS.i.diff.7, 
type="l", 
ylim=c(1,1.7),
main=paste("Russian Federation /",names(covid.2019.ru.i.dyn.trunc)[i]),
xlab="Days since N=50 threshold",
ylab="Relative daily increment, running average for 7 days (3 last days truncated)",
axes=FALSE
)
grid(lwd=1)
for(j in 1:length(levels(covid.2019.ru$LOCUS))){
lines(1:nrow(covid.2019.ru.i.dyn.trunc[[j]]), covid.2019.ru.i.dyn.trunc[[j]]$CS.i.diff.7, col=rgb(0,0,0,.3))
}
points(x=nrow(covid.2019.ru.i.dyn.trunc[[Moscow.pos]])-3, y=(covid.2019.ru.i.dyn.trunc[[Moscow.pos]]$CS.i.diff.7[nrow(covid.2019.ru.i.dyn.trunc[[Moscow.pos]])-3]), pch=20, col=1)

shadowtext(
x=nrow(covid.2019.ru.i.dyn.trunc[[Moscow.pos]])-3, 
y=(covid.2019.ru.i.dyn.trunc[[Moscow.pos]]$CS.i.diff.7[nrow(covid.2019.ru.i.dyn.trunc[[Moscow.pos]])-3]), 
cex=.75, 
col="black", bg="white", r=.2,
labels=names(covid.2019.ru.i.dyn.trunc)[Moscow.pos],
pos=4
)

lines(1:nrow(covid.2019.ru.i.dyn.trunc[[i]]), covid.2019.ru.i.dyn.trunc[[i]]$CS.i.diff.7, col="white", lwd=4)
lines(1:nrow(covid.2019.ru.i.dyn.trunc[[i]]), covid.2019.ru.i.dyn.trunc[[i]]$CS.i.diff.7, col=2, lwd=2)
points(x=nrow(covid.2019.ru.i.dyn.trunc[[i]])-3, y=(covid.2019.ru.i.dyn.trunc[[i]]$CS.i.diff.7[nrow(covid.2019.ru.i.dyn.trunc[[i]])-3]), pch=20, col=2)

shadowtext(
x=nrow(covid.2019.ru.i.dyn.trunc[[i]])-3, 
y=(covid.2019.ru.i.dyn.trunc[[i]]$CS.i.diff.7[nrow(covid.2019.ru.i.dyn.trunc[[i]])-3]), 
cex=.75, 
col="black", bg="white", r=.2,
labels=names(covid.2019.ru.i.dyn.trunc)[i],
pos=4
)

axis(1)
axis(1, at=1:nrow(covid.2019.ru.i.dyn.trunc[[Moscow.pos]]), labels=FALSE)
axis(2)

dev.off()

} # if(i != Moscow.pos){};
} # if(nrow(covid.2019.ru.i.dyn.trunc[[i]] > 2)){};
} # for(i in 1:length(levels(covid.2019.ru$LOCUS))){};

dir.create("../plots/regions/rdi/")

for(i in 1:length(levels(covid.2019.ru$LOCUS))){
if(sum(covid.2019.ru.dyn.tot[[i]]$CS.i.diff.7, na.rm=TRUE) > 0){

png(file=paste("../plots/regions/rdi/COVID.2019.rdi.log10.",gsub(" ", "_", levels(covid.2019.ru$LOCUS)[i]),".png", sep=""), height=750, width=750, res=120, pointsize=10)
par(mar=c(6,5,4,2)+.1)

plot(
40:nrow(covid.2019.ru.dyn.tot[[Moscow.pos]]), 
covid.2019.ru.dyn.tot[[Moscow.pos]]$CS.i.diff.7[40:nrow(covid.2019.ru.dyn.tot[[Moscow.pos]])], 
type="l", ylim=c(1,1.7),
main=paste("Russian Federation /",names(covid.2019.ru.i.dyn.trunc)[i]),
xlab="Days since 2020-01-31",
ylab="Relative daily increment, running average for 7 days (3 last days truncated)",
axes=FALSE
)
for(j in 1:length(levels(covid.2019.ru$LOCUS))){
grid()
lines(
40:nrow(covid.2019.ru.dyn.tot[[j]]), 
covid.2019.ru.dyn.tot[[j]]$CS.i.diff.7[40:nrow(covid.2019.ru.dyn.tot[[j]])], 
col=rgb(0,0,0,.3))
}

points(x=nrow(covid.2019.ru.dyn.tot[[Moscow.pos]])-3, y=(covid.2019.ru.dyn.tot[[Moscow.pos]]$CS.i.diff.7[nrow(covid.2019.ru.dyn.tot[[Moscow.pos]])-3]), pch=20, col=1)

lines(1:nrow(covid.2019.ru.dyn.tot[[i]]), covid.2019.ru.dyn.tot[[i]]$CS.i.diff.7, col="white", lwd=4)
lines(1:nrow(covid.2019.ru.dyn.tot[[i]]), covid.2019.ru.dyn.tot[[i]]$CS.i.diff.7, col=2, lwd=2)
points(x=nrow(covid.2019.ru.dyn.tot[[i]])-3, y=(covid.2019.ru.dyn.tot[[i]]$CS.i.diff.7[nrow(covid.2019.ru.dyn.tot[[i]])-3]), pch=20, col=2)

shadowtext(
x=nrow(covid.2019.ru.dyn.tot[[i]])-3, 
y=(covid.2019.ru.dyn.tot[[i]]$CS.i.diff.7[nrow(covid.2019.ru.dyn.tot[[i]])-3]), 
cex=.75, 
col="black", bg="white", r=.2,
labels=names(covid.2019.ru.dyn.tot)[i],
pos=1
)

axis(1)
axis(1, at=1:nrow(covid.2019.ru.dyn.tot[[Moscow.pos]]), labels=FALSE)
axis(2)

dev.off()

} # > 7 
} # for(i in 1:length(levels(covid.2019.ru$LOCUS))){};

################################################################
# # Do not execute this part of the code mindlessly!
# # Map animated
# dir.create("../plots/map.animated/")
#
# for(i in 1:length(covid.2019.ru.i.cumul_ts)){
# 	if(i < 10){
# 	png(file=paste("../plots/map.animated/COVID.2019.map.regions.00",i,".png", sep=""), height=750, width=1000, res=120, pointsize=10)
# 	}else if(i < 100){
# 	png(file=paste("../plots/map.animated/COVID.2019.map.regions.0",i,".png", sep=""), height=750, width=1000, res=120, pointsize=10)
# 	}else{
# 	png(file=paste("../plots/map.animated/COVID.2019.map.regions.",i,".png", sep=""), height=750, width=1000, res=120, pointsize=10)
# 	}
#
# map(region="Russia", fill=TRUE, col=8) 
# mtext(paste("Total COVID-2019 cases, as of",covid.2019.breaks$TIMESTAMP[i]), 
# side=1, line=2, cex=2) 
# mtext("Russian Federation", font=2, cex=2, side=3, line=3)
#
# points(covid.2019.coord$LON, covid.2019.coord$LAT, cex=sqrt(log(as.data.frame(table(covid.2019.ru.i.cumul_ts[[i]]$LOCUS.0))$Freq+1)), pch=21, bg=2)
#
# dev.off()
# }
#
# # ffmpeg command line: 
# #
# # ffmpeg -r 2 -f image2 -s 1000x750 -i COVID.2019.map.regions.%03d.png -vcodec libx264 -crf 25 -pix_fmt yuv420p COVID.2019.ru.map.animated.mp4

png("../plots/08.COVID.2019.hist.rdi.png", height=750, width=1000, res=120, pointsize=10)

rdi.slice.noInf.max <- .99

while(rdi.slice.noInf.max < max(covid.2019.ru.i.rt.slice.noInf)){
rdi.slice.noInf.max <- rdi.slice.noInf.max + .005
}

hist(covid.2019.ru.i.rt.slice.noInf, breaks=seq(.99,rdi.slice.noInf.max,.005), col=8,
main=paste("Russian Federation / ", daily.timestamp$V1),
# main=paste("Russian Federation /", Sys.Date()),
xlab="COVID-2019 Relative daily increment (rolling average for 7 days)",
ylab="Number of regions with RDI this high"
)
abline(v=median(covid.2019.ru.i.rt.slice.noInf, na.rm=TRUE), col=3, lty=3, lwd=2)
abline(v=mean(covid.2019.ru.i.rt.slice.noInf, na.rm=TRUE), col=2, lty=3, lwd=2)

rug(covid.2019.ru.i.rt.slice.noInf)

legend(
"topright",
lty=3,
lwd=2,
col=3:2,
legend=c(
paste("Median RDI =",round(median(covid.2019.ru.i.rt.slice.noInf, na.rm=TRUE),3)),
paste("Mean RDI =",round(mean(covid.2019.ru.i.rt.slice.noInf, na.rm=TRUE),3))
),
bty="n"
)

dev.off()

png("../plots/09.COVID.2019.hist.dt.png", height=750, width=1000, res=120, pointsize=10)

hist(covid.2019.ru.i.reg.0.df$CS.i.diff.7.2log, 
breaks=(ceiling(min(covid.2019.ru.i.reg.0.df$CS.i.diff.7.2log, na.rm=TRUE)-.5)-.5):
(floor(max(covid.2019.ru.i.reg.0.df$CS.i.diff.7.2log, na.rm=TRUE)+.5)+.5), 
col=rainbow(ceiling(max(covid.2019.ru.i.reg.0.df$CS.i.diff.7.2log, na.rm=TRUE)), 
s = 1, v = 1, start = 0, end = 4.5/6),
,
main=paste("Russian Federation / ", daily.timestamp$V1),
# main=paste("Russian Federation /", Sys.Date()),
xlab="COVID-2019 cases doubling time (days) based on Relative Daily Increment rolling average for 7 days",
ylab="Number of regions with doubling time this high"
)

abline(v=median(covid.2019.ru.i.reg.0.df$CS.i.diff.7.2log, na.rm=TRUE), col=3, lwd=2)
abline(v=mean(covid.2019.ru.i.reg.0.df$CS.i.diff.7.2log, na.rm=TRUE), col=5, lwd=2)

rug(covid.2019.ru.i.reg.0.df$CS.i.diff.7.2log)

legend(
"topright",
lty=1,
lwd=2,
col=c(3,5),
legend=c(
paste("Median DT =",round(median(covid.2019.ru.i.reg.0.df$CS.i.diff.7.2log, na.rm=TRUE),2)),
paste("Mean DT =",round(mean(covid.2019.ru.i.reg.0.df$CS.i.diff.7.2log, na.rm=TRUE),2))
),
bty="n"
)

dev.off()

png("../plots/03.COVID.2019.CaseFatalityRatio.dyn.png", height=750, width=1000, res=120, pointsize=10)
par(mar=c(6,5,4,2)+.1)

plot(
covid.2019.ru.i.dyn.tt$TIME[50:nrow(covid.2019.ru.d.dyn.tt)], 
covid.2019.ru.d.dyn.tt$DEAD.CS[50:nrow(covid.2019.ru.d.dyn.tt)]/(covid.2019.ru.r.dyn.tt$RECOVERED.CS[50:nrow(covid.2019.ru.r.dyn.tt)] + covid.2019.ru.d.dyn.tt$DEAD.CS[50:nrow(covid.2019.ru.d.dyn.tt)]), 
type="l", 
ylim=c(0, max(covid.2019.ru.d.dyn.tt$DEAD.CS[50:nrow(covid.2019.ru.d.dyn.tt)]/(covid.2019.ru.r.dyn.tt$RECOVERED.CS[50:nrow(covid.2019.ru.r.dyn.tt)] + covid.2019.ru.d.dyn.tt$DEAD.CS[50:nrow(covid.2019.ru.d.dyn.tt)]))),
main=paste("Russian Federation, Case Fatality Ratio / ", covid.2019.ru.i.dyn.tt$TIME[nrow(covid.2019.ru.d.dyn.tt)]),
xlab="",
ylab="Case Fatality Ratio",
axes=FALSE
)

lines(
covid.2019.ru.d.dyn.tt$TIME[50:nrow(covid.2019.ru.d.dyn.tt)],
covid.2019.ru.d.dyn.tt$DEAD[50:nrow(covid.2019.ru.d.dyn.tt)] /
sqrt(
covid.2019.ru.r.dyn.tt$RECOVERED[50:nrow(covid.2019.ru.r.dyn.tt)]
*
covid.2019.ru.i.dyn.tt$RUS[50:nrow(covid.2019.ru.i.dyn.tt)]
),
lty=3
)

lines(
covid.2019.ru.i.dyn.tt$TIME[50:nrow(covid.2019.ru.d.dyn.tt)], 
covid.2019.ru.d.dyn.tt$DEAD.CS[50:nrow(covid.2019.ru.d.dyn.tt)]/covid.2019.ru.i.dyn.tt$RUS.CS[50:nrow(covid.2019.ru.i.dyn.tt)], 
col=2)

lines(
covid.2019.ru.i.dyn.tt$TIME[50:nrow(covid.2019.ru.d.dyn.tt)], 
sqrt(
(covid.2019.ru.d.dyn.tt$DEAD.CS[50:nrow(covid.2019.ru.d.dyn.tt)]/(covid.2019.ru.r.dyn.tt$RECOVERED.CS[50:nrow(covid.2019.ru.r.dyn.tt)] + covid.2019.ru.d.dyn.tt$DEAD.CS[50:nrow(covid.2019.ru.d.dyn.tt)])) *
(covid.2019.ru.d.dyn.tt$DEAD.CS[50:nrow(covid.2019.ru.d.dyn.tt)]/covid.2019.ru.i.dyn.tt$RUS.CS[50:nrow(covid.2019.ru.i.dyn.tt)])
), 
lty=3,
col=2)

legend("topright",
lty=c(1,1,3,3),
col=c(1,2,2,1),
bty="n",
legend=c(
paste("(1) Closed cases : ", round(100*covid.2019.ru.d.dyn.tt$DEAD.CS[nrow(covid.2019.ru.d.dyn.tt)]/(covid.2019.ru.r.dyn.tt$RECOVERED.CS[nrow(covid.2019.ru.r.dyn.tt)] + covid.2019.ru.d.dyn.tt$DEAD.CS[nrow(covid.2019.ru.d.dyn.tt)])
, 2), "% for now", sep=""),
paste("(2) All cases : ", round(100*covid.2019.ru.d.dyn.tt$DEAD.CS[nrow(covid.2019.ru.d.dyn.tt)]/covid.2019.ru.i.dyn.tt$RUS.CS[nrow(covid.2019.ru.i.dyn.tt)]
, 2), "% for now", sep=""),
paste("Geometric mean of (1) and (2) : ",
round(100 * sqrt(
(covid.2019.ru.d.dyn.tt$DEAD.CS[nrow(covid.2019.ru.d.dyn.tt)]/(covid.2019.ru.r.dyn.tt$RECOVERED.CS[nrow(covid.2019.ru.r.dyn.tt)] + covid.2019.ru.d.dyn.tt$DEAD.CS[nrow(covid.2019.ru.d.dyn.tt)])) *
(covid.2019.ru.d.dyn.tt$DEAD.CS[nrow(covid.2019.ru.d.dyn.tt)]/covid.2019.ru.i.dyn.tt$RUS.CS[nrow(covid.2019.ru.i.dyn.tt)])
), 2), "% for now", sep=""),
paste("Dead / geom. mean of new cases and recovered : ", round(
100*(covid.2019.ru.d.dyn.tt$DEAD[nrow(covid.2019.ru.d.dyn.tt)] / sqrt(covid.2019.ru.r.dyn.tt$RECOVERED[nrow(covid.2019.ru.r.dyn.tt)] * covid.2019.ru.i.dyn.tt$RUS[nrow(covid.2019.ru.i.dyn.tt)]))
, 2), "% for now", sep="")
)
)

abline(h=seq(0,1,.01), lty=3, col=8)

axis.POSIXct(1, 
at=seq(min(covid.2019.breaks$TIME), max(covid.2019.breaks$TIME), by="week"), 
format = "%Y-%m-%d", 
las=2)
axis(2)

dev.off()

# Density maps

ru.shape <- readOGR("../misc/ESRI.shapefile")

png("../plots/13.COVID.2019.map.density.regions.per_100K.png", height=750, width=1000, res=120, pointsize=10)
par(fg="white", bg=rgb(0,.1,.2,1))

plot(ru.shape, xlim=c(20,180), col="white", border="white")
plot(ru.shape, xlim=c(20,180), 
col=rgb(1,.6,0,(covid.2019.ru.i.reg.df.dm_sorted$PER.100K/max(covid.2019.ru.i.reg.df.dm_sorted$PER.100K))^(1/4)), 
border=rgb(1,.6,0,(covid.2019.ru.i.reg.df.dm_sorted$PER.100K/max(covid.2019.ru.i.reg.df.dm_sorted$PER.100K))^(1/4)), 
add=TRUE)

mtext(paste("Total COVID-2019 cases per 100K, as of",covid.2019.ru.i$TIMESTAMP[length(covid.2019.ru.i$TIMESTAMP)]), 
side=1, line=1) 
mtext("Russian Federation", font=2, cex=1.2, side=3, line=0)

dev.off()

png("../plots/12.COVID.2019.map.density.regions.png", height=750, width=1000, res=120, pointsize=10)
par(fg="white", bg=rgb(0,.1,.2,1))

plot(ru.shape, xlim=c(20,180), col="white", border="white")
plot(ru.shape, xlim=c(20,180), 
col=rgb(1,.6,0,(covid.2019.ru.i.reg.df.dm_sorted$NUMBER/max(covid.2019.ru.i.reg.df.dm_sorted$NUMBER))^(1/4)), 
border=rgb(1,.6,0,(covid.2019.ru.i.reg.df.dm_sorted$NUMBER/max(covid.2019.ru.i.reg.df.dm_sorted$NUMBER))^(1/4)), 
add=TRUE)

mtext(paste("Total COVID-2019 cases, as of",covid.2019.ru.i$TIMESTAMP[length(covid.2019.ru.i$TIMESTAMP)]), 
side=1, line=1) 
mtext("Russian Federation", font=2, cex=1.2, side=3, line=0)

dev.off()

# png("../plots/COVID.2019.map.density.regions.rt7.png", height=750, width=1000, res=120, pointsize=10)
# par(fg="white", bg=rgb(0,.1,.2,1))
#
# plot(ru.shape, xlim=c(20,180), col="white", border="white")
# plot(ru.shape, xlim=c(20,180), 
# col=rgb(1,0,0,(covid.2019.ru.i.reg.df.dm_sorted$CS.i.diff.7/max(covid.2019.ru.i.reg.df.dm_sorted$CS.i.diff.7))^4), 
# border=rgb(1,0,0,(covid.2019.ru.i.reg.df.dm_sorted$CS.i.diff.7/max(covid.2019.ru.i.reg.df.dm_sorted$CS.i.diff.7))^4), 
# add=TRUE)
#
# mtext(paste("Total COVID-2019 cases per 100K, as of",covid.2019.ru.i$TIMESTAMP[length(covid.2019.ru.i$TIMESTAMP)]), 
# side=1, line=1) 
# mtext("Russian Federation", font=2, cex=1.2, side=3, line=0)
#
# dev.off()

png("../plots/14.1.COVID.2019.map.density.regions.rdi7dt.png", height=750, width=1000, res=120, pointsize=10)
par(fg="white", bg=rgb(0,.1,.2,1))

plot(ru.shape, xlim=c(20,180), col="white", border="white")
plot(ru.shape, xlim=c(20,180), 
col=rgb(1,0,0,(covid.2019.ru.i.reg.df.dm_sorted$CS.i.diff.7/max(covid.2019.ru.i.reg.df.dm_sorted$CS.i.diff.7))^2), 
border=rgb(1,0,0,(covid.2019.ru.i.reg.df.dm_sorted$CS.i.diff.7/max(covid.2019.ru.i.reg.df.dm_sorted$CS.i.diff.7))^2), 
add=TRUE)
plot(ru.shape, xlim=c(20,180), 
col=rgb(.05,.5,.1,(covid.2019.ru.i.reg.df.dm_sorted$CS.i.diff.7.2log/max(covid.2019.ru.i.reg.df.dm_sorted$CS.i.diff.7.2log))^(1/2)), 
border=rgb(.05,.5,.1,(covid.2019.ru.i.reg.df.dm_sorted$CS.i.diff.7.2log/max(covid.2019.ru.i.reg.df.dm_sorted$CS.i.diff.7.2log))^(1/2)), 
add=TRUE)

mtext(paste("COVID-2019 cases doubling times based on 7 days mean relative daily increment, as of",covid.2019.ru.i$TIMESTAMP[length(covid.2019.ru.i$TIMESTAMP)]), 
side=1, line=1) 
mtext("Russian Federation", font=2, cex=1.2, side=3, line=0)

dev.off()

png("../plots/14.2.COVID.2019.map.density.regions.i.7.var.png", height=750, width=1000, res=120, pointsize=10)
par(fg="white", bg=rgb(0,.1,.2,1))

plot(ru.shape, xlim=c(20,180), col="white", border="white")
plot(ru.shape, xlim=c(20,180), 
col=rgb(.3,0,0,(1-
covid.2019.ru.i.reg.df.dm_sorted$i.7.var.mean.3/max(covid.2019.ru.i.reg.df.dm_sorted$i.7.var.mean.3)
)^8
), 
border=rgb(.3,0,0,((1-
covid.2019.ru.i.reg.df.dm_sorted$i.7.var.mean.3/max(covid.2019.ru.i.reg.df.dm_sorted$i.7.var.mean.3)
)^8)/4
), 
add=TRUE)

mtext(paste("COVID-2019 cases likely smoothed, as of",covid.2019.ru.i$TIMESTAMP[length(covid.2019.ru.i$TIMESTAMP)]), 
side=1, line=1) 
mtext("Russian Federation", font=2, cex=1.2, side=3, line=0)

dev.off()


# png("../plots/COVID.2019.map.density.regions.rt7dt.01.png", height=750, width=1000, res=120, pointsize=10)
# par(fg="white", bg=rgb(0,.1,.2,1))
#
# plot(ru.shape, xlim=c(20,180), col="white", border="white")
# plot(ru.shape, xlim=c(20,180), 
# col=rgb(
# (covid.2019.ru.i.reg.df.dm_sorted$CS.i.diff.7/max(covid.2019.ru.i.reg.df.dm_sorted$CS.i.diff.7))^2,
# (covid.2019.ru.i.reg.df.dm_sorted$CS.i.diff.7.2log/max(covid.2019.ru.i.reg.df.dm_sorted$CS.i.diff.7.2log))^(1/2),
# 0,
# 1), 
# border=rgb(
# (covid.2019.ru.i.reg.df.dm_sorted$CS.i.diff.7/max(covid.2019.ru.i.reg.df.dm_sorted$CS.i.diff.7))^2,
# (covid.2019.ru.i.reg.df.dm_sorted$CS.i.diff.7.2log/max(covid.2019.ru.i.reg.df.dm_sorted$CS.i.diff.7.2log))^(1/2),
# 0,
# 1), 
# add=TRUE)
#
# mtext(paste("COVID-2019 cases doubling times based on 7 days mean RDI, as of",covid.2019.ru.i$TIMESTAMP[length(covid.2019.ru.i$TIMESTAMP)]), 
# side=1, line=1) 
# mtext("Russian Federation", font=2, cex=1.2, side=3, line=0)
#
# dev.off()

rm(ru.shape)

png("../plots/90.COVID.2019.SPb.i_smooth.png", height=750, width=1000, res=120, pointsize=10)
par(mar=c(6,5,4,2)+.1)

plot(covid.2019.ru.dyn.tot$"St. Petersburg"$TIME, covid.2019.ru.dyn.tot$"St. Petersburg"$i, type="h", col="darkred", xlab="", ylab="COVID-2019 confirmed per day, cases", main="Russian Federation / St. Petersburg", axes=FALSE)
lines(covid.2019.ru.dyn.tot$"St. Petersburg"$TIME, covid.2019.ru.dyn.tot$"St. Petersburg"$i.7, lwd=3, col="white")
lines(covid.2019.ru.dyn.tot$"St. Petersburg"$TIME, covid.2019.ru.dyn.tot$"St. Petersburg"$i.7, col="red")
axis.POSIXct(1, 
at=seq(min(covid.2019.ru.dyn.tot$"St. Petersburg"$TIME), max(covid.2019.ru.dyn.tot$"St. Petersburg"$TIME), by="week"), 
format = "%Y-%m-%d", 
las=2)
axis(2)

dev.off()

png("../plots/90.COVID.2019.SPb.d_smooth.png", height=750, width=1000, res=120, pointsize=10)
par(mar=c(6,5,4,2)+.1)

plot(covid.2019.ru.dyn.tot$"St. Petersburg"$TIME, covid.2019.ru.dyn.tot$"St. Petersburg"$d, type="h", xlab="", ylab="COVID-2019 deaths per day, cases", main="Russian Federation / St. Petersburg", axes=FALSE)
lines(covid.2019.ru.dyn.tot$"St. Petersburg"$TIME, covid.2019.ru.dyn.tot$"St. Petersburg"$d.7, lwd=3, col="white")
lines(covid.2019.ru.dyn.tot$"St. Petersburg"$TIME, covid.2019.ru.dyn.tot$"St. Petersburg"$d.7, col="red")
axis.POSIXct(1, 
at=seq(min(covid.2019.ru.dyn.tot$"St. Petersburg"$TIME), max(covid.2019.ru.dyn.tot$"St. Petersburg"$TIME), by="week"), 
format = "%Y-%m-%d", 
las=2)
axis(2)

dev.off()

png("../plots/90.COVID.2019.SPb.ratio_ir.png", height=750, width=1000, res=120, pointsize=10)
par(mar=c(6,5,4,2)+.1)

plot(
covid.2019.ru.dyn.tot$"St. Petersburg"[,1],
covid.2019.ru.dyn.tot$"St. Petersburg"[,3]/
covid.2019.ru.dyn.tot$"St. Petersburg"[,2],
type="l",
axes=FALSE,
main="Санкт-Петербург, COVID-19 (весна -- осень 2020)",
xlab="",
ylab="Отношение выздоровевшие / новые случаи")

axis.POSIXct(1, 
at=seq(min(covid.2019.ru.dyn.tot$"St. Petersburg"$TIME), max(covid.2019.ru.dyn.tot$"St. Petersburg"$TIME), by="week"), 
format = "%Y-%m-%d", 
las=2)
axis(2)

dev.off()
