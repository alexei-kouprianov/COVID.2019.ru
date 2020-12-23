################################################################
################################################################
#
# This script presents predictive extrapolations for 2nd wave 
# of COVID-19 epidemics in Russia based on daily deaths reports;
#
################################################################
################################################################

library(drc)
library(aomisc)

# requires covid.2019.ru.main.20201104.r

july.2020.base <- 3705 # This is a calculated parameter based on preliminary estimates of excessive mortality by 2020-07-31, in the public version of the script it is added as a constant for simplicity;

spb.m.d <- covid.2019.ru.dyn.tot.primary$"St. Petersburg"[184:nrow(covid.2019.ru.dyn.tot.primary$"St. Petersburg"),]
spb.m.d$d.CS <- july.2020.base + cumsum(spb.m.d$d)
spb.m.d$DAYS <- 1:nrow(spb.m.d)

spb.m.d.predict <- c(
	drm(
		spb.m.d$d.CS ~ spb.m.d$DAYS,
		fct = DRC.expoGrowth()
		)$coefficients,
	drm(
		spb.m.d$d.CS ~ spb.m.d$DAYS,
		fct = LL.4()
		)$fit$par
	)

names(spb.m.d.predict) <- c("eg.1","eg.2","ll.4.b","ll.4.c","ll.4.d","ll.4.e")

################################################################
# Polyline

spb.m.d.predict.ls <- as.list(NULL)

for(i in 31:nrow(spb.m.d)){
spb.m.d.predict.ls[[i]] <- c(
	drm(
		spb.m.d$d.CS[1:i] ~ spb.m.d$DAYS[1:i],
		fct = DRC.expoGrowth()
		)$coefficients,
	drm(
		spb.m.d$d.CS[1:i] ~ spb.m.d$DAYS[1:i],
		fct = LL.4()
		)$fit$par
	)
names(spb.m.d.predict.ls[[i]]) <- c("eg.1","eg.2","ll.4.b","ll.4.c","ll.4.d","ll.4.e")
}

################################################################
# Deaths cumulated fitted / logarythmic
################################################################

png("../plots/95.1.COVID.2019.fitting.rmc.SPb.d.log10.png", height=750, width=1000, res=120, pointsize=10)
par(mar=c(6,5,4,2)+.1)

plot(log10(spb.m.d$d.CS) ~ spb.m.d$DAYS, 
type="n", 
xlim=c(0,max(spb.m.d$DAYS)*2),
ylim=c(log10(min(spb.m.d$d.CS)), log10(10000)),
main=paste("Russian Federation / St. Petersburg /", spb.m.d$TIME[nrow(spb.m.d)]),
xlab="Days since 2020-07-31",
ylab="Deaths registered since 2020-07-31 (logarythmic)",
axes=FALSE
)

rect(
xleft=c(
	0, # August;
	(0+31+30), # October;
	(0+31+30+31+30), # December;
	(0+31+30+31+30+31+31), # February;
	(0+31+30+31+30+31+31+28+31) # April;
),
xright=c(
	(0+31), # August;
	(0+31+30+31), # October;
	(0+31+30+31+30+31), # December;
	(0+31+30+31+30+31+31+28), # February;
	(0+31+30+31+30+31+31+28+31+30) # April;
),
ybottom=rep(-10,3),
ytop=rep(8,3),
col=rgb(0,0,0,.05), border=rgb(0,0,0,.01)
)

for(i in 31:nrow(spb.m.d)){
curve(log10(spb.m.d.predict.ls[[i]]["eg.1"]*exp((x)*spb.m.d.predict.ls[[i]]["eg.2"])), col=rgb(1,0,0,.1), lwd=1, add=TRUE)
curve(log10(spb.m.d.predict.ls[[i]]["ll.4.c"] + (spb.m.d.predict.ls[[i]]["ll.4.d"]-spb.m.d.predict.ls[[i]]["ll.4.c"])/(1+exp(spb.m.d.predict.ls[[i]]["ll.4.b"]*(log((x)/spb.m.d.predict.ls[[i]]["ll.4.e"]))))), col=rgb(0,0,1,.1), lwd=1, add=TRUE)
abline(v=spb.m.d.predict.ls[[i]]["ll.4.e"], col=rgb(0,0,1,.1), lwd=1.5)
}

