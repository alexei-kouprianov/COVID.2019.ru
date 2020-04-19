################################################################
# Nested under:
# covid.2019.ru.main.r
# 
# requires:
# source(covid.2019.ru.data_loader.r)

################################################################
# Disaggregating

covid.2019.ru <- covid.2019.ru.raw[,c(1:4,6)]

covid.2019.ru.da <- NULL

for(i in 1:nrow(covid.2019.ru)){
	for(j in 1:covid.2019.ru[i,]$NUMBER){
	covid.2019.ru.da <- rbind.data.frame(covid.2019.ru.da, covid.2019.ru[i,])
	}
}

################################################################
# Trimming timestamps

covid.2019.ru$TIME <- strptime(covid.2019.ru$TIMESTAMP, "%Y-%m-%d %H:%M:%S")
covid.2019.ru.da$TIME <- strptime(covid.2019.ru.da$TIMESTAMP, "%Y-%m-%d %H:%M:%S")
covid.2019.breaks$TIME <- strptime(covid.2019.breaks$TIMESTAMP, "%Y-%m-%d %H:%M:%S")

covid.2019.ru.da <- covid.2019.ru.da[,c(2:4,6)]

################################################################
# Subsetting

# The quick from the dead
covid.2019.ru.i <- subset(covid.2019.ru, covid.2019.ru$EVENT == "detected")
covid.2019.ru.r <- subset(covid.2019.ru, covid.2019.ru$EVENT == "recovered")
covid.2019.ru.d <- subset(covid.2019.ru, covid.2019.ru$EVENT == "deceased")

covid.2019.ru.da.i <- subset(covid.2019.ru.da, covid.2019.ru.da$EVENT == "detected")
covid.2019.ru.da.r <- subset(covid.2019.ru.da, covid.2019.ru.da$EVENT == "recovered")
covid.2019.ru.da.d <- subset(covid.2019.ru.da, covid.2019.ru.da$EVENT == "deceased")

################################################################
# Data transformations

# Timeseries list;
covid.2019.ru.i.ts <- NULL
covid.2019.ru.r.ts <- NULL
covid.2019.ru.d.ts <- NULL

for(i in 1:length(levels(covid.2019.ru.i$TIMESTAMP))){
covid.2019.ru.i.ts[[i]] <- subset(covid.2019.ru.i, covid.2019.ru.i$TIMESTAMP == levels(covid.2019.ru.i$TIMESTAMP)[i])
covid.2019.ru.r.ts[[i]] <- subset(covid.2019.ru.r, covid.2019.ru.r$TIMESTAMP == levels(covid.2019.ru.r$TIMESTAMP)[i])
covid.2019.ru.d.ts[[i]] <- subset(covid.2019.ru.d, covid.2019.ru.d$TIMESTAMP == levels(covid.2019.ru.d$TIMESTAMP)[i])
}

# Noncumulated true time timeseries list;
covid.2019.ru.i.moment_ts <- NULL
covid.2019.ru.r.moment_ts <- NULL
covid.2019.ru.d.moment_ts <- NULL

for(i in 1:length(covid.2019.breaks$TIME)){
covid.2019.ru.i.moment_ts[[i]] <- subset(covid.2019.ru.da.i, covid.2019.ru.da.i$TIME < covid.2019.breaks$TIME[i] & covid.2019.ru.da.i$TIME > covid.2019.breaks$TIME[i-1])
covid.2019.ru.r.moment_ts[[i]] <- subset(covid.2019.ru.da.r, covid.2019.ru.da.r$TIME < covid.2019.breaks$TIME[i] & covid.2019.ru.da.r$TIME > covid.2019.breaks$TIME[i-1])
covid.2019.ru.d.moment_ts[[i]] <- subset(covid.2019.ru.da.d, covid.2019.ru.da.d$TIME < covid.2019.breaks$TIME[i] & covid.2019.ru.da.d$TIME > covid.2019.breaks$TIME[i-1])
}

# Cumulated true time timeseries list for a map;
covid.2019.ru.i.cumul_ts <- NULL
covid.2019.ru.r.cumul_ts <- NULL
covid.2019.ru.d.cumul_ts <- NULL

