################################################################
# Nested under:
# covid.2019.ru.main.r
# 
# requires:
# source(covid.2019.ru.data_loader.r)
# source("covid.2019.ru.data_transformations.r")
#
# # For more details, read: https://cran.r-project.org/web/packages/drc/drc.pdf
# 
# # If needed, install:
# install.packages("drc")

library(drc)

# Fitting exponential and logistic growth;

covid.2019.ru.full.expoGrowth <- drm(
covid.2019.ru.i.dyn.tt$RUS.CS ~ covid.2019.ru.i.dyn.tt$DAYS, 
fct = DRC.expoGrowth()
)

covid.2019.ru.full.ll.3 <- drm(
covid.2019.ru.i.dyn.tt$RUS.CS ~ covid.2019.ru.i.dyn.tt$DAYS, 
fct = LL.3()
)

# Cutting off the initial disconnected cases;

covid.2019.ru.i.dyn.tt.short <- covid.2019.ru.i.dyn.tt[33:nrow(covid.2019.ru.i.dyn.tt),]

covid.2019.ru.i.dyn.tt.short$DAYS <- covid.2019.ru.i.dyn.tt.short$DAYS - 32
covid.2019.ru.i.dyn.tt.short$RUS.CS <- covid.2019.ru.i.dyn.tt.short$RUS.CS - 5

# Fitting exponential and logistic growth;

covid.2019.ru.short.expoGrowth <- drm(
covid.2019.ru.i.dyn.tt.short$RUS.CS ~ covid.2019.ru.i.dyn.tt.short$DAYS, 
fct = DRC.expoGrowth()
)

covid.2019.ru.short.ll.3 <- drm(
covid.2019.ru.i.dyn.tt.short$RUS.CS ~ covid.2019.ru.i.dyn.tt.short$DAYS, 
fct = LL.3()
)

# # Summarising models;
#
# summary(covid.2019.ru.full.expoGrowth)
# summary(covid.2019.ru.short.expoGrowth)
# summary(covid.2019.ru.full.ll.3)
# summary(covid.2019.ru.short.ll.3)

# Running model;

covid.2019.ru.i.dyn.tt.ts <- NULL
covid.2019.ru.i.dyn.tt.ts <- as.list(covid.2019.ru.i.dyn.tt.ts)

for(i in 33:nrow(covid.2019.ru.i.dyn.tt)){
covid.2019.ru.i.dyn.tt.ts[[i]] <- covid.2019.ru.i.dyn.tt[1:i,]
}

rmc.df <- NULL

for(i in 33:nrow(covid.2019.ru.i.dyn.tt)){

rmc.df <- rbind.data.frame(rmc.df,
c(
drm(
covid.2019.ru.i.dyn.tt.ts[[i]]$RUS.CS ~ covid.2019.ru.i.dyn.tt.ts[[i]]$DAYS, 
fct = DRC.expoGrowth()
)$coefficients,
drm(
covid.2019.ru.i.dyn.tt.ts[[i]]$RUS.CS ~ covid.2019.ru.i.dyn.tt.ts[[i]]$DAYS, 
fct = LL.3()
)$fit$par
)
)
}

colnames(rmc.df) <- c("eg.1","eg.2","ll.3.b","ll.3.d","ll.3.e")

# Control plot;

png("../plots/COVID.2019.fitting.expGrowth_vs_LL.3.png", height=750, width=1000, res=120, pointsize=10)
par(mar=c(6,5,4,2)+.1)

plot(covid.2019.ru.i.dyn.tt.short$RUS.CS ~ covid.2019.ru.i.dyn.tt.short$DAYS, 
type="n", 
# xlim=c(0,120), ylim=c(0,3.5e+4),
main="Russian Federation",
xlab="Days since 2020-03-02",
ylab="Total cases registered",
axes=FALSE
)

