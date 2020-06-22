################################################################
# Nested under:
# covid.2019.ru.main.r
# 
# requires:
# source("covid.2019.ru.data_loader.r")
# 
################################################################

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
 
rm(covid.2019.ru.da)

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

# Density mapping / barplot regions data frame;
covid.2019.ru.i.reg.df <- NULL

for(i in 1:length(levels(covid.2019.ru.i$LOCUS))){
covid.2019.ru.i.reg.df <- rbind.data.frame(covid.2019.ru.i.reg.df,
cbind.data.frame(covid.2019.ru.i.reg[[i]]$LOCUS[1],
sum(covid.2019.ru.i.reg[[i]]$NUMBER))
)
}

colnames(covid.2019.ru.i.reg.df) <- c("LOCUS.1","NUMBER")
covid.2019.ru.i.reg.df <- cbind.data.frame(covid.2019.ru.i.reg.df, covid.2019.population)

covid.2019.ru.i.reg.df.LOCUS.ch <- as.character(covid.2019.ru.i.reg.df$LOCUS)
covid.2019.ru.i.reg.df$LOCUS.dm <- factor(covid.2019.ru.i.reg.df.LOCUS.ch, levels=ru.shape.LOCUS)

covid.2019.ru.i.reg.df$PER.100K <- covid.2019.ru.i.reg.df$NUMBER/(covid.2019.ru.i.reg.df$POPULATION.20200101/100000)

# Mapping regions data frame (part 1);
covid.2019.ru.i.reg.0.df <- NULL

for(i in 1:length(levels(covid.2019.ru.i$LOCUS.0))){
covid.2019.ru.i.reg.0.df <- rbind.data.frame(covid.2019.ru.i.reg.0.df,
cbind.data.frame(covid.2019.ru.i.reg.0[[i]]$LOCUS.0[1],
sum(covid.2019.ru.i.reg.0[[i]]$NUMBER))
)
}

colnames(covid.2019.ru.i.reg.0.df) <- c("LOCUS.1","NUMBER")

covid.2019.ru.i.reg.0.df <- cbind.data.frame(covid.2019.ru.i.reg.0.df, covid.2019.coord)

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

for(i in 1:length(covid.2019.ru.i.moment_ts)){
Mos <- c(Mos, nrow(subset(covid.2019.ru.i.moment_ts[[i]], covid.2019.ru.i.moment_ts[[i]]$LOCUS.0 == "Moscow")))
SPb <- c(SPb, nrow(subset(covid.2019.ru.i.moment_ts[[i]], covid.2019.ru.i.moment_ts[[i]]$LOCUS.0 == "St. Petersburg")))
}

covid.2019.ru.i.dyn.tt <- cbind.data.frame(
  covid.2019.breaks$TIME,
  RUS.newcases,
  RUS,
  Mos,
  SPb
)

colnames(covid.2019.ru.i.dyn.tt) <- c("TIME","RUS.newcases","RUS",
"Mos",
"SPb"
)

covid.2019.ru.i.dyn.tt$RUS.CS <- cumsum(covid.2019.ru.i.dyn.tt$RUS)
covid.2019.ru.i.dyn.tt$Mos.CS <- cumsum(covid.2019.ru.i.dyn.tt$Mos)
covid.2019.ru.i.dyn.tt$SPb.CS <- cumsum(covid.2019.ru.i.dyn.tt$SPb)

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

covid.2019.ru.dyn.tot <- NULL
covid.2019.ru.i.dyn.tmp <- NULL
covid.2019.ru.r.dyn.tmp <- NULL
covid.2019.ru.d.dyn.tmp <- NULL

for(j in 1:length(levels(covid.2019.ru$LOCUS))){
 covid.2019.ru.i.dyn.tmp <- NULL
 covid.2019.ru.r.dyn.tmp <- NULL
 covid.2019.ru.d.dyn.tmp <- NULL
 for(i in 1:length(covid.2019.ru.i.moment_ts)){
  covid.2019.ru.i.dyn.tmp <- c(covid.2019.ru.i.dyn.tmp, nrow(subset(covid.2019.ru.i.moment_ts[[i]], covid.2019.ru.i.moment_ts[[i]]$LOCUS == levels(covid.2019.ru$LOCUS)[j])))
  covid.2019.ru.r.dyn.tmp <- c(covid.2019.ru.r.dyn.tmp, nrow(subset(covid.2019.ru.r.moment_ts[[i]], covid.2019.ru.r.moment_ts[[i]]$LOCUS == levels(covid.2019.ru$LOCUS)[j])))
  covid.2019.ru.d.dyn.tmp <- c(covid.2019.ru.d.dyn.tmp, nrow(subset(covid.2019.ru.d.moment_ts[[i]], covid.2019.ru.d.moment_ts[[i]]$LOCUS == levels(covid.2019.ru$LOCUS)[j])))
 }
 covid.2019.ru.dyn.tot[[j]] <- cbind.data.frame(
  covid.2019.breaks$TIME,
  covid.2019.ru.i.dyn.tmp,
  covid.2019.ru.r.dyn.tmp,
  covid.2019.ru.d.dyn.tmp
  )
 colnames(covid.2019.ru.dyn.tot[[j]]) <- c("TIME","i","r","d")
}

