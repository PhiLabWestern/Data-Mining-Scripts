#!/bin/bash

#Select a range to be included in the processing...
startYear=$1
endYear=$2
#startMonth = $3
#endMonth = $4
#echo $startYear
#echo $endYear

#This is hard-coded to a directory of reddit comments.
#Change /mnt/f/Data/RedditComments/*/RC_ to DATA_PATH/<prefix if desired>
#There is likely a better way then eval ls to store this as temp too.
#eval ls /mnt/f/Data/RedditSubmissions/RS_{$startYear..$endYear}* > temp
#eval ls /mnt/f/Data/RedditComments/RC_{$startYear..$endYear}* >> temp

for ((i=startYear; i<=endYear; i++))
do
  ls /mnt/f/Data/RedditComments/$i/* >> tempcom
  ls /mnt/f/Data/RedditSubmissions/$i/* >> tempsub
done

cat tempcom tempsub > temp

#Diagnostic if you want to see what is being found by the search.
#cat temp

while read p;
do
    #Extract file.
    echo "Extracting " $p
    t=$(basename $p | cut -f 1 -d '.')

    #This checks to see if the extraction has been done previously.
    if [ ! -f $t ];
    then
      dtrx $p
    else
      echo "Archive already locally extracted"
    fi

    #This matches the text 'subreddit:londonontario'. It's possible but highly unlikely this is in the body of a comment or submission.
    sed -n -e '/"subreddit":"londonontario"/p' $t > $t.subreddit.txt

done < temp


#Extracts the author field from the json, passes it to sort, and then removes all duplicated author names.
jq '.author' *.subreddit.txt | sort | uniq > LondonUsers$startYear-$endYear.txt

#remove the bot users from the user list.
sed -i -e '/bot"$/d' LondonUsers$startYear-$endYear.txt
sed -i '/AutoModerator"$/d' LondonUsers$startYear-$endYear.txt

#This loop takes every author found in the subreddit search and extracts their posts over the same time period.
while read p;
do
      t=$(basename $p | cut -f 1 -d '.')
      #This redirects the sed output as the grep input. It formats the user list to match the json formatting.
      grep -f <(sed 's/.*/"author":&/' LondonUsers$startYear-$endYear.txt) $t > $t.userActivity
done < tempcom

#The JSON for the comments and the submissions has different fields, which is problematic for loading into R.
while read p;
do
      t=$(basename $p | cut -f 1 -d '.')
      #This redirects the sed output as the grep input. It formats the user list to match the json formatting.
      grep -f <(sed 's/.*/"author":&/' LondonUsers$startYear-$endYear.txt) $t > $t.userActivity
done < tempsub

cat *.userActivity > $startYear-$endYear.userActivity.json

#Away to do all of this inline would be ideal.
sed -i 's/$/,/' $startYear-$endYear.userActivity.json
echo "[" > [.add
echo "]" > ].add
cat \[.add $startYear-$endYear.userActivity.json ].add > $startYear-$endYear.userActivity.json.tmp
sed -i 'x;${s/,$//;p;x;};1d' $startYear-$endYear.userActivity.json.tmp
rm $startYear-$endYear.userActivity.json
mv $startYear-$endYear.userActivity.json.tmp $startYear-$endYear.userActivity.json

#cleaning up files.
rm temp

#Extract to usr2vec input. #NEEDS TO BE MADE GENERIC.
jq -r '"\(.author)-R \(.body)"' authorsortedRC_2016-08-LdnUserActivity.json > authorSortedauthor-space-text-Aug2016RC.sdm
cat *.sdm > usr2vecbuilddata.sdm.temp
awk 'NF>=5' usr2vecbuilddata.sdm.temp > usr2vecbuilddata.sdm

#Need to pass into R to remove the \n's and then write to file. Can't think of good sed or awk command to replace all but the real \n.
iconv -f utf-8 -t utf-8 -c file.txt #<- Also needed.

#To do.
#Turn urls into just 'url'
#Add a space before and after every '.', ',', '!', etc.
#Convert numbers to NUMBER


rm usr2vecbuilddata.sdm.temp
