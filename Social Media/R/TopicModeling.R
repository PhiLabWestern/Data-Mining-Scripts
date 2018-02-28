##Adapted from: https://gist.github.com/bryangoodrich/7b5ef683ce8db592669e
## Used to perform topic modeling on our topics.


##Currently I label whatever I want as tweets and copy and paste this code in the console.
#I should make it into a function soon that just takes input and runs it.


##See original post for full documentation. This is for personal convenience of not loading the webpage each time.

# Here we pre-process the data in some standard ways. I'll post-define each step
tweets <- iconv(tweets, to = "ASCII", sub = " ")  # Convert to basic ASCII text to avoid silly characters
tweets <- tolower(tweets)  # Make everything consistently lower case
tweets <- gsub("rt", " ", tweets)  # Remove the "RT" (retweet) so duplicates are duplicates
tweets <- gsub("@\\w+", " ", tweets)  # Remove user names (all proper names if you're wise!)
tweets <- gsub("http.+ |http.+$", " ", tweets)  # Remove links
tweets <- gsub("[[:punct:]]", " ", tweets)  # Remove punctuation
tweets <- gsub("[ |\t]{2,}", " ", tweets)  # Remove tabs
tweets <- gsub("amp", " ", tweets)  # "&" is "&amp" in HTML, so after punctuation removed ...
tweets <- gsub("^ ", "", tweets)  # Leading blanks
tweets <- gsub(" $", "", tweets)  # Lagging blanks
tweets <- gsub(" +", " ", tweets) # General spaces (should just do all whitespaces no?)
tweets <- unique(tweets)  # Now get rid of duplicates!



# Convert to tm corpus and use its API for some additional fun
corpus <- Corpus(VectorSource(tweets))  # Create corpus object

# Remove English stop words. This could be greatly expanded!
# Don't forget the mc.cores thing
corpus <- tm_map(corpus, removeWords, stopwords("en"), mc.cores=1)  

# Remove numbers. This could have been done earlier, of course.
corpus <- tm_map(corpus, removeNumbers, mc.cores=1)

# Stem the words. Google if you don't understand
corpus <- tm_map(corpus, stemDocument, mc.cores=1)

# Remove the stems associated with our search terms!
corpus <- tm_map(corpus, removeWords, c("energi", "electr"), mc.cores=1)



# Why not visualize the corpus now?
# Mine had a lot to do with {solar, power, renew, new, can, save, suppl, wind, price, use}
pal <- brewer.pal(8, "Dark2")
wordcloud(corpus, min.freq=2, max.words = 150, random.order = TRUE, col = pal)



doc.lengths <- rowSums(as.matrix(DocumentTermMatrix(corpus)))
dtm <- DocumentTermMatrix(corpus[doc.lengths > 0])
# model <- LDA(dtm, 10)  # Go ahead and test a simple model if you want



# Now for some topics
SEED = sample(1:1000000, 1)  # Pick a random seed for replication
k = 10  # Let's start with 10 topics

# This might take a minute!
models <- list(
  CTM       = CTM(dtm, k = k, control = list(seed = SEED, var = list(tol = 10^-4), em = list(tol = 10^-3))),
  VEM       = LDA(dtm, k = k, control = list(seed = SEED)),
  VEM_Fixed = LDA(dtm, k = k, control = list(estimate.alpha = FALSE, seed = SEED)),
  Gibbs     = LDA(dtm, k = k, method = "Gibbs", control = list(seed = SEED, burnin = 1000,
                                                               thin = 100,    iter = 1000))
)