curve(log10(spb.m.d.predict["ll.4.c"] + (spb.m.d.predict["ll.4.d"]-spb.m.d.predict["ll.4.c"])/(1+exp(spb.m.d.predict["ll.4.b"]*(log((x)/spb.m.d.predict["ll.4.e"]))))), col=rgb(0,0,1,1), lwd=1.5, lty=5, add=TRUE)
abline(v=spb.m.d.predict["ll.4.e"], col=rgb(0,0,1,1), lwd=1.5, lty=5)
curve(log10(spb.m.d.predict["eg.1"]*exp((x)*spb.m.d.predict["eg.2"])), col=rgb(1,0,0,1), lwd=1.5, lty=5, add=TRUE)

points(log10(spb.m.d$d.CS) ~ spb.m.d$DAYS, 
pch=21, col="white", bg=rgb(0,0,0,.3))

axis(1)
axis(2, at=log10(10^(0:6)), labels=c("1","10","100","1K","10K","100K","1000K"))
axis(2, at=log10(seq(2000,9000,1000)), labels=paste(2:9, "K", sep=""))

dev.off()

################################################################
# Deaths cumulated fitted / linear
################################################################

png("../plots/95.3.COVID.2019.fitting.rmc.SPb.d.png", height=750, width=1000, res=120, pointsize=10)
par(mar=c(6,5,4,2)+.1)

plot(spb.m.d$d.CS ~ spb.m.d$DAYS, 
type="n", 
xlim=c(0,max(spb.m.d$DAYS)*2),
ylim=c(0,max(spb.m.d$d.CS)*2),
main=paste("Russian Federation / St. Petersburg /", spb.m.d$TIME[nrow(spb.m.d)]),
xlab="Days since 2020-07-31",
ylab="Deaths registered since 2020-07-31",
axes=FALSE
)

rect(
xleft=c(
	0, # August;
	(0+31+30), # October;
	(0+31+30+31+30), # December;
	(0+31+30+31+30+31+31), # February;
	(0+31+30+31+30+31+31+28+31) # April;
),
xright=c(
	(0+31), # August;
	(0+31+30+31), # October;
	(0+31+30+31+30+31), # December;
	(0+31+30+31+30+31+31+28), # February;
	(0+31+30+31+30+31+31+28+31+30) # April;
),
ybottom=rep(-10, 3),
ytop=rep(max(spb.m.d$d.CS)*3, 3),
col=rgb(0, 0, 0, .05), border=rgb(0, 0, 0, .01)
)


for(i in 31:nrow(spb.m.d)){
curve(spb.m.d.predict.ls[[i]]["ll.4.c"] + (spb.m.d.predict.ls[[i]]["ll.4.d"]-spb.m.d.predict.ls[[i]]["ll.4.c"])/(1+exp(spb.m.d.predict.ls[[i]]["ll.4.b"]*(log((x)/spb.m.d.predict.ls[[i]]["ll.4.e"])))), col=rgb(0,0,1,.1), lwd=1, add=TRUE)
abline(v=spb.m.d.predict.ls[[i]]["ll.4.e"], col=rgb(0,0,1,.1), lwd=1.5)
curve(spb.m.d.predict.ls[[i]]["eg.1"]*exp((x)*spb.m.d.predict.ls[[i]]["eg.2"]), col=rgb(1,0,0,.1), lwd=1, add=TRUE)
}

curve(spb.m.d.predict["ll.4.c"] + (spb.m.d.predict["ll.4.d"]-spb.m.d.predict["ll.4.c"])/(1+exp(spb.m.d.predict["ll.4.b"]*(log((x)/spb.m.d.predict["ll.4.e"])))), col=rgb(0,0,1,1), lwd=1.5, lty=5, add=TRUE)
abline(v=spb.m.d.predict["ll.4.e"], col=rgb(0,0,1,1), lwd=1.5, lty=5)
curve(spb.m.d.predict["eg.1"]*exp((x)*spb.m.d.predict["eg.2"]), col=rgb(1,0,0,1), lwd=1.5, lty=5, add=TRUE)

points(spb.m.d$d.CS ~ spb.m.d$DAYS, 
pch=21, col="white", bg=rgb(0,0,0,.05))

axis(1)
axis(2)

dev.off()

################################################################
# Animated graphs
################################################################

dir.create("../plots/mpg/d.log/", recursive=TRUE)

################################################################
# Deaths cumulated fitted / logarythmic
################################################################

