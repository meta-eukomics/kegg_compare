library(readr)
library(ComplexUpset)

input_files <- list.files(pattern="*[0-9]*.tsv")
cag_list <- lapply(input_files, read_tsv)

cag_list_unique <- lapply(cag_list, function(x) unique(x$KO))

universe <- unique(unlist(cag_list_unique))

upset_data <- as.data.frame(sapply(cag_list_unique, function(x) universe %in% x))
rownames(upset_data) <- universe

upset(upset_data,
      names(upset_data),
      min_size = 10
)