for(i in 1:length(covid.2019.breaks$TIME)){
covid.2019.ru.i.cumul_ts[[i]] <- subset(covid.2019.ru.da.i, covid.2019.ru.da.i$TIME < covid.2019.breaks$TIME[i])
covid.2019.ru.r.cumul_ts[[i]] <- subset(covid.2019.ru.da.r, covid.2019.ru.da.r$TIME < covid.2019.breaks$TIME[i])
covid.2019.ru.d.cumul_ts[[i]] <- subset(covid.2019.ru.da.d, covid.2019.ru.da.d$TIME < covid.2019.breaks$TIME[i])
}

# Barplot regions list;
covid.2019.ru.i.reg <- NULL
covid.2019.ru.r.reg <- NULL
covid.2019.ru.d.reg <- NULL

for(i in 1:length(levels(covid.2019.ru.i$LOCUS))){
covid.2019.ru.i.reg[[i]] <- subset(covid.2019.ru.i, covid.2019.ru.i$LOCUS == levels(covid.2019.ru.i$LOCUS)[i])
covid.2019.ru.r.reg[[i]] <- subset(covid.2019.ru.r, covid.2019.ru.r$LOCUS == levels(covid.2019.ru.r$LOCUS)[i])
covid.2019.ru.d.reg[[i]] <- subset(covid.2019.ru.d, covid.2019.ru.d$LOCUS == levels(covid.2019.ru.d$LOCUS)[i])
}

# Mapping regions list;
covid.2019.ru.i.reg.0 <- NULL
covid.2019.ru.r.reg.0 <- NULL
covid.2019.ru.d.reg.0 <- NULL

for(i in 1:length(levels(covid.2019.ru.i$LOCUS.0))){
covid.2019.ru.i.reg.0[[i]] <- subset(covid.2019.ru.i, covid.2019.ru.i$LOCUS.0 == levels(covid.2019.ru.i$LOCUS.0)[i])
covid.2019.ru.r.reg.0[[i]] <- subset(covid.2019.ru.r, covid.2019.ru.i$LOCUS.0 == levels(covid.2019.ru.r$LOCUS.0)[i])
covid.2019.ru.d.reg.0[[i]] <- subset(covid.2019.ru.d, covid.2019.ru.i$LOCUS.0 == levels(covid.2019.ru.d$LOCUS.0)[i])
}

# Barplot regions data frame;
covid.2019.ru.i.reg.df <- NULL

for(i in 1:length(levels(covid.2019.ru.i$LOCUS))){
covid.2019.ru.i.reg.df <- rbind.data.frame(covid.2019.ru.i.reg.df,
cbind.data.frame(covid.2019.ru.i.reg[[i]]$LOCUS[1],
sum(covid.2019.ru.i.reg[[i]]$NUMBER))
)
}

colnames(covid.2019.ru.i.reg.df) <- c("LOCUS.1","NUMBER")
covid.2019.ru.i.reg.df <- cbind.data.frame(covid.2019.ru.i.reg.df, covid.2019.population)
covid.2019.ru.i.reg.df$PER.100K <- covid.2019.ru.i.reg.df$NUMBER/(covid.2019.ru.i.reg.df$POPULATION/100000)

covid.2019.ru.i.reg.ordered.df <- covid.2019.ru.i.reg.df[order(-covid.2019.ru.i.reg.df$NUMBER),]
covid.2019.ru.i.reg.ordered.PER.100K.df <- covid.2019.ru.i.reg.df[order(-covid.2019.ru.i.reg.df$PER.100K),]

# Mapping regions data frame;
covid.2019.ru.i.reg.0.df <- NULL

for(i in 1:length(levels(covid.2019.ru.i$LOCUS.0))){
covid.2019.ru.i.reg.0.df <- rbind.data.frame(covid.2019.ru.i.reg.0.df,
cbind.data.frame(covid.2019.ru.i.reg.0[[i]]$LOCUS.0[1],
sum(covid.2019.ru.i.reg.0[[i]]$NUMBER))
)
}

colnames(covid.2019.ru.i.reg.0.df) <- c("LOCUS.1","NUMBER")

covid.2019.ru.i.reg.0.df <- cbind.data.frame(covid.2019.ru.i.reg.0.df, covid.2019.coord)

covid.2019.ru.i.reg.0.df <- covid.2019.ru.i.reg.0.df[order(-covid.2019.ru.i.reg.0.df$NUMBER),]

covid.2019.ru.i.reg.0.df$PER.100K <- covid.2019.ru.i.reg.0.df$NUMBER/(covid.2019.ru.i.reg.0.df$POPULATION/100000)

