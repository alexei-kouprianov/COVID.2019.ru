# This is an analytic script assessing distribution of final digits in some control numbers;
# Requires covid.2019.ru.main.r

incr.ru.20200317_ <- covid.2019.ru.i.dyn.tt[47:nrow(covid.2019.ru.i.dyn.tt),2]
incr.ru.20200420_ <- covid.2019.ru.i.dyn.tt[81:nrow(covid.2019.ru.i.dyn.tt),2]

incr.all <- NULL
incr.i <- NULL
incr.r <- NULL
incr.d <- NULL
CS.all <- NULL

for(i in 1:length(covid.2019.ru.dyn.tot)){
incr.all <- c(
 incr.all, 
 c(
  covid.2019.ru.dyn.tot[[i]]$i, 
  covid.2019.ru.dyn.tot[[i]]$r, 
  covid.2019.ru.dyn.tot[[i]]$d
 )
)
CS.all <- c(
 CS.all, 
 c(
  covid.2019.ru.dyn.tot[[i]]$CS.i, 
  covid.2019.ru.dyn.tot[[i]]$CS.r, 
  covid.2019.ru.dyn.tot[[i]]$CS.d
 )
)
incr.i <- c(incr.i, covid.2019.ru.dyn.tot[[i]]$i[36:nrow(covid.2019.ru.dyn.tot[[i]])]) 
incr.r <- c(incr.r, covid.2019.ru.dyn.tot[[i]]$r[36:nrow(covid.2019.ru.dyn.tot[[i]])])
incr.d <- c(incr.d, covid.2019.ru.dyn.tot[[i]]$d[36:nrow(covid.2019.ru.dyn.tot[[i]])])
}

##

incr.all.20200420_ <- NULL
CS.all.20200420_ <- NULL

for(i in 1:length(covid.2019.ru.dyn.tot)){
incr.all.20200420_ <- c(
 incr.all, 
 c(
  covid.2019.ru.dyn.tot[[i]]$i[81:nrow(covid.2019.ru.dyn.tot[[i]])], 
  covid.2019.ru.dyn.tot[[i]]$r[81:nrow(covid.2019.ru.dyn.tot[[i]])], 
  covid.2019.ru.dyn.tot[[i]]$d[81:nrow(covid.2019.ru.dyn.tot[[i]])]
 )
)
CS.all.20200420_ <- c(
 CS.all, 
 c(
  covid.2019.ru.dyn.tot[[i]]$CS.i[81:nrow(covid.2019.ru.dyn.tot[[i]])], 
  covid.2019.ru.dyn.tot[[i]]$CS.r[81:nrow(covid.2019.ru.dyn.tot[[i]])], 
  covid.2019.ru.dyn.tot[[i]]$CS.d[81:nrow(covid.2019.ru.dyn.tot[[i]])]
 )
)
}

incr.all.1 <- subset(incr.all, incr.all > 0)
CS.all.1 <- subset(CS.all, CS.all > 0)
incr.all.20200420_.1 <- subset(incr.all.20200420_, incr.all.20200420_ > 0)
CS.all.20200420_.1 <- subset(CS.all.20200420_, CS.all.20200420_ > 0)

incr.all.10 <- subset(incr.all, incr.all > 9)
incr.all.90 <- subset(incr.all, incr.all > 89)

incr.i.10 <- subset(incr.i, incr.i > 9)
incr.r.10 <- subset(incr.r, incr.i > 9)

incr.i.90 <- subset(incr.i, incr.i > 89)
incr.r.90 <- subset(incr.r, incr.i > 89)

incr.i.100 <- subset(incr.i, incr.i > 99)
incr.r.100 <- subset(incr.r, incr.i > 99)

CS.all.10 <- subset(CS.all, CS.all > 9)
incr.all.20200420_.10 <- subset(incr.all.20200420_, incr.all.20200420_ > 9)
CS.all.20200420_.10 <- subset(CS.all.20200420_, CS.all.20200420_ > 9)

