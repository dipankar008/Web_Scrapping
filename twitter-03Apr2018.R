# Twitter Data

library(twitteR)

#set up twitter authentication

api_key <- "CIWZ0snaup0sVzUjyX2YyYicv"
api_secret <- "yyxosGN1BUHsE25DZXZHnUCF4LKWcZmaTPn8MtQSFTZaTeJl8r"
access_token <- "150512232-7fDwRRakixndQ2yVI13FxxKVpGxVI9xbQo3ScwIl"
access_token_secret <- "2Av7dlo515TkJAuV5j9HLxVbLW4Smd6nVWTDd9Z3toqBF"

setup_twitter_oauth(api_key,api_secret,access_token,access_token_secret)


#### Search for tweets about USC

uscTweets = searchTwitter("USC", n = 100)
uscDf = twListToDF(uscTweets)
uscDf[,1]

### What is USC Marshall Tweeting about
library(tm)
library(stringr)
library(wordcloud)
library(dplyr)
library(ggplot2)

user <- getUser("uscmarshall")
usc <- userTimeline(user, n =1000)
tweets <- twListToDF(usc)

# clean the tweets and then visualize them using a wordcloud

nohandles <- str_replace_all(tweets$text, pattern = "@\\w+", replacement = "")

wordCorpus <- Corpus(VectorSource(nohandles)) %>%
  tm_map(removePunctuation) %>%
  tm_map(content_transformer(tolower)) %>%
  tm_map(removeWords, stopwords("english")) %>%
  tm_map(stripWhitespace)

set.seed(100)
wordcloud(words = wordCorpus,
          random.order = F,
          col = "red")

### Sentiment analysis for USC Marshall Tweets

library(syuzhet)

uscSentiment <- get_nrc_sentiment(tweets$text)

mySentiment <- data.frame(count = apply(uscSentiment, MARGIN = 2, FUN = sum))
mySentiment$emotion <- rownames(mySentiment)
mySentiment %>%
  ggplot(aes(x= reorder(emotion, count), y= count)) +
  geom_col()



