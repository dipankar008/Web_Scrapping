library(rvest)
library(ggplot2)
library(lubridate)
library(dplyr)

page1 <- "http://www.nfl.com/stats/categorystats?tabSeq=0&statisticCategory=PASSING&conference=null&season=2014&seasonType=PRE&d-447263-s=PASSING_YARDS&d-447263-o=2&d-447263-n=1"
page2 <- "http://www.nfl.com/stats/categorystats?tabSeq=0&season=2014&seasonType=PRE&d-447263-n=1&d-447263-o=2&d-447263-p=2&conference=null&statisticCategory=PASSING&d-447263-s=PASSING_YARDS"
page3 <- "http://www.nfl.com/stats/categorystats?tabSeq=0&season=2014&seasonType=PRE&d-447263-n=1&d-447263-o=2&statisticCategory=PASSING&conference=null&d-447263-p=3&d-447263-s=PASSING_YARDS"

p1 <- page1 %>%
        read_html() %>%
        html_nodes(xpath = '//*[@id="result"]') %>%
        html_table()
p1 <- p1[[1]]

p2 <- page2 %>%
        read_html() %>%
        html_nodes(xpath = '//*[@id="result"]') %>%
        html_table()
p2 <- p2[[1]]

p3 <- page3 %>%
        read_html() %>%
        html_nodes(xpath = '//*[@id="result"]') %>%
        html_table()
p3 <- p3[[1]]

data <- rbind(p1,p2,p3)

### Create a dot plot to show the top 10 players using the rate variable 
data %>%
  arrange(desc(Rate)) %>%
  head(10) %>%
  ggplot(aes(x=reorder(Player, Rate), y = Rate)) +
  geom_point() +
  coord_flip() +
  xlab("Player Name")

##### wikipedia

population <- "https://en.wikipedia.org/wiki/List_of_countries_and_dependencies_by_population"

pop <- population %>%
        read_html() %>%
        html_nodes(xpath = '//*[@id="mw-content-text"]/div/table[2]') %>%
        html_table()
pop <- pop[[1]]

library(stringr)

#pop$Population <- as.numeric(gsub(",","",pop$Population))

pop$Population <- as.numeric(str_replace_all(pattern = ",",replacement = "", string = pop$Population))

pop_world <- sum(pop$Population)

### Change date to readable date by R

pop$Date <- mdy(pop$Date)

fruits <- c(
  "apples and oranges and pears and bananas",
  "pineapples and mangos and guavas"
)

str_split(fruits, " and ")
str_split(fruits, " and ", simplify = TRUE)

# Specify n to restrict the number of possible matches
str_split(fruits, " and ", n = 3)
str_split(fruits, " and ", n = 2)
# If n greater than number of pieces, no padding occurs
str_split(fruits, " and ", n = 5)

# Use fixed to return a character matrix
str_split_fixed(fruits, " and ", 3)
str_split_fixed(fruits, " and ", 4)


