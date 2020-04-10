################################################################
# Nested under:
# covid.2019.ru.main.r
# 
# requires:
# source(covid.2019.ru.data_loader.r)
# source("covid.2019.ru.data_transformations.r")

################################################################
# Basic plots

# Cumulated growth;
png("../plots/COVID.2019.cumulated.png", height=750, width=1000, res=120, pointsize=10)
par(mar=c(6,5,4,2)+.1)

plot(covid.2019.ru.i.dyn$TIME, covid.2019.ru.i.dyn$CUMSUM, type="l",
ylim=c(0, max(covid.2019.ru.i.dyn$CUMSUM)),
xlab="", 
ylab="Total COVID-2019 cases detected", 
main="Russian Federation",
axes=FALSE)

points(covid.2019.ru.i.dyn$TIME, covid.2019.ru.i.dyn$NUMBER, type="h", col=2, lwd=3)

axis.POSIXct(1, 
at=seq(min(covid.2019.breaks$TIME), max(covid.2019.breaks$TIME), by="week"), 
format = "%Y-%m-%d", 
las=2)
axis(2)

dev.off()

# Cumulated growth, by regions;

png("../plots/COVID.2019.cumulated.by_regions.png", height=750, width=1000, res=120, pointsize=10)
par(mar=c(6,5,4,2)+.1)

plot(covid.2019.ru.i.dyn.tt$TIME, covid.2019.ru.i.dyn.tt$Mos.CS, 
type="l", col=2, xlab="", 
ylab="Total COVID-2019 cases detected", 
main="Russian Federation",
axes=FALSE)

points(covid.2019.ru.i.dyn.tt$TIME, covid.2019.ru.i.dyn.tt$SPb.CS, type="l",col=4)
points(covid.2019.ru.i.dyn.tt$TIME, (covid.2019.ru.i.dyn.tt$RUS.CS - (covid.2019.ru.i.dyn.tt$Mos.CS + covid.2019.ru.i.dyn.tt$SPb.CS)), type="l",col=3)

legend("topleft", lt=1, col=c(2,4,3), legend=c("Moscow","St. Petersburg","The rest of Russia"), bty="n")

axis.POSIXct(1, 
at=seq(min(covid.2019.breaks$TIME), max(covid.2019.breaks$TIME), by="week"), 
format = "%Y-%m-%d", 
las=2)
axis(2)

dev.off()

# Cumulated growth, log scale;
png("../plots/COVID.2019.cumulated.log10.png", height=750, width=1000, res=120, pointsize=10)
par(mar=c(6,5,4,2)+.1)

plot(covid.2019.ru.i.dyn$TIME, log10(covid.2019.ru.i.dyn$CUMSUM), type="l",
ylim=c(0, max(log10(covid.2019.ru.i.dyn$CUMSUM))),
xlab="", 
ylab="Total COVID-2019 cases detected (logarithmic scale)", 
main="Russian Federation",
axes=FALSE)

points(covid.2019.ru.i.dyn$TIME, log10(covid.2019.ru.i.dyn$NUMBER), type="h", col=2, lwd=3)

axis.POSIXct(1, 
at=seq(min(covid.2019.breaks$TIME), max(covid.2019.breaks$TIME), by="week"), 
format = "%Y-%m-%d", 
las=2)
axis(2, at=log10(c(1,10,100,1000)), labels=c(1,10,100,1000))
axis(2, at=log10(c(1:9, seq(10,100,10), seq(200,1000,100), seq(2000,10000,1000))), labels=FALSE)

dev.off()

# Cumulated growth, log scale, by regions;
png("../plots/COVID.2019.cumulated.log.10.by_regions.png", height=750, width=1000, res=120, pointsize=10)
par(mar=c(6,5,4,2)+.1)

plot(covid.2019.ru.i.dyn.tt$TIME, log10(covid.2019.ru.i.dyn.tt$Mos.CS), 
type="l", col=2, 
xlab="", 
ylab="Total COVID-2019 cases detected (logarithmic scale)", 
main="Russian Federation",
axes=FALSE)

points(covid.2019.ru.i.dyn.tt$TIME, log10(covid.2019.ru.i.dyn.tt$SPb.CS), type="l",col=4)
points(covid.2019.ru.i.dyn.tt$TIME, log10(covid.2019.ru.i.dyn.tt$RUS.CS - (covid.2019.ru.i.dyn.tt$Mos.CS + covid.2019.ru.i.dyn.tt$SPb.CS)), type="l",col=3)

# rasterImage(cc.logo, 
# xleft = covid.2019.ru.i.dyn.tt$TIME[1], 
# xright=covid.2019.ru.i.dyn.tt$TIME[1]+dim(cc.logo)[2]*1200, 
# ytop = log10(100), 
# ybottom=log10(100)-dim(cc.logo)[1]/1600)

