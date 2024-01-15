library(tidyverse)
library(stringi)
d <- dir("fwp_texts")

df <- tibble(
  doc_id = stri_sub(d, 1L, -5L),
  label = stri_extract(d, regex = "\\A[^_]+"),  
  text = map_chr(d, function(v) {
    x <- read_lines(file.path("fwp_texts", v))
    return(paste(x, collapse = " "))
  })
)

df$text <- stri_replace_all(df$text, " ", fixed = "\t")
df$text <- stri_replace_all(df$text, " ", fixed = "\n")

write_delim(df, "fwp_lda.tsv", delim = "\t", col_names = FALSE)