incr.all.1.lastone <- as.numeric(gsub("^.*(?=[0-9])", "", perl=TRUE, incr.all.1))
incr.all.10.lastone <- as.numeric(gsub("^.*(?=[0-9])", "", perl=TRUE, incr.all.10))
incr.all.90.lastone <- as.numeric(gsub("^.*(?=[0-9])", "", perl=TRUE, incr.all.90))
incr.i.10.lastone <- as.numeric(gsub("^.*(?=[0-9])", "", perl=TRUE, incr.i.10))
incr.i.90.lastone <- as.numeric(gsub("^.*(?=[0-9])", "", perl=TRUE, incr.i.90))
incr.i.100.lastone <- as.numeric(gsub("^.*(?=[0-9])", "", perl=TRUE, incr.i.100))
incr.r.10.lastone <- as.numeric(gsub("^.*(?=[0-9])", "", perl=TRUE, incr.r.10))
incr.r.90.lastone <- as.numeric(gsub("^.*(?=[0-9])", "", perl=TRUE, incr.r.90))
incr.r.100.lastone <- as.numeric(gsub("^.*(?=[0-9])", "", perl=TRUE, incr.r.100))
CS.all.1.lastone <- as.numeric(gsub("^.*(?=[0-9])", "", perl=TRUE, CS.all.1))
incr.all.20200420_.1.lastone <- as.numeric(gsub("^.*(?=[0-9])", "", perl=TRUE, incr.all.20200420_.1))
CS.all.20200420_.1.lastone <- as.numeric(gsub("^.*(?=[0-9])", "", perl=TRUE, incr.all.20200420_.1))
incr.ru.20200317_.lastone <- as.numeric(gsub("^.*(?=[0-9])", "", perl=TRUE, incr.ru.20200317_))
incr.ru.20200420_.lastone <- as.numeric(gsub("^.*(?=[0-9])", "", perl=TRUE, incr.ru.20200420_))

incr.all.10.lasttwo <- as.numeric(gsub("^.*(?=[0-9][0-9])", "", perl=TRUE, incr.all.10))
incr.all.90.lasttwo <- as.numeric(gsub("^.*(?=[0-9][0-9])", "", perl=TRUE, incr.all.90))
incr.i.10.lasttwo <- as.numeric(gsub("^.*(?=[0-9][0-9])", "", perl=TRUE, incr.i.10))
incr.i.90.lasttwo <- as.numeric(gsub("^.*(?=[0-9][0-9])", "", perl=TRUE, incr.i.90))
incr.i.100.lasttwo <- as.numeric(gsub("^.*(?=[0-9][0-9])", "", perl=TRUE, incr.i.100))
incr.r.10.lasttwo <- as.numeric(gsub("^.*(?=[0-9][0-9])", "", perl=TRUE, incr.r.10))
incr.r.90.lasttwo <- as.numeric(gsub("^.*(?=[0-9][0-9])", "", perl=TRUE, incr.r.90))
incr.r.100.lasttwo <- as.numeric(gsub("^.*(?=[0-9][0-9])", "", perl=TRUE, incr.r.100))
CS.all.10.lasttwo <- as.numeric(gsub("^.*(?=[0-9][0-9])", "", perl=TRUE, CS.all.10))
incr.all.20200420_.10.lasttwo <- as.numeric(gsub("^.*(?=[0-9][0-9])", "", perl=TRUE, incr.all.20200420_.10))
CS.all.20200420_.10.lasttwo <- as.numeric(gsub("^.*(?=[0-9][0-9])", "", perl=TRUE, incr.all.20200420_.10))
incr.ru.20200317_.lasttwo <- as.numeric(gsub("^.*(?=[0-9][0-9])", "", perl=TRUE, incr.ru.20200317_))
incr.ru.20200420_.lasttwo <- as.numeric(gsub("^.*(?=[0-9][0-9])", "", perl=TRUE, incr.ru.20200420_))

# Last one digit

# All regions

chisq.test.incr.all.1.lastone <- data.frame(
chisq.test(table(incr.all.1.lastone))$observed,
chisq.test(table(incr.all.1.lastone))$expected,
chisq.test(table(incr.all.1.lastone))$stdres
)
chisq.test.incr.all.1.lastone <- chisq.test.incr.all.1.lastone[,c(1:3,5)]
colnames(chisq.test.incr.all.1.lastone) <- c("digit","observed","expected","stdres")

# All regions, since 20200420

chisq.test.incr.all.20200420_.1.lastone <- data.frame(
chisq.test(table(incr.all.20200420_.1.lastone))$observed,
chisq.test(table(incr.all.20200420_.1.lastone))$expected,
chisq.test(table(incr.all.20200420_.1.lastone))$stdres
)
chisq.test.incr.all.20200420_.1.lastone <- chisq.test.incr.all.20200420_.1.lastone[,c(1:3,5)]
colnames(chisq.test.incr.all.20200420_.1.lastone) <- c("digit","observed","expected","stdres")

# Entire Russia, since 20200317

chisq.test.incr.ru.20200317_.lastone <- data.frame(
chisq.test(table(incr.ru.20200317_.lastone))$observed,
chisq.test(table(incr.ru.20200317_.lastone))$expected,
chisq.test(table(incr.ru.20200317_.lastone))$stdres
)
chisq.test.incr.ru.20200317_.lastone <- chisq.test.incr.ru.20200317_.lastone[,c(1:3,5)]
colnames(chisq.test.incr.ru.20200317_.lastone) <- c("digit","observed","expected","stdres")