axis.POSIXct(1, 
at=seq(min(covid.2019.breaks$TIME), max(covid.2019.breaks$TIME), by="week"), 
format = "%Y-%m-%d", 
las=2)
axis(2, at=log10(c(1,10,100,1000)), labels=c(1,10,100,1000))
axis(2, at=log10(c(1:9, seq(10,100,10), seq(200,1000,100), seq(2000,10000,1000))), labels=FALSE)

legend("topleft", lt=1, col=c(2,4,3), legend=c("Moscow","St. Petersburg","The rest of Russia"), bty="n")

dev.off()

# Regions barplot;
png("../plots/COVID.2019.barplot.regions.png", height=750, width=1000, res=120, pointsize=10)
par(mar=c(10,5,4,2)+.1, cex.axis=.5)

barplot(covid.2019.ru.i.reg.ordered.df$NUMBER, 
names.arg=covid.2019.ru.i.reg.ordered.df$LOCUS, 
xlab="", 
ylab=paste("Total COVID-2019 cases, as of",covid.2019.ru.i$TIMESTAMP[length(covid.2019.ru.i$TIMESTAMP)]), 
main="Russian Federation",
las=2)

dev.off()

# Regions barplot logarithmic;
png("../plots/COVID.2019.barplot.regions.log.10.png", height=750, width=1000, res=120, pointsize=10)
par(mar=c(10,5,4,2)+.1, cex.axis=.5)

barplot(log10(covid.2019.ru.i.reg.ordered.df$NUMBER), 
names.arg=covid.2019.ru.i.reg.ordered.df$LOCUS, 
xlab="", 
ylab=paste("Total COVID-2019 cases, as of",covid.2019.ru.i$TIMESTAMP[length(covid.2019.ru.i$TIMESTAMP)],"(logarithmic scale)"), 
main="Russian Federation",
las=2, axes=FALSE)

axis(2, at=log10(c(1,10,100,1000)), labels=c(1,10,100,1000))
axis(2, at=log10(c(1:9, seq(10,100,10), seq(200,1000,100), seq(2000,10000,1000))), labels=FALSE)

dev.off()

# Regions barplot cases per 100K;
png("../plots/COVID.2019.barplot.regions.per_100K.png", height=750, width=1000, res=120, pointsize=10)
par(mar=c(10,5,4,2)+.1, cex.axis=.5)

barplot(covid.2019.ru.i.reg.ordered.PER.100K.df$PER.100K, 
names.arg=covid.2019.ru.i.reg.ordered.PER.100K.df$LOCUS, 
xlab="", 
ylab=paste("Total COVID-2019 cases per 100K, as of",covid.2019.ru.i$TIMESTAMP[length(covid.2019.ru.i$TIMESTAMP)]), 
main="Russian Federation",
las=2)

dev.off()

# Map total cases;
png("../plots/COVID.2019.map.regions.png", height=750, width=1000, res=120, pointsize=10)

map(region="Russia", fill=TRUE, col=8) 
mtext(paste("Total COVID-2019 cases, as of",covid.2019.ru.i$TIMESTAMP[length(covid.2019.ru.i$TIMESTAMP)]), 
side=1, line=2) 
mtext("Russian Federation", font=2, cex=1.2, side=3, line=3)

points(
covid.2019.ru.i.reg.0.df$LON, 
covid.2019.ru.i.reg.0.df$LAT, 
cex=sqrt(covid.2019.ru.i.reg.0.df$NUMBER)/4, 
pch=21, bg=2
)

dev.off()

# Map total cases per 100K;
png("../plots/COVID.2019.map.regions.per_100K.png", height=750, width=1000, res=120, pointsize=10)

map(region="Russia", fill=TRUE, col=8) 
mtext(paste("Total COVID-2019 cases per 100K, as of",covid.2019.ru.i$TIMESTAMP[length(covid.2019.ru.i$TIMESTAMP)]), 
side=1, line=2) 
mtext("Russian Federation", font=2, cex=1.2, side=3, line=3)

points(
covid.2019.ru.i.reg.0.df$LON, 
covid.2019.ru.i.reg.0.df$LAT, 
cex=sqrt(covid.2019.ru.i.reg.0.df$PER.100K), 
pch=21, bg=2
)

dev.off()

