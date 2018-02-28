 cat RC_2006-12 | jq -c '
 { index: {_index: "comments", _type: "redditcomments" } },.
 ' > test.json 
