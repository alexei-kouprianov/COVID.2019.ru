setwd("/home/tinea/Documents/H_et_S/Projects/github/COVID.2019.ru/scripts/")

daily.data.raw <- fromJSON(file="/home/tinea/Documents/H_et_S/Projects/github/COVID.2019.ru/downloads/stopcoronavirus.storage.moment.20200429.json")
daily.timestamp <- read.table("/home/tinea/Documents/H_et_S/Projects/github/COVID.2019.ru/downloads/stopcoronavirus.timestamp.moment.20200429.txt")

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

increment.df.0 <- subset(increment.df, increment.df$NUMBER > 0)

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