names(covid.2019.ru.dyn.tot) <- levels(covid.2019.ru$LOCUS)

for(j in 1:length(levels(covid.2019.ru$LOCUS))){

 covid.2019.ru.dyn.tot[[j]]$CS.i <- cumsum(covid.2019.ru.dyn.tot[[j]]$i)

 covid.2019.ru.dyn.tot[[j]]$CS.i.diff <- c(NA, 
  covid.2019.ru.dyn.tot[[j]]$CS.i[2:length(covid.2019.ru.dyn.tot[[j]]$CS.i)]/
  covid.2019.ru.dyn.tot[[j]]$CS.i[1:(length(covid.2019.ru.dyn.tot[[j]]$CS.i)-1)]
  )

 covid.2019.ru.dyn.tot[[j]]$CS.r <- cumsum(covid.2019.ru.dyn.tot[[j]]$r)
 covid.2019.ru.dyn.tot[[j]]$CS.r.diff <- c(NA, 
  covid.2019.ru.dyn.tot[[j]]$CS.r[2:length(covid.2019.ru.dyn.tot[[j]]$CS.r)]/
  covid.2019.ru.dyn.tot[[j]]$CS.r[1:(length(covid.2019.ru.dyn.tot[[j]]$CS.r)-1)]
  )

 covid.2019.ru.dyn.tot[[j]]$CS.d <- cumsum(covid.2019.ru.dyn.tot[[j]]$d)
 covid.2019.ru.dyn.tot[[j]]$CS.d.diff <- c(NA, 
  covid.2019.ru.dyn.tot[[j]]$CS.d[2:length(covid.2019.ru.dyn.tot[[j]]$CS.d)]/
  covid.2019.ru.dyn.tot[[j]]$CS.d[1:(length(covid.2019.ru.dyn.tot[[j]]$CS.d)-1)]
  )

 covid.2019.ru.dyn.tot[[j]]$CS.a <- covid.2019.ru.dyn.tot[[j]]$CS.i - (covid.2019.ru.dyn.tot[[j]]$CS.r + covid.2019.ru.dyn.tot[[j]]$CS.d)
}

for(j in 1:length(levels(covid.2019.ru$LOCUS))){
 covid.2019.ru.dyn.tot[[j]]$CS.a.POP <- covid.2019.ru.dyn.tot[[j]]$CS.a / (covid.2019.population$POPULATION.20200101[j]/100000)
}

CS.i.diff.7 <- NULL 
CS.r.diff.7 <- NULL 
CS.d.diff.7 <- NULL 
i.7 <- NULL
R.RPN <- NULL

for(j in 1:(length(levels(covid.2019.ru$LOCUS)))){
  CS.i.diff.7 <- c(NA,NA,NA) 
 for(k in 4:(nrow(covid.2019.ru.dyn.tot[[j]])-3)){
  CS.i.diff.7 <- c(CS.i.diff.7, mean(covid.2019.ru.dyn.tot[[j]]$CS.i.diff[(k-3):(k+3)], na.rm=TRUE))
  }
  CS.i.diff.7 <- c(CS.i.diff.7, NA, NA, NA)
  covid.2019.ru.dyn.tot[[j]]$CS.i.diff.7 <- CS.i.diff.7

  CS.r.diff.7 <- c(NA,NA,NA) 
 for(k in 4:(nrow(covid.2019.ru.dyn.tot[[j]])-3)){
  CS.r.diff.7 <- c(CS.r.diff.7, mean(covid.2019.ru.dyn.tot[[j]]$CS.r.diff[(k-3):(k+3)], na.rm=TRUE))
  }
  CS.r.diff.7 <- c(CS.r.diff.7, NA, NA, NA)
  covid.2019.ru.dyn.tot[[j]]$CS.r.diff.7 <- CS.r.diff.7

  CS.d.diff.7 <- c(NA,NA,NA) 
 for(k in 4:(nrow(covid.2019.ru.dyn.tot[[j]])-3)){
  CS.d.diff.7 <- c(CS.d.diff.7, mean(covid.2019.ru.dyn.tot[[j]]$CS.d.diff[(k-3):(k+3)], na.rm=TRUE))
  }
  CS.d.diff.7 <- c(CS.d.diff.7, NA, NA, NA)
  covid.2019.ru.dyn.tot[[j]]$CS.d.diff.7 <- CS.d.diff.7

  i.7 <- c(NA,NA,NA) 
 for(k in 4:(nrow(covid.2019.ru.dyn.tot[[j]])-3)){
  i.7 <- c(i.7, mean(covid.2019.ru.dyn.tot[[j]]$i[(k-3):(k+3)], na.rm=TRUE))
  }
  i.7 <- c(i.7, NA, NA, NA)
  covid.2019.ru.dyn.tot[[j]]$i.7 <- i.7

  R.RPN <- rep(NA,8) 
 for(k in 9:(nrow(covid.2019.ru.dyn.tot[[j]]))){
  R.RPN <- c(R.RPN, sum(covid.2019.ru.dyn.tot[[j]]$i[(k):(k-3)], na.rm=TRUE)/sum(covid.2019.ru.dyn.tot[[j]]$i[(k-4):(k-7)], na.rm=TRUE))
  }
  R.RPN <- c(R.RPN)
  covid.2019.ru.dyn.tot[[j]]$R.RPN <- R.RPN

}