# Momentary data

RUS <- NULL
RUS.newcases <- NULL

for(i in 1:length(covid.2019.ru.i.moment_ts)){
if(nrow(covid.2019.ru.i.moment_ts[[i]])==0){
RUS.newcases <- c(RUS.newcases, NA)
} else {RUS.newcases <- c(RUS.newcases, nrow(covid.2019.ru.i.moment_ts[[i]]))}
RUS <- c(RUS, nrow(covid.2019.ru.i.moment_ts[[i]]))
}

# Singling out Moscow, St. Petersburg, and regions with capitals of 1000K

Mos <- NULL
SPb <- NULL

Volg <- NULL
Vrnz <- NULL
Ekb <- NULL
Kaz <- NULL
Kryr <- NULL
NNov <- NULL
Nvsb <- NULL
Omsk <- NULL
Perm <- NULL
RoD <- NULL
Sam <- NULL
Ufa <- NULL
Chlb <- NULL

for(i in 1:length(covid.2019.ru.i.moment_ts)){
Mos <- c(Mos, nrow(subset(covid.2019.ru.i.moment_ts[[i]], covid.2019.ru.i.moment_ts[[i]]$LOCUS.0 == "Moscow")))
SPb <- c(SPb, nrow(subset(covid.2019.ru.i.moment_ts[[i]], covid.2019.ru.i.moment_ts[[i]]$LOCUS.0 == "St. Petersburg")))
Volg <-c(Volg, nrow(subset(covid.2019.ru.i.moment_ts[[i]], covid.2019.ru.i.moment_ts[[i]]$LOCUS.0 == "Volgograd")))
Vrnz <-c(Vrnz, nrow(subset(covid.2019.ru.i.moment_ts[[i]], covid.2019.ru.i.moment_ts[[i]]$LOCUS.0 == "Voronezh")))
Ekb <-c(Ekb, nrow(subset(covid.2019.ru.i.moment_ts[[i]], covid.2019.ru.i.moment_ts[[i]]$LOCUS.0 == "Ekaterinburg")))
Kaz <-c(Kaz, nrow(subset(covid.2019.ru.i.moment_ts[[i]], covid.2019.ru.i.moment_ts[[i]]$LOCUS.0 == "Kazan")))
Kryr <-c(Kryr, nrow(subset(covid.2019.ru.i.moment_ts[[i]], covid.2019.ru.i.moment_ts[[i]]$LOCUS.0 == "Krasnoyarsk")))
NNov <-c(NNov, nrow(subset(covid.2019.ru.i.moment_ts[[i]], covid.2019.ru.i.moment_ts[[i]]$LOCUS.0 == "Nizhnii Novgorod")))
Nvsb <-c(Nvsb, nrow(subset(covid.2019.ru.i.moment_ts[[i]], covid.2019.ru.i.moment_ts[[i]]$LOCUS.0 == "Novosibirsk")))
Omsk <-c(Omsk, nrow(subset(covid.2019.ru.i.moment_ts[[i]], covid.2019.ru.i.moment_ts[[i]]$LOCUS.0 == "Omsk")))
Perm <-c(Perm, nrow(subset(covid.2019.ru.i.moment_ts[[i]], covid.2019.ru.i.moment_ts[[i]]$LOCUS.0 == "Perm krai")))
RoD <-c(RoD, nrow(subset(covid.2019.ru.i.moment_ts[[i]], covid.2019.ru.i.moment_ts[[i]]$LOCUS.0 == "Rostov-on-Don")))
Sam <-c(Sam, nrow(subset(covid.2019.ru.i.moment_ts[[i]], covid.2019.ru.i.moment_ts[[i]]$LOCUS.0 == "Samara")))
Ufa <-c(Ufa, nrow(subset(covid.2019.ru.i.moment_ts[[i]], covid.2019.ru.i.moment_ts[[i]]$LOCUS.0 == "Bashkortostan")))
Chlb <-c(Chlb, nrow(subset(covid.2019.ru.i.moment_ts[[i]], covid.2019.ru.i.moment_ts[[i]]$LOCUS.0 == "Cheliabinsk")))
}

