# This is an analytic script assessing distribution of final digits in some control numbers;
# Requires covid.2019.ru.main.r

incr.ru.20200317_ <- covid.2019.ru.i.dyn.tt[47:nrow(covid.2019.ru.i.dyn.tt),2]
incr.ru.20200420_ <- covid.2019.ru.i.dyn.tt[81:nrow(covid.2019.ru.i.dyn.tt),2]

incr.all <- NULL
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
CS.all.10 <- subset(CS.all, CS.all > 9)
incr.all.20200420_.10 <- subset(incr.all.20200420_, incr.all.20200420_ > 9)
CS.all.20200420_.10 <- subset(CS.all.20200420_, CS.all.20200420_ > 9)

incr.all.1.lastone <- as.numeric(gsub("^.*(?=[0-9])", "", perl=TRUE, incr.all.1))
CS.all.1.lastone <- as.numeric(gsub("^.*(?=[0-9])", "", perl=TRUE, CS.all.1))
incr.all.20200420_.1.lastone <- as.numeric(gsub("^.*(?=[0-9])", "", perl=TRUE, incr.all.20200420_.1))
CS.all.20200420_.1.lastone <- as.numeric(gsub("^.*(?=[0-9])", "", perl=TRUE, incr.all.20200420_.1))
incr.ru.20200317_.lastone <- as.numeric(gsub("^.*(?=[0-9])", "", perl=TRUE, incr.ru.20200317_))
incr.ru.20200420_.lastone <- as.numeric(gsub("^.*(?=[0-9])", "", perl=TRUE, incr.ru.20200420_))

incr.all.10.lasttwo <- as.numeric(gsub("^.*(?=[0-9][0-9])", "", perl=TRUE, incr.all.10))
incr.all.90.lasttwo <- as.numeric(gsub("^.*(?=[0-9][0-9])", "", perl=TRUE, incr.all.90))
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

png("../plots/COVID.2019.increments.hist.png", height=500, width=1000, res=120, pointsize=10)
par(mfrow=c(1,2), mar=c(6,5,4,2)+.1, lwd=2)
hist(incr.all.10, col=1, breaks=.5:(max(incr.all.10)+.5), xlab="Daily increments > 10", main="Russia")
hist(incr.all.10, col=1, breaks=.5:(max(incr.all.10)+.5), xlim=c(0,500), xlab="Daily increments > 10, truncated at 500", main="Russia")
dev.off()

png("../plots/COVID.2019.increments.lasttwo.hist.png", height=500, width=1000, res=120, pointsize=10)
par(mfrow=c(1,2), mar=c(6,5,4,2)+.1, lwd=2)
hist(incr.all.10.lasttwo, breaks=-.5:99.5, col=1, xlab="All daily increments > 10, last two digits", main="Russia")
abline(h=length(incr.all.10.lasttwo)/length(-.5:99.5), col=2, lty=3)

hist(incr.all.90.lasttwo, breaks=-.5:99.5, col=1, xlab="All daily increments > 90, last two digits", main="Russia")
abline(h=length(incr.all.90.lasttwo)/length(-.5:99.5), col=2, lty=3)
dev.off()