curve(covid.2019.ru.short.ll.3$fit$par[2]/(1+exp(covid.2019.ru.short.ll.3$fit$par[1]*(log(x/covid.2019.ru.short.ll.3$fit$par[3])))), from=0, to=120, col=4, lty=3, add=TRUE)
curve(covid.2019.ru.short.expoGrowth$coefficients[1]*exp(x*covid.2019.ru.short.expoGrowth$coefficients[2]), col=2, lty=3, add=TRUE)
curve(covid.2019.ru.full.ll.3$fit$par[2]/(1+exp(covid.2019.ru.full.ll.3$fit$par[1]*(log((x+32)/covid.2019.ru.full.ll.3$fit$par[3])))), from=0, to=120, col=4, lty=2, add=TRUE)
curve(covid.2019.ru.full.expoGrowth$coefficients[1]*exp((x+32)*covid.2019.ru.full.expoGrowth$coefficients[2]), col=2, lty=2, add=TRUE)

points(covid.2019.ru.i.dyn.tt.short$RUS.CS ~ covid.2019.ru.i.dyn.tt.short$DAYS, 
pch=21, col="white", bg=1)

axis(1)
axis(1, at=1:nrow(covid.2019.ru.i.dyn.tt.short), tcl=-.25, labels=FALSE)
axis(2)

legend("topleft", 
lty=c(2,3,2,3), 
lwd=1.5,
col=c(2,2,4,4), 
legend=c(
"Exponential (since February 1, 2020)",
"Exponential (since March 3, 2020)",
"Log-logistic (since February 1, 2020)",
"Log-logistic (since March 3, 2020)"
),
bty="n"
)

dev.off()

png("../plots/COVID.2019.fitting.expGrowth_vs_LL.3.log10.png", height=750, width=1000, res=120, pointsize=10)
par(mar=c(6,5,4,2)+.1)

plot(log10(covid.2019.ru.i.dyn.tt.short$RUS.CS) ~ covid.2019.ru.i.dyn.tt.short$DAYS, 
type="n", 
# xlim=c(0,120), ylim=c(0,3.5e+4),
main="Russian Federation",
xlab="Days since 2020-03-02",
ylab="Total cases registered (logarithmic scale)",
axes=FALSE
)

curve(log10(covid.2019.ru.short.ll.3$fit$par[2]/(1+exp(covid.2019.ru.short.ll.3$fit$par[1]*(log(x/covid.2019.ru.short.ll.3$fit$par[3]))))), from=0, to=120, col=4, lty=3, add=TRUE)
curve(log10(covid.2019.ru.short.expoGrowth$coefficients[1]*exp(x*covid.2019.ru.short.expoGrowth$coefficients[2])), col=2, lty=3, add=TRUE)
curve(log10(covid.2019.ru.full.ll.3$fit$par[2]/(1+exp(covid.2019.ru.full.ll.3$fit$par[1]*(log((x+32)/covid.2019.ru.full.ll.3$fit$par[3]))))), from=0, to=120, col=4, lty=2, add=TRUE)
curve(log10(covid.2019.ru.full.expoGrowth$coefficients[1]*exp((x+32)*covid.2019.ru.full.expoGrowth$coefficients[2])), col=2, lty=2, add=TRUE)

points(log10(covid.2019.ru.i.dyn.tt.short$RUS.CS) ~ covid.2019.ru.i.dyn.tt.short$DAYS, 
pch=21, col="white", bg=1)

axis(1)
axis(1, at=1:nrow(covid.2019.ru.i.dyn.tt.short), tcl=-.25, labels=FALSE)
axis(2, at=log10(c(1,10,100,1000,10000)), labels=c(1,10,100,1000,10000))
axis(2, at=log10(c(1:9, seq(10,100,10), seq(200,1000,100), seq(2000,10000,1000))), labels=FALSE)

legend("topleft", 
lty=c(2,3,2,3), 
lwd=1.5,
col=c(2,2,4,4), 
legend=c(
"Exponential (since February 1, 2020)",
"Exponential (since March 3, 2020)",
"Log-logistic (since February 1, 2020)",
"Log-logistic (since March 3, 2020)"
),
bty="n"
)

dev.off()

# Running model plot;

