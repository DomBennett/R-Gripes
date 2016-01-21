# D.J. Bennett
# Compilation of R annoyances and their solutions

# EXTRACTING A VECTOR FROM A DATAFRAME OF CHARACTERS
# --- Problem ---
row.element <- 1:5
numbers.df <- data.frame (c1=rep (1, 5),
                          c2=rep (2, 5),
                          c3=rep (3, 5),
                          c4=rep (4, 5),
                          c5=rep (5, 5))
all (row.element %in% numbers.df[1,])
# simple data frame of letters and an example of one of the rows
row.element <- c ('a', 'b', 'c', 'd', 'e')
letters.df <- data.frame (c1=rep ('a', 5),
                          c2=rep ('b', 5),
                          c3=rep ('c', 5),
                          c4=rep ('d', 5),
                          c5=rep ('e', 5))
# but the row.element doesn't match!
all (row.element %in% letters.df[1,])  # FALSE!
# let's try converting to a character vector ....
as.character (as.vector (letters.df[1, ]))  # No, list of 1s
all (row.element %in% as.character (as.vector (letters.df[1, ]))) 
# --- Solution 1 ---
# OK.... let's try dropping the data.frame class,
#  unlist the resulting list object and then convert to character
# (By default, [] preserve the data.frame class even though its a single row)
res <- as.character (unlist (letters.df[1, ,drop=TRUE]))
all (row.element %in% res)  # Success! Isn't that simple?
# --- Solution 2 ---
# the real problem is the dataframe works with factors (i.e. a vector with levels)
# if we stop this behaviour when creating the dataframe we should have a vector
letters.df <- data.frame (c1=rep ('a', 5),
                          c2=rep ('b', 5),
                          c3=rep ('c', 5),
                          c4=rep ('d', 5),
                          c5=rep ('e', 5),
                          stringsAsFactors=FALSE)
all (row.element %in% letters.df[1,])  # TRUE!

# USING THE $ SIGN
# Here is a list
mylst <- list("apple"=1, "pear"=3, "orange"=5, "orangerie"=10)
# We can extract elements of that list using the $
mylst$apple
# But did you know you could extract those elements also with the beginning of
#  the slot name, so long as its unique?
mylst$a  # works
mylst$o  # doesn't work because two slots begin with an o
# This is great, it saves typing.... but, it can cause unexpected, albeit rare, errors
# One such example is if I were looping through multiple lists and I first wanted to check
# if the the list had a value for the slot name, I might do this like...
!is.null(mylst$apple)
# This works except in the sitatuation where my lists my contain orange and not orangerie
!is.null(mylst$orange)
# The above example would always return TRUE, even if there was no orange in the list
# A way to avoid this is to use [['']]
!is.null(mylst[-3][['orange']])
# Now we get false, which is what we'd expect.
# So the lesson here is the $ sign is useful but can be dangerous. I'd always suggest to use
# [['']] indexing within functions to avoid this potential issue with autocomplete