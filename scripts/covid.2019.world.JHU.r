# Loading data from COVID-19 Data Repository by the Center for Systems Science and Engineering (CSSE) at Johns Hopkins University

w.confirmed <- read.csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv", h=TRUE)
w.deaths <- read.csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv", h=TRUE)
w.recovered <- read.csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_recovered_global.csv", h=TRUE)

# Setting month boundaries;

rect.width <- c(0,10,29,31,30,31,30,31,31,30,31,30,31)

# Extracting confirmed cases;

w.confirmed.ls <- NULL
w.confirmed.ls <- as.list(w.confirmed.ls)

for(i in 1:length(levels(w.confirmed$Country.Region))){
w.confirmed.ls[[i]] <- t(subset(w.confirmed, w.confirmed$Country.Region == levels(w.confirmed$Country.Region)[i])[,c(5:ncol(w.confirmed))])
colnames(w.confirmed.ls[[i]]) <- subset(w.confirmed, w.confirmed$Country.Region == levels(w.confirmed$Country.Region)[i])[,1]
}

names(w.confirmed.ls) <- gsub(" ", "_", levels(w.deaths$Country.Region))

# Extracting deaths;

w.deaths.ls <- NULL
w.deaths.ls <- as.list(w.deaths.ls)

for(i in 1:length(levels(w.deaths$Country.Region))){
w.deaths.ls[[i]] <- t(subset(w.deaths, w.deaths$Country.Region == levels(w.deaths$Country.Region)[i])[,c(5:ncol(w.deaths))])
colnames(w.deaths.ls[[i]]) <- subset(w.deaths, w.deaths$Country.Region == levels(w.deaths$Country.Region)[i])[,1]
}

names(w.deaths.ls) <- gsub(" ", "_", levels(w.deaths$Country.Region))

# Extracting recovered;

w.recovered.ls <- NULL
w.recovered.ls <- as.list(w.recovered.ls)

for(i in 1:length(levels(w.recovered$Country.Region))){
w.recovered.ls[[i]] <- t(subset(w.recovered, w.recovered$Country.Region == levels(w.recovered$Country.Region)[i])[,c(5:ncol(w.recovered))])
colnames(w.recovered.ls[[i]]) <- subset(w.recovered, w.recovered$Country.Region == levels(w.recovered$Country.Region)[i])[,1]
}

names(w.recovered.ls) <- gsub(" ", "_", levels(w.recovered$Country.Region))

################################################################
# Experimental plots
################################################################