for(i in 31:nrow(spb.m.d)){

if(i-30 <= 9){
png(file=paste("../plots/mpg/d.log/95.1.COVID.2019.fitting.rmc.SPb.d.log10.00",i-30,".png", sep=""), height=750, width=1000, res=120, pointsize=10)
} else if(i-30 <= 99){
png(file=paste("../plots/mpg/d.log/95.1.COVID.2019.fitting.rmc.SPb.d.log10.0",i-30,".png", sep=""), height=750, width=1000, res=120, pointsize=10)
} else{
png(file=paste("../plots/mpg/d.log/95.1.COVID.2019.fitting.rmc.SPb.d.log10.",i-30,".png", sep=""), height=750, width=1000, res=120, pointsize=10)
}
par(mar=c(6,5,4,2)+.1)

plot(log10(spb.m.d$d.CS) ~ spb.m.d$DAYS, 
type="n", 
xlim=c(0,max(spb.m.d$DAYS)*2),
ylim=c(log10(min(spb.m.d$d.CS)), log10(10000)),
main=paste("Russian Federation / St. Petersburg /", spb.m.d$TIME[i]),
xlab="Days since 2020-07-31",
ylab="Deaths registered since 2020-07-31 (logarythmic)",
axes=FALSE
)

rect(
xleft=c(
	0, # August;
	(0+31+30), # October;
	(0+31+30+31+30), # December;
	(0+31+30+31+30+31+31), # February;
	(0+31+30+31+30+31+31+28+31) # April;
),
xright=c(
	(0+31), # August;
	(0+31+30+31), # October;
	(0+31+30+31+30+31), # December;
	(0+31+30+31+30+31+31+28), # February;
	(0+31+30+31+30+31+31+28+31+30) # April;
),
ybottom=rep(-10,3),
ytop=rep(8,3),
col=rgb(0,0,0,.05), border=rgb(0,0,0,.01)
)

for(j in 31:i){
curve(log10(spb.m.d.predict.ls[[j]]["eg.1"]*exp((x)*spb.m.d.predict.ls[[j]]["eg.2"])), col=rgb(1,0,0,.1), lwd=1, add=TRUE)
curve(log10(spb.m.d.predict.ls[[j]]["ll.4.c"] + (spb.m.d.predict.ls[[j]]["ll.4.d"]-spb.m.d.predict.ls[[j]]["ll.4.c"])/(1+exp(spb.m.d.predict.ls[[j]]["ll.4.b"]*(log((x)/spb.m.d.predict.ls[[j]]["ll.4.e"]))))), col=rgb(0,0,1,.1), lwd=1, add=TRUE)
abline(v=spb.m.d.predict.ls[[j]]["ll.4.e"], col=rgb(0,0,1,.1), lwd=1.5)
}

curve(log10(spb.m.d.predict.ls[[i]]["eg.1"]*exp((x)*spb.m.d.predict.ls[[i]]["eg.2"])), col=rgb(1,0,0,1), lwd=1, lty=5, add=TRUE)
curve(log10(spb.m.d.predict.ls[[i]]["ll.4.c"] + (spb.m.d.predict.ls[[i]]["ll.4.d"]-spb.m.d.predict.ls[[i]]["ll.4.c"])/(1+exp(spb.m.d.predict.ls[[i]]["ll.4.b"]*(log((x)/spb.m.d.predict.ls[[i]]["ll.4.e"]))))), col=rgb(0,0,1,1), lwd=1, lty=5, add=TRUE)
abline(v=spb.m.d.predict.ls[[i]]["ll.4.e"], col=rgb(0,0,1,1), lty=5, lwd=1.5)

points(log10(spb.m.d$d.CS[1:i]) ~ spb.m.d$DAYS[1:i], 
pch=21, col="white", bg=rgb(0,0,0,.3))

axis(1)
axis(2, at=log10(10^(0:6)), labels=c("1","10","100","1K","10K","100K","1000K"))
axis(2, at=log10(seq(2000,9000,1000)), labels=paste(2:9, "K", sep=""))

dev.off()
}

# To make an .mp4 file from a series of .png files, go to a terminal, 
# change directory to '"../plots/mpg/d.log/"' and run the following line
# (requires ffmpeg) :
#
# ffmpeg -r 2 -f image2 -s 1000x750 -i 95.1.COVID.2019.fitting.rmc.SPb.d.log10.%03d.png -vcodec libx264 -crf 25 -pix_fmt yuv420p COVID.2019.fitting.rmc.animated.d.mp4