png("../plots/COVID.2019.fitting.rmc.png", height=750, width=1000, res=120, pointsize=10)
par(mar=c(6,5,4,2)+.1)

plot(covid.2019.ru.i.dyn.tt$RUS.CS ~ covid.2019.ru.i.dyn.tt$DAYS, 
type="n", 
xlim=c(0,(median(rmc.df$ll.3.e)*3)), ylim=c(0,max(rmc.df$ll.3.d)),
main="Russian Federation",
xlab="Days since 2020-01-31",
ylab="Total cases registered",
axes=FALSE
)

for(i in 1:nrow(rmc.df)){
curve(rmc.df$ll.3.d[i]/(1+exp(rmc.df$ll.3.b[i]*(log((x)/rmc.df$ll.3.e[i])))), col=rgb(0,0,1,.3), add=TRUE)
curve(rmc.df$eg.1[i]*exp((x)*rmc.df$eg.2[i]), col=rgb(1,0,0,.3), add=TRUE)
}

curve((covid.2019.ru.full.ll.3$fit$par[2]/(1+exp(covid.2019.ru.full.ll.3$fit$par[1]*(log(x/covid.2019.ru.full.ll.3$fit$par[3]))))), col=4, lwd=1.5, lty=2, add=TRUE)
curve((covid.2019.ru.full.expoGrowth$coefficients[1]*exp(x*covid.2019.ru.full.expoGrowth$coefficients[2])), col=2, lwd=1.5, lty=2, add=TRUE)
abline(v=covid.2019.ru.full.ll.3$fit$par[3], col=4, lwd=1.5, lty=2)

points(covid.2019.ru.i.dyn.tt$RUS.CS ~ covid.2019.ru.i.dyn.tt$DAYS, 
pch=21, col="white", bg=1)

axis(1)
axis(2)

dev.off()

# Running model plot, log10;

png("../plots/COVID.2019.fitting.rmc.log10.png", height=750, width=1000, res=120, pointsize=10)
par(mar=c(6,5,4,2)+.1)

plot(log10(covid.2019.ru.i.dyn.tt$RUS.CS) ~ covid.2019.ru.i.dyn.tt$DAYS, 
type="n", 
xlim=c(0,median(rmc.df$ll.3.e)*1.5), ylim=c(0,log10(max(rmc.df$ll.3.d))),
main="Russian Federation",
xlab="Days since 2020-01-31",
ylab="Total cases registered",
axes=FALSE
)

for(i in 1:nrow(rmc.df)){
curve(log10(rmc.df$ll.3.d[i]/(1+exp(rmc.df$ll.3.b[i]*(log((x)/rmc.df$ll.3.e[i]))))), col=rgb(0,0,1,.3), add=TRUE)
curve(log10(rmc.df$eg.1[i]*exp((x)*rmc.df$eg.2[i])), col=rgb(1,0,0,.3), add=TRUE)
}

curve(log10(covid.2019.ru.full.ll.3$fit$par[2]/(1+exp(covid.2019.ru.full.ll.3$fit$par[1]*(log(x/covid.2019.ru.full.ll.3$fit$par[3]))))), col=4, lwd=1.5, lty=2, add=TRUE)
curve(log10(covid.2019.ru.full.expoGrowth$coefficients[1]*exp(x*covid.2019.ru.full.expoGrowth$coefficients[2])), col=2, lwd=1.5, lty=2, add=TRUE)
abline(v=covid.2019.ru.full.ll.3$fit$par[3], col=4, lwd=1.5, lty=2)

points(log10(covid.2019.ru.i.dyn.tt$RUS.CS) ~ covid.2019.ru.i.dyn.tt$DAYS, 
pch=21, col="white", bg=1)

axis(1)
axis(2, at=log10(c(1,10,100,1000,10000,100000,1000000)), labels=c("1","10","100","1K","10K","100K","1000K"))
axis(2, at=log10(c(1:9, seq(10,100,10), seq(200,1000,100), seq(2000,10000,1000), seq(20000,100000,10000), seq(200000,1000000,100000))), labels=FALSE)

dev.off()