#     levels(w.confirmed$Country.Region)
# 1                          Afghanistan
# 2                              Albania
# 3                              Algeria
# 4                              Andorra
# 5                               Angola
# 6                  Antigua and Barbuda
# 7                            Argentina
# 8                              Armenia
# 9                            Australia
# 10                             Austria
# 11                          Azerbaijan
# 12                             Bahamas
# 13                             Bahrain
# 14                          Bangladesh
# 15                            Barbados
# 16                             Belarus
# 17                             Belgium
# 18                              Belize
# 19                               Benin
# 20                              Bhutan
# 21                             Bolivia
# 22              Bosnia and Herzegovina
# 23                            Botswana
# 24                              Brazil
# 25                              Brunei
# 26                            Bulgaria
# 27                        Burkina Faso
# 28                               Burma
# 29                             Burundi
# 30                          Cabo Verde
# 31                            Cambodia
# 32                            Cameroon
# 33                              Canada
# 34            Central African Republic
# 35                                Chad
# 36                               Chile
# 37                               China
# 38                            Colombia
# 39                             Comoros
# 40                 Congo (Brazzaville)
# 41                    Congo (Kinshasa)
# 42                          Costa Rica
# 43                       Cote d'Ivoire
# 44                             Croatia
# 45                                Cuba
# 46                              Cyprus
# 47                             Czechia
# 48                             Denmark
# 49                    Diamond Princess
# 50                            Djibouti
# 51                            Dominica
# 52                  Dominican Republic
# 53                             Ecuador
# 54                               Egypt
# 55                         El Salvador
# 56                   Equatorial Guinea
# 57                             Eritrea
# 58                             Estonia
# 59                            Eswatini
# 60                            Ethiopia
# 61                                Fiji
# 62                             Finland
# 63                              France
# 64                               Gabon
# 65                              Gambia
# 66                             Georgia
# 67                             Germany
# 68                               Ghana
# 69                              Greece
# 70                             Grenada
# 71                           Guatemala
# 72                              Guinea
# 73                       Guinea-Bissau
# 74                              Guyana
# 75                               Haiti
# 76                            Holy See
# 77                            Honduras
# 78                             Hungary
# 79                             Iceland
# 80                               India
# 81                           Indonesia
# 82                                Iran
# 83                                Iraq
# 84                             Ireland
# 85                              Israel
# 86                               Italy
# 87                             Jamaica
# 88                               Japan
# 89                              Jordan
# 90                          Kazakhstan
# 91                               Kenya
# 92                        Korea, South
# 93                              Kosovo
# 94                              Kuwait
# 95                          Kyrgyzstan
# 96                                Laos
# 97                              Latvia
# 98                             Lebanon
# 99                             Lesotho
# 100                            Liberia
# 101                              Libya
# 102                      Liechtenstein
# 103                          Lithuania
# 104                         Luxembourg
# 105                         Madagascar
# 106                             Malawi
# 107                           Malaysia
# 108                           Maldives
# 109                               Mali
# 110                              Malta
# 111                         Mauritania
# 112                          Mauritius
# 113                             Mexico
# 114                            Moldova
# 115                             Monaco
# 116                           Mongolia
# 117                         Montenegro
# 118                            Morocco
# 119                         Mozambique
# 120                         MS Zaandam
# 121                            Namibia
# 122                              Nepal
# 123                        Netherlands
# 124                        New Zealand
# 125                          Nicaragua
# 126                              Niger
# 127                            Nigeria
# 128                    North Macedonia
# 129                             Norway
# 130                               Oman
# 131                           Pakistan
# 132                             Panama
# 133                   Papua New Guinea
# 134                           Paraguay
# 135                               Peru
# 136                        Philippines
# 137                             Poland
# 138                           Portugal
# 139                              Qatar
# 140                            Romania
# 141                             Russia
# 142                             Rwanda
# 143              Saint Kitts and Nevis
# 144                        Saint Lucia
# 145   Saint Vincent and the Grenadines
# 146                         San Marino
# 147              Sao Tome and Principe
# 148                       Saudi Arabia
# 149                            Senegal
# 150                             Serbia
# 151                         Seychelles
# 152                       Sierra Leone
# 153                          Singapore
# 154                           Slovakia
# 155                           Slovenia
# 156                            Somalia
# 157                       South Africa
# 158                        South Sudan
# 159                              Spain
# 160                          Sri Lanka
# 161                              Sudan
# 162                           Suriname
# 163                             Sweden
# 164                        Switzerland
# 165                              Syria
# 166                            Taiwan*
# 167                         Tajikistan
# 168                           Tanzania
# 169                           Thailand
# 170                        Timor-Leste
# 171                               Togo
# 172                Trinidad and Tobago
# 173                            Tunisia
# 174                             Turkey
# 175                             Uganda
# 176                            Ukraine
# 177               United Arab Emirates
# 178                     United Kingdom
# 179                            Uruguay
# 180                                 US
# 181                         Uzbekistan
# 182                          Venezuela
# 183                            Vietnam
# 184                 West Bank and Gaza
# 185                     Western Sahara
# 186                              Yemen
# 187                             Zambia
# 188                           Zimbabwe
# > 

# Creating directories for countries plots;

dir.create("../plots/world/")
dir.create("../plots/world/linear/")
dir.create("../plots/world/ylog10/")

# Excluding Australia, Canada, China, Denmark, France, Netherlands, United Kingdom (they are represented with regions and territories as data.frames);

countries <- c(1:8,10:32,34:36,38:47,49:62,64:122,124:177,179:length(levels(w.confirmed$Country.Region)))

# Plotting loop;

