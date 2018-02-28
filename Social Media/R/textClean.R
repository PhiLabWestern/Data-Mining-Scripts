#from  thinktostart.com
clean.text <- function(some_txt)
{
  some_txt = gsub("&amp", "", some_txt)

  some_txt = gsub("(RT|via)((?:\b\\W*@\\w+)+)", "", some_txt)

  some_txt = gsub("@\\w+", "", some_txt)

  some_txt = gsub("[[:punct:]]", "", some_txt)

  some_txt = gsub("[[:digit:]]", "", some_txt)

  some_txt = gsub("http\\w+", "", some_txt)

  some_txt = gsub("[ t]{2,}", "", some_txt)

  some_txt = gsub("^\\s+|\\s+$", "", some_txt)

  #from nasssimhaddad non-ascii.R github.
  some_txt <- gsub("[^\x20-\x7E]", "", some_txt)

  #Remove all non alphanumeric or spaces
  some_txt <- gsub("[^[:alnum:][:space:][:punct]]", "", some_txt)


  #To-do: Add a space before https and after \n.
  #Remove \n

  # define "tolower error handling" function

  try.tolower = function(x)

  {

    y = NA

    try_error = tryCatch(tolower(x), error=function(e) e)

    if (!inherits(try_error, "error"))

      y = tolower(x)

    return(y)

  }

  some_txt = sapply(some_txt, try.tolower)

  some_txt = some_txt[some_txt != ""]

  names(some_txt) = NULL

  return(some_txt)

}