covid.2019.ru.i.dyn.tt <- cbind.data.frame(
  covid.2019.breaks$TIME,
  RUS.newcases,
  RUS,
  Mos,
  SPb,
  Volg,
  Vrnz,
  Ekb,
  Kaz,
  Kryr,
  NNov,
  Nvsb,
  Omsk,
  Perm,
  RoD,
  Sam,
  Ufa,
  Chlb
)

colnames(covid.2019.ru.i.dyn.tt) <- c("TIME","RUS.newcases","RUS",
"Mos",
"SPb",
"Volg",
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
"Chlb"
)

covid.2019.ru.i.dyn.tt$RUS.CS <- cumsum(covid.2019.ru.i.dyn.tt$RUS)
covid.2019.ru.i.dyn.tt$Mos.CS <- cumsum(covid.2019.ru.i.dyn.tt$Mos)
covid.2019.ru.i.dyn.tt$SPb.CS <- cumsum(covid.2019.ru.i.dyn.tt$SPb)
covid.2019.ru.i.dyn.tt$Volg.CS <- cumsum(covid.2019.ru.i.dyn.tt$Volg)
covid.2019.ru.i.dyn.tt$Vrnz.CS <- cumsum(covid.2019.ru.i.dyn.tt$Vrnz)
covid.2019.ru.i.dyn.tt$Ekb.CS <- cumsum(covid.2019.ru.i.dyn.tt$Ekb)
covid.2019.ru.i.dyn.tt$Kaz.CS <- cumsum(covid.2019.ru.i.dyn.tt$Kaz)
covid.2019.ru.i.dyn.tt$Kryr.CS <- cumsum(covid.2019.ru.i.dyn.tt$Kryr)
covid.2019.ru.i.dyn.tt$NNov.CS <- cumsum(covid.2019.ru.i.dyn.tt$NNov)
covid.2019.ru.i.dyn.tt$Nvsb.CS <- cumsum(covid.2019.ru.i.dyn.tt$Nvsb)
covid.2019.ru.i.dyn.tt$Omsk.CS <- cumsum(covid.2019.ru.i.dyn.tt$Omsk)
covid.2019.ru.i.dyn.tt$Perm.CS <- cumsum(covid.2019.ru.i.dyn.tt$Perm)
covid.2019.ru.i.dyn.tt$RoD.CS <- cumsum(covid.2019.ru.i.dyn.tt$RoD)
covid.2019.ru.i.dyn.tt$Sam.CS <- cumsum(covid.2019.ru.i.dyn.tt$Sam)
covid.2019.ru.i.dyn.tt$Ufa.CS <- cumsum(covid.2019.ru.i.dyn.tt$Ufa)
covid.2019.ru.i.dyn.tt$Chlb.CS <- cumsum(covid.2019.ru.i.dyn.tt$Chlb)

# y <- c(NA, covid.2019.ru.i.dyn.tt$RUS.CS[2:(length(covid.2019.ru.i.dyn.tt$RUS.CS))]/
# covid.2019.ru.i.dyn.tt$RUS.CS[1:(length(covid.2019.ru.i.dyn.tt$RUS.CS)-1)])
#
# x <- covid.2019.ru.i.dyn.tt$RUS.CS[2:length(covid.2019.ru.i.dyn.tt$RUS.CS)]
# xt <- covid.2019.ru.i.dyn.tt$TIME[2:length(covid.2019.ru.i.dyn.tt$TIME)]

covid.2019.ru.i.dyn.tt$RUS.Prov.CS <- covid.2019.ru.i.dyn.tt$RUS.CS -
(covid.2019.ru.i.dyn.tt$SPb.CS +
covid.2019.ru.i.dyn.tt$Mos.CS)

covid.2019.ru.i.dyn.tt$RUS.CS.diff <- c(NA, NA,
covid.2019.ru.i.dyn.tt$RUS.CS[3:length(covid.2019.ru.i.dyn.tt$RUS.CS)]/
covid.2019.ru.i.dyn.tt$RUS.CS[2:(length(covid.2019.ru.i.dyn.tt$RUS.CS)-1)])

covid.2019.ru.i.dyn.tt$RUS.Prov.CS.diff <- c(NA, NA,
covid.2019.ru.i.dyn.tt$RUS.Prov.CS[3:length(covid.2019.ru.i.dyn.tt$RUS.Prov.CS)]/
covid.2019.ru.i.dyn.tt$RUS.Prov.CS[2:(length(covid.2019.ru.i.dyn.tt$RUS.Prov.CS)-1)])

