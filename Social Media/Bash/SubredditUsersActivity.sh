#!/bin/bash

#Brent Davis January 30th 2018

eval ls /mnt/f/Data/RedditSubmissions/RS_{$startYear..$endYear}* > submissionsFiles
eval ls /mnt/f/Data/RedditComments/RC_{$startYear..$endYear}* > commentsFiles