# # Cumulated for 1M regional centres, log10 scale, uncut;
#
# png("../plots/COVID.2019.cumulated.log10.1M.png", height=750, width=1000, res=120, pointsize=10)
# par(mar=c(6,5,4,2)+.1)
#
# plot(covid.2019.ru.i.dyn.tt$TIME,
# log10(covid.2019.ru.i.dyn.tt$Volg.CS),
# type="n",
# ylim=c(0,
#  log10(
#   max(
#    c(
#     covid.2019.ru.i.dyn.tt$Volg.CS, 
#     covid.2019.ru.i.dyn.tt$Vrnz.CS, 
#     covid.2019.ru.i.dyn.tt$Ekb.CS, 
#     covid.2019.ru.i.dyn.tt$Kaz.CS, 
#     covid.2019.ru.i.dyn.tt$Kryr.CS, 
#     covid.2019.ru.i.dyn.tt$NNov.CS, 
#     covid.2019.ru.i.dyn.tt$Nvsb.CS, 
#     covid.2019.ru.i.dyn.tt$Omsk.CS, 
#     covid.2019.ru.i.dyn.tt$Perm.CS, 
#     covid.2019.ru.i.dyn.tt$RoD.CS, 
#     covid.2019.ru.i.dyn.tt$Sam.CS, 
#     covid.2019.ru.i.dyn.tt$Ufa.CS, 
#     covid.2019.ru.i.dyn.tt$Chlb.CS
#    )
#   )
#  )
# ),
# main="Russian Federation, \nregions with capitals of 1,000 K population and more",
# xlab="",
# ylab="Total COVID-2019 cases detected (logarithmic scale)", 
# axes=FALSE)
#
# lines(covid.2019.ru.i.dyn.tt$TIME, log10(covid.2019.ru.i.dyn.tt$Volg.CS), col=1)
# lines(covid.2019.ru.i.dyn.tt$TIME, log10(covid.2019.ru.i.dyn.tt$Vrnz.CS), col=2)
# lines(covid.2019.ru.i.dyn.tt$TIME, log10(covid.2019.ru.i.dyn.tt$Ekb.CS), col=3)
# lines(covid.2019.ru.i.dyn.tt$TIME, log10(covid.2019.ru.i.dyn.tt$Kaz.CS), col=4)
# lines(covid.2019.ru.i.dyn.tt$TIME, log10(covid.2019.ru.i.dyn.tt$Kryr.CS), col=5)
# lines(covid.2019.ru.i.dyn.tt$TIME, log10(covid.2019.ru.i.dyn.tt$NNov.CS), col=6)
# lines(covid.2019.ru.i.dyn.tt$TIME, log10(covid.2019.ru.i.dyn.tt$Nvsb.CS), col=7)
# lines(covid.2019.ru.i.dyn.tt$TIME, log10(covid.2019.ru.i.dyn.tt$Omsk.CS), col=8)
# lines(covid.2019.ru.i.dyn.tt$TIME, log10(covid.2019.ru.i.dyn.tt$Perm.CS), col=1, lty=2)
# lines(covid.2019.ru.i.dyn.tt$TIME, log10(covid.2019.ru.i.dyn.tt$RoD.CS), col=2, lty=2)
# lines(covid.2019.ru.i.dyn.tt$TIME, log10(covid.2019.ru.i.dyn.tt$Sam.CS), col=3, lty=2)
# lines(covid.2019.ru.i.dyn.tt$TIME, log10(covid.2019.ru.i.dyn.tt$Ufa.CS), col=4, lty=2)
# lines(covid.2019.ru.i.dyn.tt$TIME, log10(covid.2019.ru.i.dyn.tt$Chlb.CS), col=5, lty=2)
#
# legend(
# "topleft",
# lty=c(rep(1,8),rep(2,5)),
# col=c(1:8,1:5),
# legend=c("Volg",
# "Vrnz",
# "Ekb",
# "Kaz",
# "Kryr",
# "NNov",
# "Nvsb",
# "Omsk",
# "Perm",
# "RoD",
# "Sam",
# "Ufa",
# "Chlb"),
# bty="n"
# )
#
# axis.POSIXct(1, 
# at=seq(min(covid.2019.breaks$TIME), max(covid.2019.breaks$TIME), by="week"), 
# format = "%Y-%m-%d", 
# las=2)
# axis(2, at=log10(c(1,10,100,1000)), labels=c(1,10,100,1000))
# axis(2, at=log10(c(1:9, seq(10,100,10), seq(200,1000,100), seq(2000,10000,1000))), labels=FALSE)
#
# dev.off()
#
# Cumulated for 1M regional centres, log10 scale, cut at day 36;

png("../plots/COVID.2019.cumulated.log10.1M.png", height=750, width=1000, res=120, pointsize=10)
par(mar=c(6,5,4,2)+.1, lwd=2)

