################################################################
# Updating folders tree
################################################################

dir.create("../plots/regions/")
dir.create("../plots/regions/linear/")
dir.create("../plots/regions/increments/")
dir.create("../plots/regions/increments/i/")
dir.create("../plots/regions/increments/d/")

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

# # Linear
#
# for(i in 1:length(covid.2019.ru.dyn.tot.primary)){
#
# png(file = paste("../plots/regions/increments/d/COVID.2019.momentary.", gsub(" ", "_", names(covid.2019.ru.dyn.tot.primary)[i]), ".d.png", sep=""), height=750, width=1000, res=120, pointsize=10)
# par(mar=c(6,5,4,5)+.1)
#
# # Insert plot here
#
# abline(v = seq(min(covid.2019.ru.dyn.tot.primary[[i]]$TIME), max(covid.2019.ru.dyn.tot.primary[[i]]$TIME), by = "month"), lty = 3, col = 8)
#
# axis(2)
#
# axis.POSIXct(1,
# at = seq(min(covid.2019.ru.dyn.tot.primary[[i]]$TIME), max(covid.2019.ru.dyn.tot.primary[[i]]$TIME), by = "week"),
# format = "%Y-%m-%d",
# las = 2)
#
# dev.off()
#
# }

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


# for(i in 1:length(levels(covid.2019.ru$LOCUS))){
#
# png(file=paste("../plots/regions/linear/COVID.2019.cumulated.linear.",gsub(" ", "_", levels(covid.2019.ru$LOCUS)[i]),".png", sep=""), height=750, width=750, res=120, pointsize=10)
# par(mar=c(6,5,4,2)+.1, lwd=2)
#
# plot(covid.2019.ru.dyn.tot[[i]]$TIME, covid.2019.ru.dyn.tot[[i]]$CS.i, 
# type="n", 
# # ylim=c(0,(max(covid.2019.ru.i.dyn.tt$RUS.CS))),
# main=paste("Russian Federation /",levels(covid.2019.ru$LOCUS)[i]),
# xlab="",
# ylab="COVID-2019 cases detected (linear scale)",
# axes=FALSE
# )
#
# for(j in 1:length(levels(covid.2019.ru$LOCUS))){
#  lines(covid.2019.ru.dyn.tot[[j]]$TIME, covid.2019.ru.dyn.tot[[j]]$CS.i, lwd=1.5, col=rgb(0,0,0,.15))
# }
#
# lines(covid.2019.ru.dyn.tot[[j]]$TIME, covid.2019.ru.dyn.tot[[i]]$i, type="h", col="darkred")
#
# lines(covid.2019.ru.dyn.tot[[j]]$TIME, covid.2019.ru.dyn.tot[[i]]$CS.i, col="white", lwd=5)
# lines(covid.2019.ru.dyn.tot[[j]]$TIME, covid.2019.ru.dyn.tot[[i]]$CS.i, col="darkred", lwd=2)
# lines(covid.2019.ru.dyn.tot[[j]]$TIME, (covid.2019.ru.dyn.tot[[i]]$CS.i-
# (covid.2019.ru.dyn.tot[[i]]$CS.r+covid.2019.ru.dyn.tot[[i]]$CS.d)
# ), col="white", lwd=4)
# lines(covid.2019.ru.dyn.tot[[j]]$TIME, (covid.2019.ru.dyn.tot[[i]]$CS.i-
# (covid.2019.ru.dyn.tot[[i]]$CS.r+covid.2019.ru.dyn.tot[[i]]$CS.d)
# ), col=2, lwd=2)
# lines(covid.2019.ru.dyn.tot[[j]]$TIME, covid.2019.ru.dyn.tot[[i]]$CS.r, col="white", lwd=5)
# lines(covid.2019.ru.dyn.tot[[j]]$TIME, covid.2019.ru.dyn.tot[[i]]$CS.r, col="darkgreen", lwd=2)
# lines(covid.2019.ru.dyn.tot[[j]]$TIME, covid.2019.ru.dyn.tot[[i]]$CS.d, col="white", lwd=5)
# lines(covid.2019.ru.dyn.tot[[j]]$TIME, covid.2019.ru.dyn.tot[[i]]$CS.d, col=1, lwd=2)
#
# abline(h=log10(50), lty=3, lwd=.75)
#
# axis.POSIXct(1, 
# at=seq(min(covid.2019.breaks$TIME), max(covid.2019.breaks$TIME), by="week"), 
# format = "%Y-%m-%d", 
# las=2)
#
# axis(2)
#
# legend(
# "topleft",
# lty=1,
# lwd=2,
# col=c("darkred","red","darkgreen","black"),
# legend=c("Total cases (vertical bars = new ones)","Active cases","Recovered","Deceased"),
# bty="n"
# )
#
# dev.off()
#
# }