# Entire Russia, since 20200420

chisq.test.incr.ru.20200420_.lastone <- data.frame(
chisq.test(table(incr.ru.20200420_.lastone))$observed,
chisq.test(table(incr.ru.20200420_.lastone))$expected,
chisq.test(table(incr.ru.20200420_.lastone))$stdres
)
chisq.test.incr.ru.20200420_.lastone <- chisq.test.incr.ru.20200420_.lastone[,c(1:3,5)]
colnames(chisq.test.incr.ru.20200420_.lastone) <- c("digit","observed","expected","stdres")

# Last two digits

# All regions

chisq.test.incr.all.10.lasttwo <- data.frame(
chisq.test(table(incr.all.10.lasttwo))$observed,
chisq.test(table(incr.all.10.lasttwo))$expected,
chisq.test(table(incr.all.10.lasttwo))$stdres
)
chisq.test.incr.all.10.lasttwo <- chisq.test.incr.all.10.lasttwo[,c(1:3,5)]
colnames(chisq.test.incr.all.10.lasttwo) <- c("digit","observed","expected","stdres")

# incr.all.90.lasttwo

chisq.test.incr.all.90.lasttwo <- data.frame(
chisq.test(table(incr.all.90.lasttwo))$observed,
chisq.test(table(incr.all.90.lasttwo))$expected,
chisq.test(table(incr.all.90.lasttwo))$stdres
)
chisq.test.incr.all.90.lasttwo <- chisq.test.incr.all.90.lasttwo[,c(1:3,5)]
colnames(chisq.test.incr.all.90.lasttwo) <- c("digit","observed","expected","stdres")

# All regions, since 20200420

chisq.test.incr.all.20200420_.1.lasttwo <- data.frame(
chisq.test(table(incr.all.20200420_.1.lasttwo))$observed,
chisq.test(table(incr.all.20200420_.1.lasttwo))$expected,
chisq.test(table(incr.all.20200420_.1.lasttwo))$stdres
)
chisq.test.incr.all.20200420_.1.lasttwo <- chisq.test.incr.all.20200420_.1.lasttwo[,c(1:3,5)]
colnames(chisq.test.incr.all.20200420_.1.lasttwo) <- c("digit","observed","expected","stdres")

dir.create("../plots/analytic")

png("../plots/analytic/COVID.2019.increments.hist.png", height=500, width=1000, res=120, pointsize=10)
par(mfrow=c(1,2), mar=c(6,5,4,2)+.1)
hist(incr.all.10, col=1, breaks=.5:(max(incr.all.10)+.5), xlab="Daily increments 10 and more", main="Russia")
hist(incr.all.10, col=1, breaks=.5:(max(incr.all.10)+.5), xlim=c(0,500), xlab="Daily increments > 10, truncated at 500", main="Russia")
dev.off()

png("../plots/analytic/COVID.2019.increments.lasttwo.hist.png", height=500, width=1000, res=120, pointsize=10)
par(mfrow=c(1,2), mar=c(6,5,4,2)+.1)
hist(incr.all.10.lasttwo, breaks=-.5:99.5, col=1, xlab="All daily increments 10 and more, last two digits", main="Russia")
abline(h=length(incr.all.10.lasttwo)/length(-.5:99.5), col=2, lty=3)

hist(incr.all.90.lasttwo, breaks=-.5:99.5, col=1, xlab="All daily increments 90 and more, last two digits", main="Russia")
abline(h=length(incr.all.90.lasttwo)/length(-.5:99.5), col=2, lty=3)
dev.off()

png("../plots/analytic/COVID.2019.increments.lastone.hist.png", height=500, width=1000, res=120, pointsize=10)
par(mfrow=c(1,2), mar=c(6,5,4,2)+.1)

hist(incr.all.10.lastone, breaks=-.5:9.5, col=8, xlab="All daily increments 10 and more, last digit", main="Russia")
abline(h=length(incr.all.10.lastone)/length(-.5:9.5), col=2, lty=3)

hist(incr.all.90.lastone, breaks=-.5:9.5, col=8, xlab="All daily increments 90 and more, last digit", main="Russia")
abline(h=length(incr.all.90.lastone)/length(-.5:9.5), col=2, lty=3)
dev.off()


png("../plots/analytic/COVID.2019.increments.IRD.lasttwo.hist.png", height=1000, width=1500, res=120, pointsize=14)
par(mfrow=c(2,3), mar=c(6,5,4,2)+.1)

