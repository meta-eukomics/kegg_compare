library(dplyr)
library(readr)

# Input filename
args = commandArgs(trailingOnly = TRUE)
file = args[1]

# Read in file
results <- read.table(file, comment.char="#", header=F, sep="\t")
names(results) <- c('threshold', 'orf', 'KO', 'thrshld', 'score', 'evalue', 'KO_def')

# Filter by evalue
results <- results[!is.na(results$evalue),]
results <- results %>% filter(evalue < 1e-5)

# Select lowest evalue
# Ignore thresholds for now
output <- results %>%
  group_by(orf) %>%
  slice_min(order_by = evalue, with_ties = FALSE)

# Write output fil
output_file <- gsub("kofam", "kofam_topko", file)
write_tsv(output, output_file)
