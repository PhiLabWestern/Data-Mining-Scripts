#This is an R-Script to demonstrate the 'growing' of a social network from available twitter data.
#If editing any time values, make sure to check on twitter api rate limits for the RESTFUL API.
#Authentication in this script is from the Health Informatics Bottica app.

library(twitteR)

# Set up authentication.
setup_twitter_oauth("W2ZNXfGtQvpLEN6KXfUDn0L5I","OHDsbWKqqgxIR91zrcgayIZcwsy2k01lafiUb8clP0r6GDQmVB","436152964-9YDf6Y0I457k4EdZS6G8V921ma62VWiqZBDDDjcW","1RjiJMOmR8Oi39hjoSzSewQqzvA42DmE2qFE4tStYsfOi");

#Load in the list of people already in the network.
#This is, in our case, already FAR more then this loop will get through in a reasonable amount of time.
collectedNames <- scan("UniqueLondonandAreausers.txt",what=character());

#Get a list of 100 users.
userList <- lookupUsers(collectedNames[1:100])

for (user in userList){
  
  
  
  
}