covid.2019.ru.i.dyn.tt$Mos.CS.diff <- c(rep(NA, 33),
covid.2019.ru.i.dyn.tt$Mos.CS[34:length(covid.2019.ru.i.dyn.tt$Mos.CS)]/
covid.2019.ru.i.dyn.tt$Mos.CS[33:(length(covid.2019.ru.i.dyn.tt$Mos.CS)-1)])

covid.2019.ru.i.dyn.tt$SPb.CS.diff <- c(rep(NA, 36),
covid.2019.ru.i.dyn.tt$SPb.CS[37:length(covid.2019.ru.i.dyn.tt$SPb.CS)]/
covid.2019.ru.i.dyn.tt$SPb.CS[36:(length(covid.2019.ru.i.dyn.tt$SPb.CS)-1)])

# Adding days count;

covid.2019.ru.i.dyn.tt$DAYS <- rownames(covid.2019.ru.i.dyn.tt)
covid.2019.ru.i.dyn.tt$DAYS <- as.numeric(covid.2019.ru.i.dyn.tt$DAYS)

# Momentary data for recovered

RUS.r <- NULL
RUS.r.newcases <- NULL

for(i in 1:length(covid.2019.ru.r.moment_ts)){
if(nrow(covid.2019.ru.r.moment_ts[[i]])==0){
RUS.r.newcases <- c(RUS.r.newcases, NA)
} else {RUS.r.newcases <- c(RUS.r.newcases, nrow(covid.2019.ru.r.moment_ts[[i]]))}
RUS.r <- c(RUS.r, nrow(covid.2019.ru.r.moment_ts[[i]]))
}

covid.2019.ru.r.dyn.tt <- cbind.data.frame(
  covid.2019.breaks$TIME,
  RUS.r.newcases,
  RUS.r)

colnames(covid.2019.ru.r.dyn.tt) <- c("TIME","RECOVERED.newcases","RECOVERED")
covid.2019.ru.r.dyn.tt$RECOVERED.CS <- cumsum(covid.2019.ru.r.dyn.tt$RECOVERED)

# Momentary data for deceased

RUS.d <- NULL
RUS.d.newcases <- NULL

for(i in 1:length(covid.2019.ru.d.moment_ts)){
if(nrow(covid.2019.ru.d.moment_ts[[i]])==0){
RUS.d.newcases <- c(RUS.d.newcases, NA)
} else {RUS.d.newcases <- c(RUS.d.newcases, nrow(covid.2019.ru.d.moment_ts[[i]]))}
RUS.d <- c(RUS.d, nrow(covid.2019.ru.d.moment_ts[[i]]))
}

covid.2019.ru.d.dyn.tt <- cbind.data.frame(
  covid.2019.breaks$TIME,
  RUS.d.newcases,
  RUS.d)

colnames(covid.2019.ru.d.dyn.tt) <- c("TIME","DEAD.newcases","DEAD")
covid.2019.ru.d.dyn.tt$DEAD.CS <- cumsum(covid.2019.ru.d.dyn.tt$DEAD)

covid.2019.ru.i.dyn.tot <- NULL
covid.2019.ru.i.dyn.tmp <- NULL

for(j in 1:length(levels(covid.2019.ru$LOCUS))){
 covid.2019.ru.i.dyn.tmp <- NULL
 for(i in 1:length(covid.2019.ru.i.moment_ts)){
  covid.2019.ru.i.dyn.tmp <- c(covid.2019.ru.i.dyn.tmp, nrow(subset(covid.2019.ru.i.moment_ts[[i]], covid.2019.ru.i.moment_ts[[i]]$LOCUS == levels(covid.2019.ru$LOCUS)[j])))
 }
 covid.2019.ru.i.dyn.tot[[j]] <- as.data.frame(covid.2019.ru.i.dyn.tmp)
 colnames(covid.2019.ru.i.dyn.tot[[j]]) <- levels(covid.2019.ru$LOCUS)[j]
}

for(j in 1:length(levels(covid.2019.ru$LOCUS))){
 covid.2019.ru.i.dyn.tot[[j]]$CS <- cumsum(covid.2019.ru.i.dyn.tot[[j]][,1])
 covid.2019.ru.i.dyn.tot[[j]]$CS.diff <- c(NA, 
  covid.2019.ru.i.dyn.tot[[j]]$CS[2:length(covid.2019.ru.i.dyn.tot[[j]]$CS)]/
  covid.2019.ru.i.dyn.tot[[j]]$CS[1:(length(covid.2019.ru.i.dyn.tot[[j]]$CS)-1)]
  )
}