# List of truncated data.frames;

covid.2019.ru.i.dyn.trunc <- NULL
covid.2019.ru.i.dyn.trunc <- as.list(covid.2019.ru.i.dyn.trunc)

for(j in 1:length(levels(covid.2019.ru$LOCUS))){
 if(max(covid.2019.ru.dyn.tot[[j]]$"CS.i", na.rm=TRUE) >= 50){
  covid.2019.ru.i.dyn.trunc[[j]] <- subset(covid.2019.ru.dyn.tot[[j]], covid.2019.ru.dyn.tot[[j]]$CS.i >= 50)
 } else{
  covid.2019.ru.i.dyn.trunc[[j]] <- rbind.data.frame(rep(NA, ncol(covid.2019.ru.dyn.tot[[j]])))
  colnames(covid.2019.ru.i.dyn.trunc[[j]]) <- colnames(covid.2019.ru.dyn.tot[[j]])
 }
}

names(covid.2019.ru.i.dyn.trunc) <- names(covid.2019.ru.dyn.tot)

Moscow.pos <- NULL

for(j in 1:length(levels(covid.2019.ru$LOCUS))){
 if(names(covid.2019.ru.dyn.tot)[j]=="Moscow"){
  Moscow.pos <- j
 }
}

Leningrad_region.pos <- NULL

for(j in 1:length(levels(covid.2019.ru$LOCUS))){
 if(names(covid.2019.ru.dyn.tot)[j]=="Leningrad region"){
  Leningrad_region.pos <- j
 }
}

# Summarising Rt rolling average;

covid.2019.ru.i.rt.slice <- NULL

for(i in 1:length(levels(covid.2019.ru$LOCUS))){
covid.2019.ru.i.rt.slice <- c(covid.2019.ru.i.rt.slice,
covid.2019.ru.dyn.tot[[i]]$CS.i.diff.7[nrow(covid.2019.ru.dyn.tot[[i]])-3])
}

covid.2019.ru.i.rt.slice.2log <- NULL

for(i in 1:length(levels(covid.2019.ru$LOCUS))){
 if(log(2, base=covid.2019.ru.i.rt.slice[i]) < Inf){
 covid.2019.ru.i.rt.slice.2log <- c(covid.2019.ru.i.rt.slice.2log, log(2, base=covid.2019.ru.i.rt.slice[i]))
 } else {
 covid.2019.ru.i.rt.slice.2log <- c(covid.2019.ru.i.rt.slice.2log, NA)
 }
}

covid.2019.ru.CS.a.POP.slice <- NULL

for(i in 1:length(levels(covid.2019.ru$LOCUS))){
covid.2019.ru.CS.a.POP.slice <- c(covid.2019.ru.CS.a.POP.slice,
covid.2019.ru.dyn.tot[[i]]$CS.a.POP[nrow(covid.2019.ru.dyn.tot[[i]])-3])
}

#######

covid.2019.ru.i.rt.slice.noInf <- subset(covid.2019.ru.i.rt.slice, covid.2019.ru.i.rt.slice < Inf)
covid.2019.ru.i.rt.slice.norm <- covid.2019.ru.i.rt.slice/max(covid.2019.ru.i.rt.slice.noInf)

# Point mapping regions data frame (part 2)
covid.2019.ru.i.reg.0.df$CS.i.diff.7 <- covid.2019.ru.i.rt.slice[c(1:(Leningrad_region.pos-1), (Leningrad_region.pos+1):(Moscow.pos), (Moscow.pos+2):length(covid.2019.ru.i.rt.slice))]
covid.2019.ru.i.reg.0.df$CS.i.diff.7.2log <- covid.2019.ru.i.rt.slice.2log[c(1:(Leningrad_region.pos-1), (Leningrad_region.pos+1):(Moscow.pos), (Moscow.pos+2):length(covid.2019.ru.i.rt.slice))]