plot(covid.2019.ru.i.dyn.tt$TIME[36:nrow.tt],
log10(covid.2019.ru.i.dyn.tt$Volg.CS[36:nrow.tt]),
type="n",
ylim=c(0,
 log10(
  max(
   c(
    covid.2019.ru.i.dyn.tt$Volg.CS, 
    covid.2019.ru.i.dyn.tt$Vrnz.CS, 
    covid.2019.ru.i.dyn.tt$Ekb.CS, 
    covid.2019.ru.i.dyn.tt$Kaz.CS, 
    covid.2019.ru.i.dyn.tt$Kryr.CS, 
    covid.2019.ru.i.dyn.tt$NNov.CS, 
    covid.2019.ru.i.dyn.tt$Nvsb.CS, 
    covid.2019.ru.i.dyn.tt$Omsk.CS, 
    covid.2019.ru.i.dyn.tt$Perm.CS, 
    covid.2019.ru.i.dyn.tt$RoD.CS, 
    covid.2019.ru.i.dyn.tt$Sam.CS, 
    covid.2019.ru.i.dyn.tt$Ufa.CS, 
    covid.2019.ru.i.dyn.tt$Chlb.CS
   )
  )
 )
),
main="Russian Federation, \nregions with capitals of 1,000 K population and more",
xlab="",
ylab="Total COVID-2019 cases detected (logarithmic scale)", 
axes=FALSE)

nrow.tt <- nrow(covid.2019.ru.i.dyn.tt)

lines(covid.2019.ru.i.dyn.tt$TIME[36:nrow.tt], log10(covid.2019.ru.i.dyn.tt$Volg.CS[36:nrow.tt]), col=1)
lines(covid.2019.ru.i.dyn.tt$TIME[36:nrow.tt], log10(covid.2019.ru.i.dyn.tt$Vrnz.CS[36:nrow.tt]), col=2)
lines(covid.2019.ru.i.dyn.tt$TIME[36:nrow.tt], log10(covid.2019.ru.i.dyn.tt$Ekb.CS[36:nrow.tt]), col=3)
lines(covid.2019.ru.i.dyn.tt$TIME[36:nrow.tt], log10(covid.2019.ru.i.dyn.tt$Kaz.CS[36:nrow.tt]), col=4)
lines(covid.2019.ru.i.dyn.tt$TIME[36:nrow.tt], log10(covid.2019.ru.i.dyn.tt$Kryr.CS[36:nrow.tt]), col=5)
lines(covid.2019.ru.i.dyn.tt$TIME[36:nrow.tt], log10(covid.2019.ru.i.dyn.tt$NNov.CS[36:nrow.tt]), col=6)
lines(covid.2019.ru.i.dyn.tt$TIME[36:nrow.tt], log10(covid.2019.ru.i.dyn.tt$Nvsb.CS[36:nrow.tt]), col=7)
lines(covid.2019.ru.i.dyn.tt$TIME[36:nrow.tt], log10(covid.2019.ru.i.dyn.tt$Omsk.CS[36:nrow.tt]), col=8)
lines(covid.2019.ru.i.dyn.tt$TIME[36:nrow.tt], log10(covid.2019.ru.i.dyn.tt$Perm.CS[36:nrow.tt]), col=1, lty=3)
lines(covid.2019.ru.i.dyn.tt$TIME[36:nrow.tt], log10(covid.2019.ru.i.dyn.tt$RoD.CS[36:nrow.tt]), col=2, lty=3)
lines(covid.2019.ru.i.dyn.tt$TIME[36:nrow.tt], log10(covid.2019.ru.i.dyn.tt$Sam.CS[36:nrow.tt]), col=3, lty=3)
lines(covid.2019.ru.i.dyn.tt$TIME[36:nrow.tt], log10(covid.2019.ru.i.dyn.tt$Ufa.CS[36:nrow.tt]), col=4, lty=3)
lines(covid.2019.ru.i.dyn.tt$TIME[36:nrow.tt], log10(covid.2019.ru.i.dyn.tt$Chlb.CS[36:nrow.tt]), col=5, lty=3)

legend(
"topleft",
lty=c(rep(1,8),rep(3,5)),
col=c(1:8,1:5),
legend=c("Volg",
"Vrnz",
"Ekb",
"Kaz",
"Kryr",
"NNov",
"Nvsb",
"Omsk",
"Perm",
"RoD",
"Sam",
"Ufa",
"Chlb"),
bty="n"
)

axis.POSIXct(1, 
at=seq(min(covid.2019.breaks$TIME), max(covid.2019.breaks$TIME), by="week"), 
format = "%Y-%m-%d", 
las=2)
axis(2, at=log10(c(1,10,100,1000)), labels=c(1,10,100,1000))
axis(2, at=log10(c(1:9, seq(10,100,10), seq(200,1000,100), seq(2000,10000,1000))), labels=FALSE)


dev.off()

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
