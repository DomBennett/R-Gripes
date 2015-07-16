# D.J. Bennett
# Compilation of R annoyances and their solutions

# EXTRACTING A VECTOR FROM A DATAFRAME OF CHARACTERS
# --- Problem ---
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