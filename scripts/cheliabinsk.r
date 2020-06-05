AGE <- read.table("../downloads/cheliabinsk.AGE.txt", sep="\t", blank.lines.skip = FALSE)
CONDITION <- read.table("../downloads/cheliabinsk.CONDITION.txt", sep="\t", blank.lines.skip = FALSE)
COUNT <- read.table("../downloads/cheliabinsk.COUNT.txt", sep="\t", blank.lines.skip = FALSE)
COUNT1 <- read.table("../downloads/cheliabinsk.COUNT1.txt", sep="\t", blank.lines.skip = FALSE)
NAME <- read.table("../downloads/cheliabinsk.NAME.txt", sep="\t", blank.lines.skip = FALSE)
RECOVERED <- read.table("../downloads/cheliabinsk.RECOVERED.txt", sep="\t", blank.lines.skip = FALSE)
SOURCE <- read.table("../downloads/cheliabinsk.SOURCE.txt", sep="\t", blank.lines.skip = FALSE)

CONDITION$V1 <- gsub("^ ", "", CONDITION$V1)
CONDITION$V1 <- gsub("^К", "к", CONDITION$V1)
CONDITION$V1 <- gsub("^Л", "л", CONDITION$V1)
CONDITION$V1 <- gsub("^С", "с", CONDITION$V1)
CONDITION$V1 <- gsub("^Т", "т", CONDITION$V1)
CONDITION$V1 <- gsub("^У", "у", CONDITION$V1)
CONDITION$V1 <- gsub(",", "", CONDITION$V1)
CONDITION$V1 <- factor(CONDITION$V1, levels=c(
"клиники нет", 
"легкая", 
"средняя", 
"тяжелая", 
"крайне тяжелая", 
"тяжелая орит", 
"тяжелая ивл", 
"выбыл", 
"уточняется"))

RECOVERED$V1 <- gsub("^В", "в", RECOVERED$V1)
RECOVERED$V1 <- gsub("^П", "п", RECOVERED$V1)
RECOVERED$V1 <- gsub("^У", "у", RECOVERED$V1)
RECOVERED$V1 <- factor(RECOVERED$V1, levels=c(
"выписан", "продолжает лечение", "умер", "выбыл", "уточняется"
))

SOURCE$V1 <- gsub("^ ", "", SOURCE$V1)
SOURCE$V1 <- gsub("^Кон", "кон", SOURCE$V1)
SOURCE$V1 <- gsub("Москв.", "Москва", SOURCE$V1)
SOURCE$V1 <- gsub("^Не ", "не ", SOURCE$V1)
SOURCE$V1 <- gsub("^При", "при", SOURCE$V1)
SOURCE$V1 <- gsub("Респ", "респ", SOURCE$V1)
SOURCE$V1 <- gsub("тен", "тный", SOURCE$V1)
SOURCE$V1 <- gsub("^Уто", "уто", SOURCE$V1)

ch <- cbind.data.frame(NAME, 
AGE, 
CONDITION, 
SOURCE, 
RECOVERED)

colnames(ch) <- c(
"TIMESTAMP", 
"NAME", 
"COUNT.ORIG", 
"COUNT.MINE", 
"AGE", 
"CONDITION", 
"SOURCE", 
"RECOVERED")

write.table(ch, "../data/cheliabinsk.current.txt", sep="\t", row.names=FALSE)