for(j in countries){

# Y-linear plots;

png(paste("../plots/world/linear/COVID-19.TARD.", names(w.confirmed.ls)[j], ".png", sep=""), height=750, width=1000, res=120, pointsize=10)

plot(w.confirmed.ls[[j]], 
type="l", col="darkred", lwd=2, axes=FALSE,
xlab="Days since 2020-01-22",
ylab="Cases",
main=levels(w.confirmed$Country.Region)[j])

for(i in 1:(length(rect.width)-1)){
rect(
xleft=sum(rect.width[1:i]),
xright=sum(rect.width[1:(i+1)]),
ybottom=-100,
ytop=max(w.confirmed.ls[[j]], na.rm=TRUE)*10,
col=rgb(0,0,0,(.05*(i %% 2 != 0))),
border=rgb(0,0,0,(.05*(i %% 2 != 0)))
)
}

lines(2:length(w.confirmed.ls[[j]]), w.confirmed.ls[[j]][2:length(w.confirmed.ls[[j]])] - w.confirmed.ls[[j]][1:(length(w.confirmed.ls[[j]])-1)], type="h", col="darkred", lwd=2)
lines(w.deaths.ls[[j]], col="white", lwd=5)
lines(w.deaths.ls[[j]], col=1, lwd=2)
lines(w.recovered.ls[[j]], col="white", lwd=5)
lines(w.recovered.ls[[j]], col=3, lwd=2)
lines(w.confirmed.ls[[j]]-(w.recovered.ls[[j]]+w.deaths.ls[[j]]), col="white", lwd=5)
lines(w.confirmed.ls[[j]]-(w.recovered.ls[[j]]+w.deaths.ls[[j]]), col=2, lwd=2)

axis(1)
axis(2)

legend("topleft",
lty=1,
lwd=2,
col=c("darkred","red","green","black"),
legend=c("Confirmed (vertical bars = new)","Active","Recovered","Deaths"),
bty="n")

dev.off()

# Y-logarthimic plots;

png(paste("../plots/world/ylog10/COVID-19.TARD.", names(w.confirmed.ls)[j], ".log.10.png", sep=""), height=750, width=1000, res=120, pointsize=10)

plot(log10(w.confirmed.ls[[j]]),
ylim=c(log10(1),log10(max(w.confirmed.ls[[j]], na.rm=TRUE))), 
type="l", col="darkred", lwd=2, axes=FALSE,
xlab="Days since 2020-01-22",
ylab="Cases",
main=levels(w.confirmed$Country.Region)[j])

for(i in 1:(length(rect.width)-1)){
rect(
xleft=sum(rect.width[1:i]),
xright=sum(rect.width[1:(i+1)]),
ybottom=-1,
ytop=max(log10(w.confirmed.ls[[j]]), na.rm=TRUE)*10,
col=rgb(0,0,0,(.05*(i %% 2 != 0))),
border=rgb(0,0,0,(.05*(i %% 2 != 0)))
)
}

lines(2:length(w.confirmed.ls[[j]]), log10(w.confirmed.ls[[j]][2:length(w.confirmed.ls[[j]])] - w.confirmed.ls[[j]][1:(length(w.confirmed.ls[[j]])-1)]), type="h", col="darkred", lwd=2)
lines(log10(w.deaths.ls[[j]]), col="white", lwd=5)
lines(log10(w.deaths.ls[[j]]), col=1, lwd=2)
lines(log10(w.recovered.ls[[j]]), col="white", lwd=5)
lines(log10(w.recovered.ls[[j]]), col=3, lwd=2)
lines(log10(w.confirmed.ls[[j]]-(w.recovered.ls[[j]]+w.deaths.ls[[j]])), col="white", lwd=5)
lines(log10(w.confirmed.ls[[j]]-(w.recovered.ls[[j]]+w.deaths.ls[[j]])), col=2, lwd=2)

axis(1)
axis(2, at=log10(1*10^(0:6)), labels=c(1,10,100,"1K","10K","100K","1M"))
axis(2, at=log10(c(1:9, seq(10,100,10), seq(200,1000,100), seq(2000,10000,1000), seq(20000,100000,10000), seq(200000,1000000,100000), seq(2000000,10000000,1000000))), labels=FALSE)

legend("topleft",
lty=1,
lwd=2,
col=c("darkred","red","green","black"),
legend=c("Confirmed (vertical bars = new)","Active","Recovered","Deaths"),
bty="n")

dev.off()

} # for loop closed;
