library(rjson)

daily.data.raw <- fromJSON(file="../downloads/stopcoronavirus.storage.moment.20200429.json")
daily.timestamp <- read.table("../downloads/stopcoronavirus.timestamp.moment.20200429.txt")
loci <- read.table("../misc/loci.txt", h=TRUE, sep="\t")
covid.2019.ru <- read.table("../data/momentary.txt", h=TRUE, sep="\t")

title <- NULL
code <- NULL
is_city <- NULL
coord_x <- NULL
coord_y <- NULL
sick <- NULL
healed <- NULL
died <- NULL
sick_incr <- NULL
healed_incr <- NULL
died_incr <- NULL

for(i in 1:length(daily.data.raw)){
title <- c(title, daily.data.raw[[i]]$title)
code <- c(code, daily.data.raw[[i]]$code)
is_city <- c(is_city, daily.data.raw[[i]]$is_city)
coord_x <- c(coord_x, daily.data.raw[[i]]$coord_x)
coord_y <- c(coord_y, daily.data.raw[[i]]$coord_y)
sick <- c(sick, daily.data.raw[[i]]$sick)
healed <- c(healed, daily.data.raw[[i]]$healed)
died <- c(died, daily.data.raw[[i]]$died)
sick_incr <- c(sick_incr, daily.data.raw[[i]]$sick_incr)
healed_incr <- c(healed_incr, daily.data.raw[[i]]$healed_incr)
died_incr <- c(died_incr, daily.data.raw[[i]]$died_incr)
}

daily.data.raw.df <- data.frame(
title,
code, 
is_city,
coord_x, 
coord_y, 
sick, 
healed, 
died, 
sick_incr, 
healed_incr, 
died_incr
)

daily.data.raw.df.s <- daily.data.raw.df[order(daily.data.raw.df$title),]

cumulated.df <- data.frame(
rep(daily.timestamp$V1, nrow(daily.data.raw.df.s)*3),
c(rep("detected", nrow(daily.data.raw.df.s)),
rep("recovered", nrow(daily.data.raw.df.s)),
rep("deceased", nrow(daily.data.raw.df.s))
),
rep(daily.data.raw.df.s$title, 3), 
c(daily.data.raw.df.s$sick, daily.data.raw.df.s$healed, daily.data.raw.df.s$died)
)

colnames(cumulated.df) <- c("TIMESTAMP", "STATUS", "REGION", "NUMBER")

increment.df <- data.frame(
rep(daily.timestamp$V1, nrow(daily.data.raw.df.s)*3),
c(rep("detected", nrow(daily.data.raw.df.s)),
rep("recovered", nrow(daily.data.raw.df.s)),
rep("deceased", nrow(daily.data.raw.df.s))
),
rep(daily.data.raw.df.s$title, 3), 
c(daily.data.raw.df.s$sick_incr, daily.data.raw.df.s$healed_incr, daily.data.raw.df.s$died_incr)
)

colnames(increment.df) <- c("TIMESTAMP", "STATUS", "REGION", "NUMBER")

increment.df.0 <- increment.df[order(increment.df$REGION, increment.df$STATUS),]
increment.df.0 <- cbind.data.frame(increment.df.0, loci)
increment.df.0 <- increment.df.0[,c(1,2,5,6,3,4)]
increment.df.0 <- subset(increment.df.0, increment.df.0$NUMBER > 0)
increment.df.0 <- increment.df.0[order(increment.df.0$STATUS, -increment.df.0$NUMBER),]

colnames(increment.df.0) <- c("TIMESTAMP", "EVENT", "LOCUS.0", "LOCUS", "LOCUS.ORIG", "NUMBER")

increment.df.0$UID <- NA
increment.df.0$ORIGIN <- NA
increment.df.0$SRC <- "https://стопкоронавирус.рф/ robot-trimmed and post-processed"
increment.df.0$COMMENT <- NA
increment.df.0$DB.OPERATOR <- "Alexei Kouprianov"

covid.2019.ru <- rbind.data.frame(covid.2019.ru, increment.df.0)

write.table(covid.2019.ru, "../data/momentary.txt", row.names=FALSE, sep="\t")
write.table(increment.df, "../downloads/increment.txt", row.names=FALSE, sep="\t")
write.table(increment.df.0, "../downloads/increment.0.txt", row.names=FALSE, sep="\t")

# title
# code
# is_city
# coord_x
# coord_y
# sick
# healed
# died
# sick_incr
# healed_incr
# died_incr
