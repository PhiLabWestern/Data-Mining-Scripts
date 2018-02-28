#Script for taking a large file of tweets and splitting it by a day (Not month). Months can be adapted from the code here.
#Future extensions would include changing it to take the filename from the command line.

#Native tweet JSON isn't a valid format so change it to one.

#Requires an existing dataframe of tweets called TwtFrame

ExtractedTweets$created_at <- as.Date(ExtractedTweets$created_at, "%a %b %d %X %z %Y")

ExtTwtFrameByDay <- split(ExtractedTweets, ExtractedTweets$created_at);

#London should have about 27% of the tweets that Ottawa has.
#Currently we have 93% of the tweets we'd expect by population alone.