covid.2019.ru.i.reg.0.df <- covid.2019.ru.i.reg.0.df[order(-covid.2019.ru.i.reg.0.df$NUMBER),]

covid.2019.ru.i.reg.0.df$PER.100K <- covid.2019.ru.i.reg.0.df$NUMBER/(covid.2019.ru.i.reg.0.df$POPULATION.20200101/100000)

# Density mapping regions data frame;

covid.2019.ru.i.reg.df$CS.i.diff.7 <- covid.2019.ru.i.rt.slice
covid.2019.ru.i.reg.df$CS.i.diff.7.2log <- covid.2019.ru.i.rt.slice.2log
covid.2019.ru.i.reg.df$CS.a.POP <- covid.2019.ru.CS.a.POP.slice

covid.2019.ru.i.reg.ordered.df <- covid.2019.ru.i.reg.df[order(-covid.2019.ru.i.reg.df$NUMBER),]
covid.2019.ru.i.reg.ordered.PER.100K.df <- covid.2019.ru.i.reg.df[order(-covid.2019.ru.i.reg.df$PER.100K),]
covid.2019.ru.i.reg.ordered.CS.a.POP <- covid.2019.ru.i.reg.df[order(-covid.2019.ru.i.reg.df$CS.a.POP),]
covid.2019.ru.i.reg.df.dm_sorted <- covid.2019.ru.i.reg.df[order(covid.2019.ru.i.reg.df$LOCUS.dm),]

# Extracting billionaires from covid.2019.ru.dyn.tot; 

billionaires <- NULL

for(j in 1:length(levels(covid.2019.ru$LOCUS))){
if(names(covid.2019.ru.dyn.tot)[j]=="Moscow" |
 names(covid.2019.ru.dyn.tot)[j]=="St. Petersburg" |
 names(covid.2019.ru.dyn.tot)[j]=="Volgograd" |
 names(covid.2019.ru.dyn.tot)[j]=="Voronezh" |
 names(covid.2019.ru.dyn.tot)[j]=="Ekaterinburg" |
 names(covid.2019.ru.dyn.tot)[j]=="Kazan" |
 names(covid.2019.ru.dyn.tot)[j]=="Krasnoyarsk" |
 names(covid.2019.ru.dyn.tot)[j]=="Nizhnii Novgorod" |
 names(covid.2019.ru.dyn.tot)[j]=="Novosibirsk" |
 names(covid.2019.ru.dyn.tot)[j]=="Omsk" |
 names(covid.2019.ru.dyn.tot)[j]=="Perm krai" |
 names(covid.2019.ru.dyn.tot)[j]=="Rostov-on-Don" |
 names(covid.2019.ru.dyn.tot)[j]=="Samara" |
 names(covid.2019.ru.dyn.tot)[j]=="Bashkortostan" |
 names(covid.2019.ru.dyn.tot)[j]=="Cheliabinsk"){
  billionaires <- c(billionaires, j)
 }
}

billionaires.p <- billionaires[c(1:5,7:12,14:15)]

# Rmd report objects:

incr.abs.t <- subset(covid.2019.ru.i, 
covid.2019.ru.i$TIMESTAMP == covid.2019.ru.i$TIMESTAMP[nrow(covid.2019.ru.i)] & 
covid.2019.ru.i$NUMBER >= 100 & 
covid.2019.ru.i$LOCUS.0 != "Moscow")[,c(5,6)]

dt.worst <- data.frame(
subset(covid.2019.ru.i.reg.df, covid.2019.ru.i.reg.df$CS.i.diff.7.2log < 15)$REGION.RUS,
round(subset(covid.2019.ru.i.reg.df, covid.2019.ru.i.reg.df$CS.i.diff.7.2log < 15)$PER.100K, 2),
round(subset(covid.2019.ru.i.reg.df, covid.2019.ru.i.reg.df$CS.i.diff.7.2log < 15)$CS.i.diff.7.2log, 2)
)
colnames(dt.worst) <- c("LOCUS","K100","Dt")
dt.worst <- dt.worst[order(dt.worst$Dt),]

dt.best <- data.frame(
subset(covid.2019.ru.i.reg.df, covid.2019.ru.i.reg.df$CS.i.diff.7.2log >= 35)$REGION.RUS,
round(subset(covid.2019.ru.i.reg.df, covid.2019.ru.i.reg.df$CS.i.diff.7.2log >= 35)$PER.100K, 2),
round(subset(covid.2019.ru.i.reg.df, covid.2019.ru.i.reg.df$CS.i.diff.7.2log >= 35)$CS.i.diff.7.2log, 2)
)
colnames(dt.best) <- c("LOCUS","K100","Dt")
dt.best <- dt.best[order(-dt.best$Dt),]
