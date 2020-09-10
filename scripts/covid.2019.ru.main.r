################################################################
# Loading libraries, setting locale for time, reading data

source("covid.2019.ru.libraries.r")
source("covid.2019.ru.data_loader.r")

################################################################
# Running analytic and plotting scripts

source("covid.2019.ru.data_transformations.r")
render("../Rmd/daily.report.Rmd")
# render("../Rmd/daily.report.Rmd", run_pandoc=FALSE, clean=FALSE)
# don't forget running 
# $ pandoc daily.report.utf8.md -o daily.report.utf8.html
# from ../Rmd folder;
source("covid.2019.ru.plots.r")
source("covid.2019.ru.growth.models.r")
source("covid.2019.world.JHU.r")

################################################################
# Re-running libraries() and render() when the data grows big

# save.image() # and quit, then re-enter and run:

source("covid.2019.ru.libraries.r")
render("../Rmd/daily.report.Rmd")

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
# subset(covid.2019.ru.i.reg.df, covid.2019.ru.i.reg.df$CS.i.diff.7.2log < 4)[,c(8,9,11)]
# subset(covid.2019.ru.i.reg.df, covid.2019.ru.i.reg.df$CS.i.diff.7.2log > 14)[,c(8,9,11)]
# rmc.SPb.20200418_202005__.df
# rmc.20200421_202005__.RUS.Prov.df
# rmc.20200421_202005__.Mos.df
incr.abs.t
dt.worst
dt.best
