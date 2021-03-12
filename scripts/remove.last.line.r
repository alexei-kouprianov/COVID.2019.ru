for(i in 5:length(covid.2019.ru.dyn.tot.primary)){
covid.2019.ru.dyn.tot.primary[[i]] <- covid.2019.ru.dyn.tot.primary[[i]][1:(nrow(covid.2019.ru.dyn.tot.primary[[i]])-1),]
}
