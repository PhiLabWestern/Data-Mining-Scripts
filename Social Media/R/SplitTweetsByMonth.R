#Script for taking a large file of tweets and splitting it by a day (Not month). Months can be adapted from the code here.
#Future extensions would include changing it to take the filename from the command line.

#Native tweet JSON isn't a valid format so change it to one.
TweetFrame$created_at <- as.Date(TweetFrame$created_at, "%a %b %d %X %z %Y")
TFByMonth <- split(TweetFrame, format(TweetFrame$created_at, "%Y-%m"))