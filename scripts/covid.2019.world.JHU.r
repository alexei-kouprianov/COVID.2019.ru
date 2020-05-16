wc <- read.csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv", h=TRUE)

w.ls <- NULL
w.ls <- as.list(w.ls)

for(i in 1:length(levels(wc$Country.Region))){
w.ls[[i]] <- t(subset(wc, wc$Country.Region == levels(wc$Country.Region)[i])[,c(5:ncol(wc))])
}

names(w.ls) <- gsub(" ", "_", levels(wc$Country.Region))

w.ls.c <- NULL

for(i in 1:length(levels(wc$Country.Region))){
w.ls.c <- c(w.ls.c, dim(w.ls[[i]])[2])
}

w.ls.c