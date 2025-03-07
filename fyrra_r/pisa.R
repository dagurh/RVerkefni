install.packages("dplyr")
library(dplyr)
library(ggplot2)

#Hluti 1

#a
d <- read.csv("Gögn/pisa.csv", stringsAsFactors = FALSE)

#b
d <- d %>% filter(year >= 2003)

#c
d <- d %>% mutate(mean_grade = rowMeans(select(., math, read, science), na.rm = TRUE))

#d
table(d$country)

#e
d <- d %>% filter(country %in% c("ISL", "DNK", "NOR"))

#f
str(d)

d$year <- as.factor(d$year)
d$country <- as.factor(d$country)

str(d)

#g
d$country <- recode(d$country, "ISL" = "Ísland", "DNK" = "Danmörk", "NOR" = "Noregur")

#Hluti 2

#h
island <- d %>% filter(d$country == "Ísland")

ggplot(island, aes(x = math)) +
  geom_histogram(binwidth = 10, fill = "lightblue", color = "black") +
  labs(title = "Einkunnir í stærðfræði meðal íslenskra nemenda",
       x = "Stærðfræðieinkunn",
       y = "Fjöldi nemenda") +
  theme_minimal()
#miðlæg dreifing, stór hluti nemenda nálægt miðgildi sem er í kringum 520

#i
ggplot(d, aes(x = country, y = math, fill = country)) +
  geom_boxplot() +
  labs(title = "Stærðfræðieinkunnir eftir löndum",
       x = "Lönd",
       y = "Stærðfræðieinkunn") +
  theme_minimal()
#Ísland er með hæsta miðgildið, danmörk með bestu útlægur og þrengri 25-75%

#j
ggplot(d, aes(x = country, y = math, fill = country)) +
  geom_boxplot() +
  facet_wrap(~ year) +
  labs(title = "Stærðfræðieinkunnir eftir löndum og árum",
       x = "Lönd",
       y = "Stærðfræðieinkunn") +
  theme_minimal()
#Noregur stendur sig betur og betur gagnvart hinum löndunum með tímanum
#En yfir allt fer öllum löndum versnandi (mesti niðurdúrinn frá 2018 til 2022)

#k
ggplot(island, aes(x = math, y = science)) +
  geom_point(color = "blue", size = 2, alpha = 0.7) +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  labs(title = "Samband milli stærðfræðieinkunna og vísindaeinkunna",
       x = "Stærðfræðieinkunn",
       y = "Vísindaeinkunn") +
  theme_minimal()
#myndritið sýnir að það er samræmi milli árangurs í stærfræði og vísindum


#l
ggplot(d, aes(x = country, fill = mother_educ)) +
  geom_bar(position = "dodge") +
  labs(title = "Menntun móðir nemenda eftir löndum",
       x = "Lönd",
       y = "Fjöldi nemenda",
       fill = "Menntun móðir nemanda") +
  theme_minimal()
#Myndritið ber saman fjölda nemenda eftir menntunarstig mæðra í hverju landi

#m
ggplot(d, aes(x = math, y = read)) +
  geom_point(color = "blue", alpha = 0.7) +
  labs(title = "Samband milli stærðfræðieinkunna og lestrareinkunna",
       x = "Stærðfræðieinkunn",
       y = "Lestrareinkunn") +
  theme_minimal()
