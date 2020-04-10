################################################################
# Nested under:
# covid.2019.ru.main.r
# 
# requires:
# source(covid.2019.ru.data_loader.r)

################################################################
# Disaggregating

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
covid.2019.ru.r.reg.0[[i]] <- subset(covid.2019.ru.i, covid.2019.ru.i$LOCUS.0 == levels(covid.2019.ru.i$LOCUS.0)[i])
covid.2019.ru.d.reg.0[[i]] <- subset(covid.2019.ru.i, covid.2019.ru.i$LOCUS.0 == levels(covid.2019.ru.i$LOCUS.0)[i])
}

# Dynamics data frame;
covid.2019.ru.i.dyn <- NULL

for(i in 1:length(levels(covid.2019.ru.i$TIMESTAMP))){
covid.2019.ru.i.dyn <- rbind.data.frame(covid.2019.ru.i.dyn,
cbind.data.frame(
covid.2019.ru.i.ts[[i]]$TIME[1],
sum(covid.2019.ru.i.ts[[i]]$NUMBER))
)
}

colnames(covid.2019.ru.i.dyn) <- c("TIME","NUMBER")
covid.2019.ru.i.dyn$CUMSUM <- cumsum(covid.2019.ru.i.dyn$NUMBER)

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

for(i in 1:length(covid.2019.ru.i.moment_ts)){
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

colnames(covid.2019.ru.i.dyn.tt) <- c("TIME","RUS",
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

# Adding days count;

covid.2019.ru.i.dyn.tt$DAYS <- rownames(covid.2019.ru.i.dyn.tt)
covid.2019.ru.i.dyn.tt$DAYS <- as.numeric(covid.2019.ru.i.dyn.tt$DAYS)