hist(incr.i.10.lasttwo, breaks=-.5:99.5, col=1, xlab="Confirmed cases, daily increments 10 and more, last two digits", main="Russia / Confirmed")
abline(h=length(incr.i.10.lasttwo)/length(-.5:99.5), col=2, lty=3)
hist(incr.i.90.lasttwo, breaks=-.5:99.5, col=1, xlab="Confirmed cases, daily increments 90 and more, last two digits", main="Russia / Confirmed")
abline(h=length(incr.i.90.lasttwo)/length(-.5:99.5), col=2, lty=3)
hist(incr.i.100.lasttwo, breaks=-.5:99.5, col=1, xlab="Confirmed cases, daily increments 100 and more, last two digits", main="Russia / Confirmed")
abline(h=length(incr.i.100.lasttwo)/length(-.5:99.5), col=2, lty=3)

hist(incr.r.10.lasttwo, breaks=-.5:99.5, col=1, xlab="Recovered, daily increments 10 and more, last two digits", main="Russia / Recovered")
abline(h=length(incr.r.10.lasttwo)/length(-.5:99.5), col=2, lty=3)
hist(incr.r.90.lasttwo, breaks=-.5:99.5, col=1, xlab="Recovered, daily increments 90 and more, last two digits", main="Russia / Recovered")
abline(h=length(incr.r.90.lasttwo)/length(-.5:99.5), col=2, lty=3)
hist(incr.r.100.lasttwo, breaks=-.5:99.5, col=1, xlab="Recovered, daily increments 100 and more, last two digits", main="Russia / Recovered")
abline(h=length(incr.r.100.lasttwo)/length(-.5:99.5), col=2, lty=3)

dev.off()

png("../plots/analytic/COVID.2019.increments.IRD.lastone.hist.png", height=1000, width=1500, res=120, pointsize=14)
par(mfrow=c(2,3), mar=c(6,5,4,2)+.1)

hist(incr.i.10.lastone, breaks=-.5:9.5, col=8, xlab="Confirmed cases, daily increments 10 and more, last digit", main="Russia / Confirmed")
abline(h=length(incr.i.10.lastone)/length(-.5:9.5), col=2, lty=3)
hist(incr.i.90.lastone, breaks=-.5:9.5, col=8, xlab="Confirmed cases, daily increments 90 and more, last digit", main="Russia / Confirmed")
abline(h=length(incr.i.90.lastone)/length(-.5:9.5), col=2, lty=3)
hist(incr.i.100.lastone, breaks=-.5:9.5, col=8, xlab="Confirmed cases, daily increments 100 and more, last digit", main="Russia / Confirmed")
abline(h=length(incr.i.100.lastone)/length(-.5:9.5), col=2, lty=3)

hist(incr.r.10.lastone, breaks=-.5:9.5, col=8, xlab="Recovered, daily increments 10 and more, last digit", main="Russia / Recovered")
abline(h=length(incr.r.10.lastone)/length(-.5:9.5), col=2, lty=3)
hist(incr.r.90.lastone, breaks=-.5:9.5, col=8, xlab="Recovered, daily increments 90 and more, last digit", main="Russia / Recovered")
abline(h=length(incr.r.90.lastone)/length(-.5:9.5), col=2, lty=3)
hist(incr.r.100.lastone, breaks=-.5:9.5, col=8, xlab="Recovered, daily increments 100 and more, last digit", main="Russia / Recovered")
abline(h=length(incr.r.100.lastone)/length(-.5:9.5), col=2, lty=3)

dev.off()

# chisq.test(table(incr.all.90.lastone))

png("../plots/analytic/COVID.2019.increments.IRD.hist.png", height=1000, width=1500, res=120, pointsize=14)
par(mfrow=c(2,3), mar=c(6,5,4,2)+.1)

hist(incr.i, breaks=-.5:(max(incr.i)+.5), col=1, main="Russia / Confirmed", xlab="Confirmed cases daily")
hist(incr.r, breaks=-.5:(max(incr.r)+.5), col=1, main="Russia / Recovered", xlab="Recovered daily")
hist(incr.d, breaks=-.5:(max(incr.d)+.5), col=1, main="Russia / Deaths", xlab="Deaths daily")

hist(incr.i, breaks=-.5:(max(incr.i)+.5), xlim=c(0,250), ylim=c(0,1000), col=1, main="Russia / Confirmed, truncated at 250x1000", xlab="Confirmed cases daily")
hist(incr.r, breaks=-.5:(max(incr.r)+.5), xlim=c(0,250), ylim=c(0,1000), col=1, main="Russia / Recovered, truncated at 250x1000", xlab="Recovered daily")
hist(incr.d, breaks=-.5:(max(incr.d)+.5), xlim=c(0,25), ylim=c(0,1000), col=1, main="Russia / Deaths, truncated at 25x1000", xlab="Deaths daily")

dev.off()
