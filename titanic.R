library(tidyverse)

#Reading in my Titanic data
titan <- read_csv("titanic3.csv")

#Port of Embarkation
titan$embarked[is.na(titan$embarked) == T] <- "s"

#Age
titan$age[is.na(titan$age) == T] <- mean(titan$age, na.rm = T)

#Lifeboat
titan$boat[is.na(titan$boat) == T] <- "none"

#Cabin
titan <- mutate(titan,
                has_cabin_number = as.numeric(is.na(cabin) == F))

write.csv(titan,file"titanic_clean.csv")

                