CS.diff.3 <- NULL 
CS.diff.7 <- NULL 

for(j in 1:(length(levels(covid.2019.ru$LOCUS)))){
  CS.diff.3 <- NA 
  CS.diff.7 <- c(NA,NA,NA) 
 for(i in 2:(nrow(covid.2019.ru.i.dyn.tot[[j]])-1)){
  CS.diff.3 <- c(CS.diff.3, mean(covid.2019.ru.i.dyn.tot[[j]]$CS.diff[(i-1):(i+1)], na.rm=TRUE))
  }
  CS.diff.3 <- c(CS.diff.3, NA)
  covid.2019.ru.i.dyn.tot[[j]]$CS.diff.3 <- CS.diff.3
 for(k in 4:(nrow(covid.2019.ru.i.dyn.tot[[j]])-3)){
  CS.diff.7 <- c(CS.diff.7, mean(covid.2019.ru.i.dyn.tot[[j]]$CS.diff[(k-3):(k+3)], na.rm=TRUE))
  }
  CS.diff.7 <- c(CS.diff.7, NA, NA, NA)
  covid.2019.ru.i.dyn.tot[[j]]$CS.diff.7 <- CS.diff.7
}

# List of truncated data.frames;

covid.2019.ru.i.dyn.trunc <- NULL
covid.2019.ru.i.dyn.trunc <- as.list(covid.2019.ru.i.dyn.trunc)

for(j in 1:length(levels(covid.2019.ru$LOCUS))){
 if(max(covid.2019.ru.i.dyn.tot[[j]]$"CS", na.rm=TRUE) >= 50){
  covid.2019.ru.i.dyn.trunc[[j]] <- subset(covid.2019.ru.i.dyn.tot[[j]], covid.2019.ru.i.dyn.tot[[j]]$CS >= 50)
 } else{
  covid.2019.ru.i.dyn.trunc[[j]] <- cbind.data.frame(c(NA),c(NA),c(NA),c(NA),c(NA))
  colnames(covid.2019.ru.i.dyn.trunc[[j]]) <- colnames(covid.2019.ru.i.dyn.tot[[j]])
 }
}

Moscow.pos <- NULL

for(j in 1:length(levels(covid.2019.ru$LOCUS))){
 if(colnames(covid.2019.ru.i.dyn.tot[[j]])[1]=="Moscow"){
  Moscow.pos <- j
 }
}

billionaires <- NULL

for(j in 1:length(levels(covid.2019.ru$LOCUS))){
if(colnames(covid.2019.ru.i.dyn.tot[[j]])[1]=="Moscow" |
 colnames(covid.2019.ru.i.dyn.tot[[j]])[1]=="St. Petersburg" |
 colnames(covid.2019.ru.i.dyn.tot[[j]])[1]=="Volgograd" |
 colnames(covid.2019.ru.i.dyn.tot[[j]])[1]=="Voronezh" |
 colnames(covid.2019.ru.i.dyn.tot[[j]])[1]=="Ekaterinburg" |
 colnames(covid.2019.ru.i.dyn.tot[[j]])[1]=="Kazan" |
 colnames(covid.2019.ru.i.dyn.tot[[j]])[1]=="Krasnoyarsk" |
 colnames(covid.2019.ru.i.dyn.tot[[j]])[1]=="Nizhnii Novgorod" |
 colnames(covid.2019.ru.i.dyn.tot[[j]])[1]=="Novosibirsk" |
 colnames(covid.2019.ru.i.dyn.tot[[j]])[1]=="Omsk" |
 colnames(covid.2019.ru.i.dyn.tot[[j]])[1]=="Perm krai" |
 colnames(covid.2019.ru.i.dyn.tot[[j]])[1]=="Rostov-on-Don" |
 colnames(covid.2019.ru.i.dyn.tot[[j]])[1]=="Samara" |
 colnames(covid.2019.ru.i.dyn.tot[[j]])[1]=="Bashkortostan" |
 colnames(covid.2019.ru.i.dyn.tot[[j]])[1]=="Cheliabinsk"){
  billionaires <- c(billionaires, j)
 }
}
