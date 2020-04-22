################################################################
# Loading libraries, setting locale for time, reading data
 
source("covid.2019.ru.data_loader.r")

################################################################
# Running analytic and plotting scripts

source("covid.2019.ru.data_transformations.r")
source("covid.2019.ru.plots.r")
source("covid.2019.ru.growth.models.r")

################################################################
# Previewing some results (optional)

# covid.2019.ru.i.reg.df
# covid.2019.ru.i.reg.ordered.df
# covid.2019.ru.i.reg.ordered.PER.100K.df
# covid.2019.ru.i.dyn.tt
# summary(covid.2019.ru.full.ll.3)
# summary(covid.2019.ru.full.Mos.ll.3)
# summary(covid.2019.ru.full.SPb.ll.3)
# summary(covid.2019.ru.full.RUS.Provinces.ll.3)
